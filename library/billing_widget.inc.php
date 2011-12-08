<?php
require_once( "sql.inc" );
require_once( "sl_eob.inc.php" );

function getBillingResult( $pid, array $ignoreCodes = null )
{
	$query = "SELECT f.id, f.pid, f.encounter, f.date, " .
      "f.last_level_billed, f.last_level_closed, f.last_stmt_date, f.stmt_count, " .
      "p.fname, p.mname, p.lname, p.pubpid, p.genericname2, p.genericval2, " .
      "( SELECT SUM(b.fee) FROM billing AS b WHERE " .
      "b.pid = f.pid AND " .
      "b.activity = 1 AND b.code_type != 'COPAY'";
	  if ( $ignoreCodes ) {
	  	foreach ( $ignoreCodes as $code ) {
	  		$query .= " AND b.code != '".$code."'";
	  	}
	  }
      $query .= " ) AS charges, " .
      "( SELECT SUM(b.fee) FROM billing AS b WHERE " .
      "b.pid = f.pid AND " .
      "b.activity = 1 AND b.code_type = 'COPAY' ) AS copays, " .
      "( SELECT SUM(a.pay_amount) FROM ar_activity AS a WHERE " .
      "a.pid = f.pid ) AS payments, " .
      "( SELECT SUM(a.adj_amount) FROM ar_activity AS a WHERE " .
      "a.pid = f.pid ) AS adjustments " .
      "FROM form_encounter AS f " .
      "JOIN patient_data AS p ON p.pid = f.pid " .
      "WHERE f.pid = $pid " .
      "ORDER BY p.lname, p.fname, p.mname, f.pid, f.encounter";
	return sqlStatement( $query );
}

function getBalanceForward( $pid, $code = 'balfwdpt' ) {
	
	$query = "SELECT ( SELECT SUM(b.fee) FROM billing AS b WHERE " .
      "b.pid = '".$pid."' AND " .
      "b.activity = 1 AND b.code_type != 'COPAY' AND b.code = '".$code."' ) AS charges";
	$result = sqlStatement( $query );
	$total = 0;
	while ( $row = sqlFetchArray( $result ) ) {
		$total += $row['charges'];
	}
	
	return $total;
}

function getBalance( $pid, $doInsurance = true )
{
	$balanceForward = 0;
	$result = null;
	if ( $doInsurance ) {
		$result = getBillingResult( $pid, array( 'balfwdpt', 'balfwdins' ) );
		$balanceForward = getBalanceForward( $pid, 'balfwdins' );
	} else {
		$result = getBillingResult( $pid, array( 'balfwdins', 'balfwdpt' ) );
		$balanceForward = getBalanceForward( $pid, 'balfwdpt' );
	}
	while ( $row = sqlFetchArray( $result ) ) {
      $balance = sprintf("%.2f", $row['charges'] + $row['copays'] - $row['payments'] - $row['adjustments']);

      // $duncount was originally supposed to be the number of times that
      // the patient was sent a statement for this invoice.
      //
      $duncount = $row['stmt_count'];

      // But if we have not yet billed the patient, then compute $duncount as a
      // negative count of the number of insurance plans for which we have not
      // yet closed out insurance.
      //
      if (! $duncount) {
        for ($i = 1; $i <= 3 && arGetPayerID($row['pid'], $row['date'], $i); ++$i) ;
        $duncount = $row['last_level_closed'] + 1 - $i;
      }

      $isdueany = ($balance > 0);

      if ( $doInsurance == true ) {
      	// insurance
	      if ( ( $duncount >= 0 || !$isdueany ) ) {
	      	return $balanceForward;
	      } else {
	      	return $balance + $balanceForward;
	      }
      } else {
	      
	      // patient
	      if ( ($duncount <  0 || !$isdueany) ) {
	      	return $balanceForward;
	      } else {
	      	return $balance + $balanceForward;
	      }
      }
	}
}

function getPatientBalance( $pid ) 
{
	return getBalance( $pid, false );
}

function getInsuranceBalance( $pid ) 
{
	return getBalance( $pid, true );
}
