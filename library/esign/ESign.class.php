<?php

use Signature;

/**
 * Copyright (C) 2012 OEMR 501c3 www.oemr.org
 *
 * HTML e-signature helper class to facilitate standardized signatures for forms and documents.  
 *
 * LICENSE: This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://opensource.org/licenses/gpl-license.php>;.
 *
 * @package OpenEMR
 * @author  Jeremy Wallace <jeremy@mi-squared.com>
 * @author  Medical Information Integration, LLC
 * @link    http://www.mi-squared.com
 **/

include_once("{$GLOBALS['srcdir']}/sql.inc");

class ESign
{

    private $table;
    private $tid;

    /**
     * Create an empty eSign object ready to attach signatures. 
     */
    function __construct()
    {
    }

    /**
     * Initialize eSign class for all signatures matching a table/tid
     * 
     * Use to recall existing signatures for a table row that haven't been signed
     * 
     * @param type $tid  - id for row in table.   column name may not be id exactly, but equivalent. 
     * @param type $table  - table name of the row the signature is for.
     */
    function init($tid, $table)
    {
        
        if (empty($tid) || empty($table))
        {
            return;
        }

        $this->table = $table;
        $this->tid = $tid;

    }

    // return newest signed signature
    public function getNewestSignedSignature()
    {
        //sort by date using ascii string comparison. 
        $sig = null;
        
        //get the existing unsigned signatures into the unsigned signatures array
        $result = sqlStatement("Select * from eSignatures where `tid` = '".$this->tid."' and `table` = '".$this->table."' and signed = 1 order by datetime desc limit 1");
        
        if($tmp_sig = sqlFetchArray($result))
        {
            $sig = new Signature();
            $sig->load($tmp_sig['id']);
        }
        
        return $sig;
    }
    
    // return newest unsigned signature
    public function getNewestUnsignedSignature()
    {
        //sort by date using ascii string comparison. 
        $sig = null;
        
        //get the existing unsigned signatures into the unsigned signatures array
        $result = sqlStatement("Select * from eSignatures where `tid` = '".$this->tid."' and `table` = '".$this->table."' and signed = 0 order by datetime limit 1");
        
        if($tmp_sig = sqlFetchArray($result))
        {
            $sig = new Signature();
            $sig->load($tmp_sig['id']);
        }
        else
        {
            $sig = $this->createUnsignedSignature();
        }
        
        return $sig;
    }
    
    
    /**
     *  creates a new, unsigned signature for the current table/id pair
     */
    public function createUnsignedSignature()
    {
        if (empty($this->tid) || empty($this->table))
        {
            return null;
        }
        
        $tmp_sig = new Signature();
        $tmp_sig->create($this->tid, $this->table);
        
        return $tmp_sig;
    }
    
    /**
     * Returns true if the esign object has _any_ signatures associated with it.
     * 
     * @return type
     */
    public function hasSignature()
    {
        return count($this->getSignatures()) > 0 ? true : false;
    }
    
    /**
     * Returns the array of SIGNED signatures
     * 
     * @return array  
     */
    public function getSignatures()
    {
        $result = sqlStatement("select * from eSignatures where `tid` = '".$this->tid."' and `table` = '".$this->table."' and signed = 1");
        $signatures = array();

        while($sig_res = sqlFetchArray($result))
        {
            $sig = new Signature();
            $sig->load($sig_res['id']);

            if($sig->isSigned())
                array_push($signatures, $sig);
        }
        
        return $signatures;
    }

    public function getUnsignedSignatures()
    {
        $result = sqlStatement("Select * from eSignatures where `tid` = '".$this->tid."' and `table` = '".$this->table."' and signed = 0");
        
        $signatures = array();
        while($sig_res = sqlFetchArray($result))
        {
            $sig = new Signature();
            array_push($signatures, $sig->load($sig_res['id']));
        }
        return $signatures;
    }

    /**
     * Creates the default visual component
     * Shows the log of all signatures for *$this
     * 
     * this can be replaced, overridden, or whatever.
     * 
     * @return echoes the html if $draw is set true, else returns the html as a string. 
     */
    public function getDefaultSignatureLog($draw=false, $title="")
    {
        $html = "";
        $html .= "<table cellspacing=0 cellpadding=2 style='border:1px black solid;font-size:small'>";
        $html .= "<tr><td colspan=2 class='body_title' style='text-align:center;'>$title e-Signature Log</td></tr>";

        if(count($this->getSignatures()) > 0)
        {
            foreach ($this->getSignatures() as $sig)
            {
                if ($sig->isSigned())
                {

                    //get doctor info
                    $user_info = sqlQuery("select * from users where id = '" . $sig->getUid() . "'");
                    $status = "on file: " . $sig->getDatetime();

                    $html .= "<tr><td>";

                    // this maybe needs to reflect the ACL?
//                    if ($sig->getUid() != $_SESSION['authId'])  //need to check on user_id's val - should equal whoever's signed in
                      $html .= $user_info['fname'] . " " . $user_info['lname'] . " - signature $status</td></tr>";
                }
            }
        }
        else
        {
            $html .= "<tr><td>No signatures on file</td></tr>";
        }

        $html .= "</table>";

        if ($draw)
            echo $html;
        else
            return $html;
    }
}

class Signature
{

    private $id;
    private $tid;
    private $table;
    private $uid;
    private $datetime;
    private $signed;

    /**
     *  load a signature record by the id.
     */
    function load($id)
    {
        $this->id = $id;
        $this->sync();
    }

    /**
     * Creates _NEW_ signature entry. 
     * 
     * @param type $table
     * @param type $uid
     */
    function create($tid, $table)
    {

        if (empty($table))
        {
            throw new Exception("Table value must not be empty when attaching a new signature.");
        }

        if (empty($tid))
        {
            throw new Exception("The table id cannot be empty when attaching a new signature.");
        }

        $this->setTable($table);
        $this->setTid($tid);

        $this->saveOrUpdate();
        
    }

    public function getId()
    {
        return $this->id;
    }

    public function getTid()
    {
        return $this->tid;
    }

    public function setTid($tid)
    {
        $this->tid = $tid;
    }

    public function getTable()
    {
        return $this->table;
    }

    public function setTable($table)
    {
        $this->table = $table;
    }

    public function getUid()
    {
        return $this->uid;
    }

    public function setUid($uid)
    {
        $this->uid = $uid;
    }

    public function getDatetime()
    {
        return $this->datetime;
    }

    public function isSigned()
    {
        return $this->signed;
    }

    public function setSigned($signed)
    {
        if($signed)
            $this->signed = 1;
        else
            $this->signed = 0;
    }

    private function addSeparator($args)
    {
        if ($args > 0)
            return ", ";
        else
            return "";
    }
    
    private function addAnd($args)
    {
        if ($args > 0)
            return "AND ";
        else
            return "";
    }
    public function saveOrUpdate()
    {
        $f = fopen("jcw.out", "a+");
        
        $query = "eSignatures set ";
        $q2 = "eSignatures where ";
        $args = 0;

        if (!empty($this->tid))
        {
            $query .= "`tid` = '" . $this->tid . "' ";
            $q2 .= "`tid` = '" . $this->tid . "' ";
            $args++;
        }

        if (!empty($this->table))
        {
            $query .= $this->addSeparator($args);
            $query .= "`table` = '" . $this->table . "' ";
            
            $q2 .= $this->addAnd($args);
            $q2 .= "`table` = '" . $this->table . "' ";
            $args++;
        }

        if (!empty($this->uid))
        {
            $query .= $this->addSeparator($args);
            $query .= "`uid` = '" . $this->uid . "' ";
            
            $q2 .= $this->addAnd($args);
            $q2 .= "`uid` = '" . $this->uid . "' ";
            $args++;
        }

        if ($this->isSigned())
        {
            //sig
            $query .= $this->addSeparator($args);
            $query .= "`signed` = '" . $this->signed . "' ";
            
            //datetime
            $query .= $this->addSeparator($args);
            $query .= "`datetime` = now() ";

            // thinking I don't need to check for datetime for the where clause here. 
            
            $args++;
        } else
        {
            $query .= $this->addSeparator($args);
            $query .= "`signed` = '0' ";
            
            //datetime
            $query .= $this->addSeparator($args);
            $query .= "`datetime` = now() ";
            
            $args++;
        }


        if ($args && empty($this->id))
        {
            //if empty id, just add new record
            $this->id = sqlInsert("insert into " . $query);
        } 
        else if ($args)
        {
            // if id has value, update with new values
            sqlStatement("update " . $query . " where id = '" . $this->id . "'");
        }

        $this->sync();
    }

    public function sync()
    {
        //re-sync from the database
        if (!empty($this->id))
        {
            $res = sqlQuery("select * from eSignatures where id = '" . $this->id . "'");

            if ($res)
            {
                foreach ($res as $key => $val)
                {
                    $this->$key = $val;
                }
            }
        }
    }

}
?>
