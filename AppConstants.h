//
//  AppConstants.h
//  GOK
//
//  Created by admin on 4/11/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#ifndef AppConstants_h
#define AppConstants_h

//MARK:- TRY_CATCH_BLOCK
//////////////////////ADVANCED TRY CATCH SYSTEM////////////////////////////////////////
#ifndef UseTryCatch
#define UseTryCatch 1//use 0 to disable and 1 to enable the try catch throughout the application
//Warning:Do not Enable this Macro for general purpose...use it if u are intentionally dubbugging for some unexpected method calls
#ifndef UsePTMName
#define UsePTMName 0  //USE 0 TO DISABLE AND 1 TO ENABLE PRINTING OF METHOD NAMES WHERE EVER TRY CATCH IS USED

#if UseTryCatch

#if UsePTMName
#define TCSTART @try{ NSLog(@"\nFunction Name --- UsePTNAME is in Disabled : %s\n",__PRETTY_FUNCTION__);
#else
#define TCSTART @try{
#endif
#define TCEND  }@catch(NSException *e){ NSLog(@"\n\n\
\n **********  EXCEPTION FOUND HERE..********..PLEASE DO NOT IGNORE *********\
\n|****| FILE NAME         %s\
\n|****| LINE NUMBER       %d\
\n|****| METHOD NAME       %s\
\n|****| EXCEPTION REASON  %@\
\n\n\n\n",strrchr(__FILE__,'/'),__LINE__, __PRETTY_FUNCTION__,e.reason);};
#else
#define TCSTART {
#define TCEND   }
#endif
#endif
#endif
//////////////////////ADVANCED TRY CATCH SYSTEM////////////////////////////////////////


//MARK:- DEBUG Logs
#ifdef DEBUG
#       define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#       define DLog(...)
#endif


#define UA_runOnMainThread if (![NSThread isMainThread]) { dispatch_sync(dispatch_get_main_queue(), ^{ [self performSelector:_cmd]; }); return; };
#define START_MAIN_THREAD dispatch_async(dispatch_get_main_queue(), ^{

#define START_THREAD_AFTER(time) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
#define END_THREAD });


//MARK:- WEAKSELF_ AND STRONGSELF_
#if __has_feature(objc_arc_weak)
#define WEAKSELF_T __weak __typeof__(self)
#else
#define WEAKSELF_T __unsafe_unretained __typeof__(self)
#endif

#if __has_feature(objc_arc_weak)
#define STRONGSELF_T __strong __typeof__(weakSelf)
#else
#define STRONGSELF_T __unsafe_unretained __typeof__(weakSelf)
#endif

//MARK:- Change Language
#define languageForKey(key) [Globals languageForKey:key]
#define languageServiceForKey(key)  [Globals languageAttributedServiceForKey:key]
#define languageAttributedKey(key, n) [Globals languageAttributedForKey:key withFontSize:n]
#define languageMergeTwoKeys(key1, key2, key3) [NSString stringWithFormat:@"%@%@%@", languageForKey(key1), key2, languageForKey(key3)]

#define checkLanguageString [Globals getlanguageString]

//MARK:- APP_STORE
#define APP_STORE_LINK @"https://itunes.apple.com/in/app/id123456789"
#define APP_BUNDLE_VERSION [NSString stringWithFormat:@"%@ ( %@ )",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]

#define APP_VERSION [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]

//MARK:- APP DELEGATE
#define APP_DELEGATE [AppDelegate sharedDelegate]
#define KEY_WINDOW [[UIApplication sharedApplication] keyWindow]
#define DATA_MANAGER [DataManager sharedManager]
#define SERVICE_MANAGER [ServiceManager sharedManager]

//MARK:- CUSTOM Macros
#define Defaults [NSUserDefaults standardUserDefaults]
#define IS_INTERTNET_AVAILABLE [Utils isInternetAvailable]
#define STORYBOARD(controller) [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:controller]
#define pushToViewController(controller) [self.navigationController pushViewController:controller animated:YES]
#define TAB_BAR_CONTROLLERS [[self.tabBarController navigationController] viewControllers]

//MARK:- Tags
#define NAVIGATION_BAR_VIEW_TAG 1122
#define HOME_NAVIGATION_BAR_VIEW_TAG 2233
#define CUSTOME_POPUP_TAG 3344
#define CAMERA_POPUP_TAG 4455
#define NO_ITEMS_FOUND_VIEW_TAG 5566
#define CUSTOME_TF_POPUP_TAG 6677
#define SERVICE_DROP_DOWN_VIEW_TAG 7788
#define CUSTOM_POPUP_SINGLE_BUTTON_TAG 990011


#define LL_TEST_LAST_QSTN_CODE 99019009

#define APP_MAX_INT 9999999999
#define EXPAND_KEY_NAME @"subItems"
#define SELECT_AUTO_DROP_DOWN @"SELECT_AUTO_DROP_DOWN"
#define TABLE_VIEW_SEPARATOR_INSET UIEdgeInsetsMake(0, (IS_IPAD ? 20 : 10) , 0, (IS_IPAD ? 20 : 10))



//MARK:- PASSWORD MOBILE
#define MAX_AGE_DIGITS 2
#define DURATION_MONTHS_YEARS 2
#define AMOUNT_MAX_DIGIT 4
#define PASSWORD_MAX_DIGIT 6
#define PINCODE_MAX_DIGIT 6
#define MOBILE_MAX_DIGIT 10
#define MOBILE_MAX_DIGIT_0 11
#define MOBILE_MAX_DIGIT_91 12
#define AADHAR_MAX_DIGIT 12
#define INVOICE_OR_ACCOUNT_MAX_DIGIT 9
#define SAKALA_MAX_DIGIT 15
#define POSTAL_MAX_DIGIT 13
#define POSTAL_COMPAINT_TRAK_MAX_DIGIT 12
#define POSTAL_E_MONEY_MAX_DIGIT 18
#define PASSPORT_MAX_DIGIT 18
#define KHAJANE2_MAX_DIGIT 18
#define VEHICLE_REG_NO_MAX_DIGIT 10
#define SSLC_REG_NUMBER 11
#define BC_APPLICATION_NUMBER 12
#define RC_MAX_DIGITS 18
#define MAX_20_DIGITS 20
#define AGE_100_YEARS_BACK 100
#define AGE_16_AND_ABOVE 16
#define AGE_18_AND_ABOVE 18
#define AGE_20_AND_ABOVE 20

//MARK:- TYPES
#define NOTIFICATION_VC_TYPE 1
#define FAVOURITE_VC_TYPE 2
#define PUSH_NOTIFICATION_SERVICE_LIST_TYPE 3

#define GET_OTP_VC_TYPE 1
#define FORGOT_PWD_VC_TYPE 2
#define GOOGLE_VC_TYPE 3
#define FACEBOOK_VC_TYPE 4
#define SIGN_UP_VC_TYPE 5
#define AADHAR_VC_TYPE 6


#define RTO_LLDL_INVALID_CARRIAGE_COVS  @"12"

//MARK:- CONSTANT VALUES
#define NAMELENGTHCONSTANT 50
#define LANDMARKLENGTHCONSTANT 50
#define ADDRESSLENGTHCONSTANT 100
#define ADHARALENGTHCONSTANT 12
#define IDENTIIFCATIONLENGTHCONSTANT 60
#define NUMBEROFCOPIESLENGTHCONSTANT 2
#define EMAILLENGTHCONSTANT 100
#define APPLICATIONNUMBER 20
#define NUMBEROFUSAGELIMIT 1
#define NUMBEROFDAYSLIMIT 30

//MARK:- SERVICE METHOD TYPES
#define GET_REQUEST @"GET"
#define POST_REQUEST @"POST"
#define PUT_REQUEST @"PUT"
#define DELETE_REQUEST @"DELETE"

//MARK:- USER LOGIN_TYPES
#define MOBILE_LOGIN_TYPE @"MOBILE"
#define AADHAR_LOGIN_TYPE @"AADHAR"


//MARK:- PAYMENT_METHOD_TYPES
#define ICICI_TYPE 01
#define PAY_GOV_TYPE 01
#define MOBIKWICK_TYPE 10
#define UPI_TYPE 11

//MARK:- GET THIGS DONE
#define NORMAL_LOGIN_FROM_TUTORIAL 0
#define GET_THINGS_DONE_BESCOM 11
#define GET_THINGS_DONE_MESCOM 22


//MARK:- Loading
#define START_LOADING [LoadingView showInView:KEY_WINDOW];
#define STOP_LOADING [LoadingView hideInView:KEY_WINDOW];
#define START_LOADING_VIEW(view) [LoadingView showInView:view];
#define IS_LOADING_VIEW(view) [LoadingView isLoadingView:view];
#define STOP_LOADING_VIEW(view) [LoadingView hideInView:view];

//MARK:- Placehoder Images
#define PLACE_HOLDER_USER  [UIImage imageNamed:@"user"]
#define EMPTY_CIRCLE  [UIImage imageNamed:@"emptycircle"]
#define BUTTON_BACKGROUND  [UIImage imageNamed:@"button_background"]


//MARK:- NSNotificationCenterMethods
static NSString *const reloadHomeViewController = @"reloadHomeViewController";
static NSString *const reloadPaybillViewController = @"reloadPaybillViewController";

static NSString *const reloadPushNotifications = @"reloadPushNotifications";
static NSString *const updateDotsViewInBescom = @"updateDotsViewInBescom";
static NSString *const moveToAccountDetailsView = @"moveToAccountDetailsView";
static NSString *const makeBescomAPIAfterLogin = @"makeBescomAPIAfterLogin";
static NSString *const reloadLeftMenuViewController = @"reloadLeftMenuViewController";
static NSString *const reloadLoginViewController = @"reloadLoginViewController";
static NSString *const updateMobileInLoginPage = @"updateMobileInLoginPage";
static NSString *const updateDotsViewInPhoneBills = @"updateDotsViewInPhoneBills";
static NSString *const moveToPostpaidDetailsView = @"moveToPostpaidDetailsView";
static NSString *const makePostpaidAPIAfterLogin = @"makePostpaidAPIAfterLogin";
static NSString *const makeRTORCDLAPIAfterLogin = @"makeRTORCDLAPIAfterLogin";
static NSString *const reloadEscomVCFromSelectedService = @"reloadEscomVCFromSelectedService";
static NSString *const reloadEscomVCBackButtonClicked = @"reloadEscomVCBackButtonClicked";
static NSString *const reloadPhoneBillsVCFromSelectedService = @"reloadPhoneBillsVCFromSelectedService";
static NSString *const reloadPhoneBillsVCBackButtonClicked = @"reloadPhoneBillsVCBackButtonClicked";
static NSString *const updateAadharInLoginPage = @"updateAadharInLoginPage";

static NSString *const updateDotsViewInRTORCDL = @"updateDotsViewInRTORCDL";
static NSString *const moveToRCDLDetailsView = @"moveToRCDLDetailsView";
static NSString *const reloadRTODLRCVCFromSelectedService = @"reloadRTODLRCVCFromSelectedService";
static NSString *const reloadDLRCVCBackButtonClicked = @"reloadDLRCVCBackButtonClicked";


static NSString *const updateDotsViewInGovtServices = @"updateDotsViewInGovtServices";
static NSString *const moveToGovtServicesDetailsView = @"moveToGovtServicesDetailsView";
static NSString *const reloadGovtServicesVCFromSelectedService = @"reloadGovtServicesVCFromSelectedService";
static NSString *const reloadGovtServicesBackButtonClicked = @"reloadGovtServicesBackButtonClicked";


static NSString *const moveToBMRCLMainVCDetailsView = @"moveToBMRCLMainVCDetailsView";
static NSString *const updateDotsViewInBMRCLMainVC = @"updateDotsViewInBMRCLMainVC";
static NSString *const reloadBMRCLMainVCFromSelectedService = @"reloadBMRCLMainVCFromSelectedService";
static NSString *const reloadBMRCLMainVCBackButtonClicked = @"reloadBMRCLMainVCBackButtonClicked";

static NSString *const moveToPoliceRelatedVCDetailsView = @"moveToPoliceRelatedVCDetailsView";
static NSString *const updateDotsViewInPoliceMainVC = @"updateDotsViewInPoliceMainVC";
static NSString *const reloadPoliceMainVCFromSelectedService = @"reloadPoliceMainVCFromSelectedService";
static NSString *const reloadPoliceMainVCBackButtonClicked = @"reloadPoliceMainVCBackButtonClicked";

static NSString *const moveToAadharRelatedVCDetailsView = @"moveToAadharRelatedVCDetailsView";
static NSString *const updateDotsViewInAadharMainVC = @"updateDotsViewInAadharMainVC";
static NSString *const reloadAadharMainVCFromSelectedService = @"reloadAadharMainVCFromSelectedService";
static NSString *const reloadAadharMainVCBackButtonClicked = @"reloadAadharMainVCBackButtonClicked";

static NSString *const moveToTaxRelatedVCDetailsView = @"moveToTaxRelatedVCDetailsView";
static NSString *const updateDotsViewInTaxesMainVC = @"updateDotsViewInTaxesMainVC";
static NSString *const reloadTaxMainVCFromSelectedService = @"reloadTaxMainVCFromSelectedService";
static NSString *const reloadTaxMainVCBackButtonClicked = @"reloadTaxMainVCBackButtonClicked";

static NSString *const moveToSASTRelatedVCDetailsView = @"moveToSASTRelatedVCDetailsView";
static NSString *const updateDotsViewInSASTMainVC = @"updateDotsViewInSASTMainVC";
static NSString *const reloadTSASTMainVCFromSelectedService = @"reloadTSASTMainVCFromSelectedService";
static NSString *const reloadSASTMainVCBackButtonClicked = @"reloadSASTMainVCBackButtonClicked";

static NSString *const updateDotsViewInIRCTC = @"updateDotsViewInIRCTC";
static NSString *const moveToIRCTCDetailsView = @"moveToIRCTCDetailsView";
static NSString *const moveToIRCTCTDRDetailsView = @"moveToIRCTCTDRDetailsView";
static NSString *const reloadIRCTCVCFromSelectedService = @"reloadIRCTCVCFromSelectedService";
static NSString *const reloadIRCTCVCBackButtonClicked = @"reloadIRCTCVCBackButtonClicked";
static NSString *const reloadIRCTCSubViewPreviousButtonClicked = @"reloadIRCTCSubViewPreviousButtonClicked";
static NSString *const movetoIRCTCCancelledDetailsVC = @"movetoIRCTCCancelledDetailsVC";
static NSString *const movetoIRCTCBookDetailsVC = @"movetoIRCTCBookDetailsVC";


static NSString *const moveToFirstPageOfLLDLApplication = @"moveToFirstPageOfLLDLApplication";
static NSString *const moveToLLDLNextPage = @"moveToLLDLNextPage";
static NSString *const backToLLDLPagePreviousPage = @"backToLLDLPagePreviousPage";

static NSString *const moveToBankRelatedCDetailsView = @"moveToBankRelatedCDetailsView";
static NSString *const updateDotsViewInBankMainVC = @"updateDotsViewInBankMainVC";
static NSString *const reloadBankMainVCFromSelectedService = @"reloadBankMainVCFromSelectedService";
static NSString *const reloadBankMainVCBackButtonClicked = @"reloadBankMainVCBackButtonClicked";


static NSString *const moveToTravelVCDetailsView = @"moveToTravelVCDetailsView";
static NSString *const updateDotsViewInTravelMainVC = @"updateDotsViewInTravelMainVC";
static NSString *const reloadTravelVCFromSelectedService = @"reloadTravelVCFromSelectedService";
static NSString *const reloadTravelMainVCBackButtonClicked = @"reloadTravelMainVCBackButtonClicked";

static NSString *const moveToKSRTCLNextPage = @"moveToKSRTCLNextPage";
static NSString *const backToKSRTCPagePreviousPage = @"backToKSRTCPagePreviousPage";
//static NSString *const setHomeButtonHilighted = @"setHomeButtonHilighted";

static NSString *const updateDotsViewInCommonMainVC = @"updateDotsViewInCommonMainVC";
static NSString *const reloadCommonMainVCFromSelectedService = @"reloadCommonMainVCFromSelectedService";
static NSString *const reloadCommonMainVCBackButtonClicked = @"reloadCommonMainVCBackButtonClicked";
static NSString *const moveCommonMainVCDetailsView = @"moveCommonMainVCDetailsView";


static NSString *const updateDropDownSelectedText = @"updateDropDownSelectedText";



//MARK:- Static Validates
#define KA_STATIC @"KA"
#define ONLY_DIGITS @"0123456789"
#define ONLY_ALPHABATICES @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define ONLY_CHARACTERS @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "
#define ALPHA_NUMERIC @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
#define SPECIAL_ALPHA_NUMERIC @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_ "
#define ALPHA_NUMERIC_SPACE @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 "
#define ALPHA_NUMERIC_SLASH @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/"

//MARK:- Constants
#define RUPEE_SIGN  [NSString stringWithFormat:@"\u20B9"]
#define RC4KEY @"123456"
#define CONVENEANCE_FEE 5

//MARK:- APP_ACTIONS
#define ESCOM_APP_ACTIONS @[@"1",@"2", @"3", @"4", @"5", @"6"]
#define PHONE_BILLS_APP_ACTIONS @[@"7",@"8", @"9", @"10", @"11", @"12"]
#define RTO_APP_ACTIONS @[@"13",@"14", @"15", @"16"]
#define GOVTS_APP_ACTIONS @[@"17",@"18", @"19", @"20", @"21"]
#define BMRCL_APP_ACTIONS @[@"22",@"23", @"24"]
#define POLICE_APP_ACTIONS @[@"25",@"26", @"27", @"28", @"29", @"30", @"31"]
#define AADHAR_APP_ACTIONS @[@"33",@"34", @"35"]
#define STAMS_REGISTRATIONS_APP_ACTIONS @[@"36",@"37", @"38"]
#define KSRTC_APP_ACTIONS @[@"40",@"41", @"42"]
#define IRCTC_APP_ACTIONS @[@"43",@"44", @"45", @"46", @"47", @"48"]
#define TAXACATION_APP_ACTIONS @[@"70",@"71"]



//MARK:- Static Validation Keys
#define RTO_LLDL_NONTRANS_COVS @[@"3", @"4", @"5", @"6", @"12", @"13", @"65"]
#define RTO_LLDL_TRANS_COVS  @[@"7", @"8", @"9", @"10", @"15", @"16", @"17", @"53", @"54", @"58", @"59"]
#define MIN_QUALIFICATION_ARRY  @[@"0", @"1", @"2"]
#define RTO_LLDL_AGE_PROOFCODES  @[@"E", @"A", @"1", @"2"]
#define RTO_LLDL_ADDRESS_PROOFCODES  @[@"P", @"3", @"4", @"5", @"6", @"8", @"G", @"J", @"K", @"N"]

#define SIDE_MENU_SELECTED @"YES"
#define SIDE_MENU_UN_SELECTED @"NO"

#endif /* AppConstants_h */
