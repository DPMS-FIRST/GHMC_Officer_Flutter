import 'package:flutter/material.dart';

ValueNotifier<String?> selectedCountry = ValueNotifier('    select');
ValueNotifier<String?> userGender = ValueNotifier(null);
ValueNotifier<String?> location = ValueNotifier("Use Current Location");
ValueNotifier<String?> postcommentoptions = ValueNotifier("without photo");
ValueNotifier<String?> complaint = ValueNotifier(null);
ValueNotifier<String?> takeActionTypes = ValueNotifier('   select');
ValueNotifier<String?> ramkyvalues = ValueNotifier('   select');
ValueNotifier<String?> takeActionTypes1 = ValueNotifier('select');
ValueNotifier<String?> ramkyvalues1 = ValueNotifier('select');
ValueNotifier<String?> imageOptions = ValueNotifier(null);
ValueNotifier<String?> newcomplaintdropdown = ValueNotifier('select');
ValueNotifier<String?> selectLocationNameDropdown =
    ValueNotifier('Select Location Name');
ValueNotifier<String?> vehicleNumbersDropdown =
    ValueNotifier("Select Vehicle No");
ValueNotifier<String?> bindplantnamesdropdown =
    ValueNotifier("Select Plant Name");
ValueNotifier<String?> vehicletypesdropdown =
    ValueNotifier("Select Vehicle Type");
ValueNotifier<String?> vehicletypeslist = ValueNotifier('Select Vehicle Type');
ValueNotifier<String?> raiserequest_vehicletypeslist = ValueNotifier(null);
ValueNotifier<String?> publicdropdown = ValueNotifier('KAPRA');
ValueNotifier<String?> takeactionIdproofsDropdown = ValueNotifier("select");
ValueNotifier<String?> getactivities = ValueNotifier("select");
ValueNotifier<String?> getcenters = ValueNotifier("select");

// radio button 

ValueNotifier<bool> actionTakenValue = ValueNotifier<bool>(false);
ValueNotifier<bool> fineComposedValue = ValueNotifier<bool>(false);
ValueNotifier<bool> materialWeightValue = ValueNotifier<bool>(false);
