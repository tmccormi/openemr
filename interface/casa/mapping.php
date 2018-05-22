<?php
/**
 * Use the XPath language to query the XML document.
 *
 * See docs for XPath syntax https://www.w3schools.com/xml/xpath_syntax.asp
 *
 * We are using mainly absolute paths.
 * @ means get the value contained in the attribute denoted by @, rather than the node value
 */
return [
    'patient_data' => [
        '/ClinicalDocument/recordTarget/patientRole/patient/name/given' => 'fname',
        '/ClinicalDocument/recordTarget/patientRole/patient/name/family' => 'lname',
        '/ClinicalDocument/recordTarget/patientRole/patient/birthTime/@value' => 'DOB',
        '/ClinicalDocument/recordTarget/patientRole/patient/administrativeGenderCode/@code' => 'sex',
        '/ClinicalDocument/recordTarget/patientRole/addr/streetAddressLine' => 'street',
        '/ClinicalDocument/recordTarget/patientRole/addr/city' => 'city',
        '/ClinicalDocument/recordTarget/patientRole/addr/state' => 'state',
        '/ClinicalDocument/recordTarget/patientRole/addr/postal_code' => 'postal_code',
        '/ClinicalDocument/recordTarget/patientRole/telecom[@use="HP"]/@value' => 'phone_home',
        '/ClinicalDocument/recordTarget/patientRole/telecom[@use="MC"]/@value' => 'phone_cell'
    ],
    'allergies' => [
        '/ClinicalDocument/component/structuredBody/component/section[title/text()="Allergies"]/text/table/tbody/tr' => 'pf_map_allergies()'
    ],
    'medications' => [
        '/ClinicalDocument/component/structuredBody/component/section[title/text()="Medications"]/text/table/tbody/tr' => 'pf_map_medications()'
    ]
];