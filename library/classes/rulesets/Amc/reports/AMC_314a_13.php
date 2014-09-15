<?php
// Copyright (C) 2014 Ensoftek
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//


class AMC_314a_13 extends AbstractAmcReport
{
    public function getTitle()
    {
        return "AMC_314a_13";
    }

    public function getObjectToCount()
    {
        return "patients";
    }
 
    public function createDenominator() 
    {
        return new AMC_314a_13_Denominator();
    }
    
    public function createNumerator()
    {
        return new AMC_314a_13_Numerator();
    }
}
