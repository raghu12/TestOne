//
//  ToastMessages.h
//  GOK
//
//  Created by admin on 4/20/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#ifndef ToastMessages_h
#define ToastMessages_h


 #define DISPLAY_TOAST(toast) [KEY_WINDOW makeToast:toast]

#define UNKNOWN_ERROR_TOAST @"Oops! something went wrong. Please try again!"
#define CONNECTION_LOST_TOAST @"Connection lost"
#define DATA_NOT_FOUND_TOAST @"No data found!"
#define NO_INTERNET_AVAILABLE_TOAST @"Check your internet connection. Please try again!"


//MARK:- Login Screen
#define ENTER_MOBILE_NUMBER_TOAST @"Please enter mobile number"
#define ENTER_AADHAR_NUMBER_TOAST @"Please enter aadhaar number"
#define ENTER_VALID_MOBILE_NUMBER_TOAST @"Please enter valid mobile number"
#define ENTER_VALID_AADHAR_NUMBER_TOAST @"Please enter valid 12 digit aadhaar number"
#define ENTER_PASSWORD_TOAST @"Please enter Password"
#define ENTER_VAILD_PASSWORD_TOAST @"Password length should not be less than 6 digits"
#define ENTER_ACCOUNT_NUM_TOAST @"Please enter valid account number"
#define ENTER_RR_NUM_TOAST @"Please enter valid RR Number"
#define NOT_LOGIN_BY_GOOGLE @"Not able to login with google please try again..."
#define LOGIN_SUCCESS_TOAST @"Login success"

//MARK:- OTP Screen
#define SENT_OTP_TOAST @"Dear user, your 6 digit otp has been sent to your registered mobile"
#define ENTER_OTP_TOAST @"Please enter valid 6 digit otp"
#define OTP_SUCCESS_TOAST @"OTP verified successfully."
#define UN_REGISTER_USER_TOAST @"Dear user, this mobile number is not registered please register first."


//MARK:- SIGNUP Screen
#define ALREADY_REGISTER_TOAST @"Dear user, You are a existing user please create your new password."
#define ENTER_VALID_CAPTCHA @"Please enter valid captcha."


//MARK:- PROFILE Screen
#define ENTER_FATHER_HUSBAND_TOAST @"Please enter Father/Husband Name."
#define ENTER_NAME_TOAST @"Please enter your name."
#define ENTER_FIRST_NAME_TOAST @"Please enter first name."
#define ENTER_LAST_NAME_TOAST @"Please enter last name."
#define SELECT_GENDER_TOAST @"Please select gender."
#define SELECT_DOB_TOAST @"Please select Date of Birth."
#define ENTER_Addrs1_TOAST @"Please enter address line 1."
#define ENTER_Addrs2_TOAST @"Please enter address line 2."
#define ENTER_Addrs3_TOAST @"Please enter address line 3."
#define SELECT_STATE_TOAST @"Please select state."
#define SELECT_DISTRICT_TOAST @"Please select district."
#define ENTER_PINCODE_TOAST @"Please enter pincode."
#define ENTER_VALID_PINCODE_TOAST @"Please enter valid pincode."
#define SELECT_DISTRICT_KTK_TOAST @"Please select district of Karnataka"
#define SELECT_LANGUAGE_TOAST @"Please select language"
#define SELECT_STATE_FIRST_TOAST @"Please select state first"
#define ENTER_EMER1_TOAST @"Please enter emergency contact 1"
#define ENTER_EMER2_TOAST @"Please enter emergency contact 2"
#define ENTER_VALID_EMER1_TOAST @"Please enter valid emergency contact 1"
#define ENTER_VALID_EMER2_TOAST @"Please enter valid emergency contact 2"
#define NO_PROFILE_UPDATE_TOAST @"You haven't changed anything to update"
#define MOBILE_EMRGCONT1_NOT_EQUAL_TOAST @"Emergency contact 1 should not be same as Mobile Number"
#define MOBILE_EMRGCONT2_NOT_EQUAL_TOAST @"Emergency contact 2 should not be same as Mobile Number"
#define EMRGCONT1_EMRGCONT2_NOT_EQUAL_TOAST @"Emergency contact 1 should not be same as Emergency contact 2"

//MARK:- SOCIAL SIGNUP Screen
#define ENTER_EMAIL_TOAST @"Please enter email."
#define ENTER_VALID_EMAIL_TOAST @"Please enter valid email."
#define UNABLE_TO_FETCH_MOBILE @"We are unable to detect your mobile number, please provide mobile number to continue."

//MARK:- Change Password
#define OLD_PWD_TOAST @"Please enter your old password"
#define NEW_PWD_TOAST @"Please enter your new password"
#define CONFIRM_PWD_TOAST @"Please confirm your new password"
#define PWD_DONOT_MATCH_TOAST @"Passwords does'nt match"
#define PASSWORD_SUCCESS_TOAST @"Your password has been created successfully."
#define PASSWORD_UPDATE_TOAST @"Your password has been updated successfully."
#define UNABLETO_RESET_PWD_TOAST @"Ubale to reset the password. Please try again."
#define UNABLETO_SET_PWD_TOAST @"Ubale to create the password. Please try again."


//MARK:- APPSettings
#define SELECT_SERVICE_TOAST @"Please select one service."
#define SELECT_ACCOUNT_NUM_TOAST @"Please select account number."
#define SELECT_CURRENT_DISTRICT_TOAST @"Please select current district of Karnataka."

#define SELECT_OPERATOR_TOAST @"Please select operator."
#define ENTER_AMOUNT_TOAST @"Please enter amount."

#define ENTER_INVOICE_NUMBER @"Please enter invoice number"
#define ENTER_VALID_INVOICE_NUMBER @"Please enter valid invoice number"

#define ENTER_ACCOUNT_NUMBER @"Please enter account number"
#define ENTER_VALID_ACCOUNT_NUMBER @"Please enter valid account number"

#define ADD_FAVOURITE_TAOST  @"Added to favorites."
#define REMOVE_FAVOURITE_TOAST @"Removed from favorites."

#define SELECT_APPLICATION_TYPE @"Please select Application Type."
#define SELECT_RELATION_TYPE @"Please select relation type."
#define ENTER_RELATION_FIRST_NAME_TOAST @"Please enter relation's first name."
#define ENTER_LICENCE_NO_TOAST @"Please enter Licence Number."
#define ENTER_RC_NO_TOAST @"Please enter Registration Number."
#define ENTER_ENGIN_CHASIS_NO_TOAST @"Please enter Chassis Number / Engine Number."
#define ENTER_PURPOSE_TOAST @"Please enter purpose."
#define ENTER_OWNER_NAME_TOAST @"Please enter Owner Name."
#define SELECT_OTION_TOAST @"Please select answer."
#define SELECT_RTO_TYPE_TOAST @"Please select RTO."
#define SELECT_COUNTRY_TOAST @"Please select Country."
#define SELECT_MIGRATION_DATE_TOAST @"Please select Date of Migration."
#define DOM_NOT_PAST_FROM_DOB_TOAST @"Date of Migration should not be past from the Date of Birth."
#define SELECT_CITIZENSHIP_TOAST @"Please select citizenship."
#define ENTER_QUALIFICATION_TOAST @"Please select qualification."
#define SELECT_CLASS_OF_VEHICLE_TOAST @"Please select Class of Vehicle."
#define SELECT_LL_MEDICAL_AND_ADDRESS_PROOF_TOAST @"Please provide proof detials of Lerners Licence, Medical and Address."
#define SELECT_AGE_MEDICAL_AND_ADDRESS_PROOF_TOAST @"Please provide proof detials of Age, Medical and Address."
#define SELECT_PROOF_TOAST @"Please select the proof for Licence."
#define SELECT_ADDRESS_PROOF_TOAST @"Please provide Address proof detials."
#define SELECT_MEDICAL_FORM_1A_PROOF_TOAST @"Please provide Medical form-1A proof detials."
#define SELECT_OTHER_PROOF_TOAST @"Please provide other proof."
#define SELECT_LERNERS_LICENCE_PROOF_TOAST @"Please provide Lerners Licence proof detials."
#define SELECT_AGE_PROOF_TOAST @"Please provide Age proof detials."
#define ENTER_CERTIFICATE_NUM_TOAST @"Please enter Certificate Number for proof "
#define ENTER_ISSUING_AUTHORITY_TOAST @"Please enter Issuing Authority for proof "
#define SELECT_DOISSUE_TOAST @"Please select Date of Issue for proof "
#define ENTER_CONIVCTED_NUM_TOAST @"Please enter Disqualified or Convicted License number. "
#define SELECT_CONIVCTED_DATE_TOAST @"Please select Date of Disqualified or Convicted "
#define DUPLICATE_ATTACHMENTS_ADDED @"Duplicate attachments are added."

#define ENTER_CHALLAN_REF_NUM_TOAST @"Please enter Challan Reference Number."
#define SELECT_TYPE_OF_SERVICE @"Please select type of service."
#define ENTER_SERVICE_NUMBER @"Please enter service number."
#define ENTER_TRACK_SERVICE_NUMBER_TOAST @"Tracking number length should be 13 digits."
#define ENTER_EMONEY_SERVICE_NUMBER_TOAST @"Money order tracking number length should Numeric & 18 digits."
#define ENTER_COMPLAINT_SERVICE_NUMBER_TOAST @"Complaint number length should 12 digits."


#define SELECT_ACADEMIC_YEAR_TOAST @"Please select academic year."
#define SELECT_SSLC_TYPE_TOAST @"Please select SSLC type."
#define ENTER_SSLC_REG_NUM_TOAST @"Please enter SSLC Registration Number."
#define SELECT_YEAR_OF_PASSING_TOAST @"Please select year of passing."
#define ENTER_APPLICATION_NUM_TOAST @"Please enter Application Number."
#define ENTER_GSC_NUMBER_TOAST @"Please enter valid GSC Number."
#define AGE_SHOULD_BE_18_TOAST @"Age should be 18 years for Non-Transport Vehicles."
#define AGE_SHOULD_BE_20_TOAST @"Age should be 20 years for Transport Vehicles."
#define MIN_QUALIFICAITON_FOR_TRNSPORT_VCL_TOAST @"Minimum 8th pass qualification is required for the transport vehicle license."
#define NOT_ALLOW_LL_DL_FOR_DL_TOAST @"Should not allow this proof for Driving Licence."

#define SELECT_CIRCLE_TOAST @"Please select Circle."
#define SELECT_SOURCE_TOAST @"Please select Source."
#define SELECT_DESTINATION_TOAST @"Please select Destination."
#define SELECT_SOURCE_DESTINATION_SHOULD_NOT_TOAST @"Source and Destination should not be same."
#define ENTER_COMPLAINTS_TOAST @"Please enter your complaints."
#define SELECT_DIVISION_TOAST @"Please select Division."
#define SELECT_SUB_DIVISION_TOAST @"Please select Sub Division."
#define SELECT_PS_TOAST @"Please select Police Station."
#define SELECT_ZONE_TOAST @"Please select Zone."
#define SELECT_PURPOSE_TOAST @"Please select purpose."
#define ENTER_ADDRESS_TOAST @"Enter Address."
#define ENTER_AMPL_ADDRESS_TOAST @"Enter Amplifier setup Address."
#define ENTER_REASON_TOAST @"Enter reason."
#define ENTER_NO_DAYS @"Enter No. of Days"
#define SELECT_FROM_DATE_TOAST @"Please select From Date."
#define ENTER_VEHICLE_REG_NUM_TOAST @"Please enter Vehicle Registration Number."
#define ENTER_VALID_VEHICLE_REG_NUM_TOAST @"Please enter Valid Vehicle Registration Number."
#define ENTER_VEHICEL_TYPE_TOAST @"Please enter Vehicle Type."
#define ENTER_VEHICEL_MAKE_TOAST @"Please enter Vehicle Make."
#define ENTER_VEHICEL_MODEL_TOAST @"Please enter Vehicle Model."
#define ENTER_VEHICEL_REG_NO_TOAST @"Please enter Vehicle Registration No./Chasis No."
#define ENTER_STATE_TOAST @"Please enter state."
#define ENTER_PS_TOAST @"Please enter Police Station."
#define ENTER_FIR_NO_TOAST @"Please enter FIR No."
#define SELECT_CENTER_TOAST @"Please select Center."
#define SELECT_DEPT_CONTACT_TOAST @"Please select Department Contacts."
#define SELECT_DEPT_DOC_TOAST @"Please select Departments for Registration."
#define SELECT_DEPT_FEE_TOAST @"Please select Departments for Fees."


#define GO_BACK_ALERT_HINT @"Are you sure you want to go back?"

//MARK:- Suvarna Aarogya Suraksha
#define SELECT_SCHEME_TOAST @"Please select Scheme Name"
#define SELECT_SPECIALITY_TOAST @"Please select Speciality Name"
#define SELECT_HOSPITAL_TOAST @"Please select Hospital Name"
#define SELECT_PACKAGE_NAME_TOAST @"Please select Package Name"
#define SELECT_PACKAGE_CODE_TOAST @"Please select Package Code"


//MARK:- Select Payment Screen
#define SELECT_PAYMENT_TOAST @"Please select payment method"

//MARK:- RML Screen
#define SELECT_TALUK_TOAST @"Please select Taluk"

//MARK:- Cauvery Screen
#define SELECT_DAM_TOAST @"Please select Dam Type"
#define SELECT_RESERVE_TOAST @"Please select Reservoir"

//MARK:- syndicate bank
#define ENTER_PAN_TOAST @"Please enter PAN number."
#define ENTER_VALID_PAN_TOAST @"Please enter valid PAN number."
#define UPLOAD_IMAGE_TOAST  @"Please upload image."
#define SELECT_DEPT_TOAST @"Please select Department."
#define SELECT_CATEGORY_TOAST @"Please select Category."
#define ENTER_COMMENTS_TOAST @"Please enter Comments."

//MARK:- KSRTC
#define SELECT_TRIPTYPE_TOAST @"Please select Trip type"
#define SELECT_ONWARD_DATE @"Please select Onward Date"
#define SELECT_RETURN_DATE @"Please select Return Date"
#define ENTER_ORIGIN_TOAST @"Please enter origin"
#define ENTER_DESTINATION_TOAST @"Please enter Destination"
#define ENTER_VALID_ORIGIN_TOAST @"Please enter valid origin"
#define ENTER_VALID_DESTINATION_TOAST @"Please enter valid Destination"
#define SELECT_PASSENGERS_TOAST @"Please selct number of Passengers"
#define ENTER_AGE_TOAST @"Please enter age"
#define SELECT_OWBPOINT_TOAST @"Please select Onward Boarding Point"
#define SELECT_OWALPOINT_TOAST @"Please select Onward Alighting Point"
#define SELECT_OWCON_TYPE_TOAST @"Please select Concession Type"
#define SELECT_RE_BPOINT_TOAST @"Please select Return Boarding Point"
#define SELECT_RE_ALPOINT_TOAST @"Please select Return Alighting Point"
#define SELECT_RE_CON_TYPE_TOAST @"Please select Return Concession Type"
#define ENTER_IDPROOF_TOAST @"Please enter ID Proof No"
#define ENTER_AGE2_TOAST @"Please enter passengers2 age"
#define ENTER_AGE3_TOAST @"Please enter passengers3 age"
#define ENTER_AGE4_TOAST @"Please enter passengers4 age"
#define ENTER_AGE5_TOAST @"Please enter passengers5 age"
#define ENTER_AGE6_TOAST @"Please enter passengers6 age"
#define ENTER_NAME2_TOAST @"Please enter passengers2 name."
#define ENTER_NAME3_TOAST @"Please enter passengers3 name."
#define ENTER_NAME4_TOAST @"Please enter passengers4 name."
#define ENTER_NAME5_TOAST @"Please enter passengers5 name."
#define ENTER_NAME6_TOAST @"Please enter passengers6 name."
#define SELECT_GENDER2_TOAST @"Please select passengers2 gender."
#define SELECT_GENDER3_TOAST @"Please select passengers3 gender."
#define SELECT_GENDER4_TOAST @"Please select passengers4 gender."
#define SELECT_GENDER5_TOAST @"Please select passengers5 gender."
#define SELECT_GENDER6_TOAST @"Please select passengers6 gender."

//MARK:- IRCTC Screen
#define ENTER_USERNAME_LINK_IRCTC_TOAST @"Please enter username linked with IRCTC"
#define SELECT_MARITAL_TOAST @"Please select Marital Status"
#define SELECT_OCCUPATION_TOAST @"Please select Occupation"
#define SELECT_CITY_TOWN_TOAST @"Please select City/Town"
#define SELECT_POSTOFFICE_TOAST @"Please select Post Office"
#define ENTER_RES_PHONE_TOAST @"Please enter Residence Phone No."
#define SELECT_QUESTION_TOAST @"Please select Question"
#define ENTER_ANSWER_TOAST @"Please enter Answer."
#define ENTER_USERNAME_TOAST @"Please enter User Name."
#define SELECT_ONE_TICKET_NUMBER_TOAST @"Please select TICKET Number"
#define SELECT_REASON_FOR_TDR_TOAST @"Please select reason for File TDR"
#define ENTER_OTHER_REASON_FOR_TDR_TOAST @"Please enter other reason for File TDR"
#define SELECT_ATLEAST_ONE_PASSENGER_TOAST @"Please select at least one passenger"
#define SHOULD_NOT_ALLOW_CANCELLED_PASS_TOAST @"Should not allow the selection for cancelled passenger"
#define SELECT_FROM_STATION_TOAST @"Please select Correct From Station"
#define SELECT_TO_STATION_TOAST @"Please select Correct To Station"
#define SELECT_TRAIN_CLASS_TOAST @"Please select Class"
#define SELECT_TRAIN_QUOTA_TOAST @"Please select Quota"
#define SELECT_TRAIN_TOAST @"Please select your Train"
#define SELECT_BERTH_CHOICE_TOAST @"Please select your berth choice"
#define ADD_MAX_6_PASSENGER_TOAST @"You can add max 6 passengers only"
#define SELECT_BOARDING_POINT_TOAST @"Please select boarding point"
#define ENTER_PASSPORT_NUMBER_TOAST @"Please enter passport number"



 
#endif /* ToastMessages_h */
