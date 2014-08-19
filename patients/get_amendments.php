<?php

require_once("verify_session.php");

$query = "SELECT a.*,lo.title AS AmendmentBy,lo1.title AS AmendmentStatus FROM amendments a 
	INNER JOIN list_options lo ON a.amendment_by = lo.option_id AND lo.list_id='amendment_from'
	LEFT JOIN list_options lo1 ON a.amendment_status = lo1.option_id AND lo1.list_id='amendment_status' 
	WHERE a.pid = ? ORDER BY amendment_date DESC";
$res = sqlStatement($query, array($pid) );
if ( sqlNumRows($res) > 0 ) { ?>

	<table class="class1">
		<tr class="header">
			<th><?php echo htmlspecialchars( xl('Date'),ENT_NOQUOTES); ?></th>
			<th><?php echo htmlspecialchars( xl('Requested By'),ENT_NOQUOTES); ?></th>
			<th><?php echo htmlspecialchars( xl('Description'),ENT_NOQUOTES); ?></th>
			<th><?php echo htmlspecialchars( xl('Status'),ENT_NOQUOTES); ?></th>
		</tr>
	<?php
  		$even = false;
  		while ($row = sqlFetchArray($res)) {
  			if ( $even ) {
  				$class = "class1_even";
  				$even = false;
  			} else {
  				$class="class1_odd";
  				$even=true;
			}
			echo "<tr class='".htmlspecialchars($class,ENT_QUOTES)."'>";
			echo "<td>".htmlspecialchars($row['amendment_date'],ENT_NOQUOTES)."</td>";
			echo "<td>".htmlspecialchars($row['AmendmentBy'],ENT_NOQUOTES)."</td>";
			echo "<td>".htmlspecialchars($row['amendment_desc'],ENT_NOQUOTES)."</td>";
			echo "<td>".htmlspecialchars($row['AmendmentStatus'],ENT_NOQUOTES)."</td>";
			echo "</tr>";
  		}
		echo "</table>";
  	}
	else
	{
		echo htmlspecialchars( xl("No Results"),ENT_NOQUOTES);
	}
?>
