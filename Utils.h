//
//  Utils.h
//  GOK
//
//  Created by admin on 4/13/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <sys/sysctl.h>
#import "PlaceholderTextView.h"

@interface Utils : NSObject {
    Reachability *netReachable;
}

+ (Utils*)singletonUtilsClass;


#pragma mark - JSON Related
+ (NSDictionary*) parseURL:(NSURL*) url;
+ (NSString *)jsonFromId:(id)json;
+ (NSMutableDictionary *) dictionaryWithPropertiesOfObject:(id)obj;
+ (void)registerDeviceForRemoteNotifications;
+ (void) removeNSUserDefaultsPersistanceStorage;
+ (NSMutableArray *) getIcareDepartmentNames;
+ (NSMutableArray *) getIcareCategory:(NSString*)Key;
+(NSMutableArray*)getTripType;
+(NSMutableArray*)getNumberOfPassengers;
+(BOOL)isEmptyValue:(id)object;
+ (CGFloat)getLabelHeight:(UILabel*)label;
+ (NSAttributedString*) getAttributedTitle:(NSString*)string withFont:(UIFont*)font withColor:(UIColor *)color;
+(UIImage*)setColorForImageView:(UIImageView*)imageView withColor:(UIColor*) color;
+(UIImage*)setColorForHilightedImageView:(UIImageView*)imageView withColor:(UIColor*) color;
+ (void)applyShadowToSubView : (UIView *) view withBackgroundColor:(UIColor*)viewBgColor;
+(NSMutableAttributedString *)withAtrributedString:(NSString *)attrString withPlainString:(NSString *)plainString ;
+(NSMutableAttributedString *)withString1:(NSString *)string1 withColor1:(UIColor*)color1 plainFont1:(UIFont*)font1 withColon:(NSString *)colon withString2:(NSString *)string2 withColor2:(UIColor*)color2 plainFont2:(UIFont*)font2;
+(NSMutableAttributedString *)withPlainString:(NSString *)plainString plainColor:(UIColor*)plainColor withColon:(NSString *)colon withAtrributedString:(NSString *)attrString attributedColor:(UIColor*)attrColor;
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - Getters
+ (BOOL)arraysContainSameObjects:(NSArray *)array1 andOtherArray:(NSArray *)array2;
+(NSInteger) getDigitsFromText : (NSString *)text ;
+(NSInteger) getAgeFromDOB:(NSString*)dob;
+ (NSMutableArray *) getMonthList;
+ (NSMutableArray *) getYearList;
+ (NSMutableArray *) getAcademicYears;
+ (NSMutableArray *) getRechargeAmounts;
+ (NSString*)getRandom:(NSInteger)lenth ;
+(NSString * )getAppVersion;
+(void)updateButtonGlobally:(UIButton*)button;
+(void)updateTitleLabelGlobally:(UILabel*)label ;
+(void)updateSubTitleLabelGlobally:(UILabel*)label;
+(void)updateTextFieldGlobally:(UITextField*)textfield ;
+(void)updateTextViewGlobally:(PlaceholderTextView*)textView;
+(void)updateSubmitButton:(UIButton*)button withBCColor:(UIColor*)bgcolor withTtileColor:(UIColor*)titleColor;
+(NSString*)getFirstWordFromString:(NSString *)string withSeparator:(NSString *)separator;
+(NSString*)getAllFirstCharacterFrom:(NSString *)string;
+ (NSString*)getPrefixCharacterFrom:(NSString*)string;
+ (NSString*)getPrefix2CharactersFrom:(NSString *)string;
+ (BOOL)validateEmergencyContact1 :(NSString *)inputNum;
+ (BOOL)validateEmergencyContact2 :(NSString *)inputNum;
+(BOOL)vehicleValidation :(NSString *)inputNum;
+(BOOL)isValidPinCode:(NSString*)pincode ;
+ (BOOL)mobileNumValidation :(NSString *)inputNum;
+ (BOOL)celloneAccoutNumberValidation :(NSString *)inputNum;
+ (BOOL)celloneInvoiceNumberValidation :(NSString *)inputNum;
+ (BOOL)validateEmailWithString:(NSString*)email;
+(BOOL)checkdaDateComparisionWithFirstDate:(NSString *)fdate secondDate:(NSString *)sdate toastMsg:(NSString *)msg;

//MARK:- Get static values
+ (NSString*)getRandomValueWithDate;
+ (NSString *)getPlatformRawString;
+ (NSAttributedString*)getCaptchaString;
+ (NSMutableArray *) getInitialScreensArray;
+(NSArray*)getComplaintZones;
+(NSArray*)getCentersForAadhar;
+(NSArray*)getRequestZones;
+(NSArray*)getApplicationTypesForPoliceAmplifier;
+(NSArray*)getInquiryTypesForVehicleStolen;
+(NSString *)getPayCardType:(NSString *)keyName;
+(NSString *)getPolicePayCardType:(NSString *)keyName;
+(NSArray *)getLicenceTypesArray;
+(NSArray *)getCitizenships;
+(NSArray *)getRelationTypes;
+(NSArray *)getStampsDocsList;
+(NSArray *)getStampsFeesList;
+(NSArray*)getIRCTCQuestionsList;
+(NSArray*)getIRCTCRegisterUserOccupations;
+(NSArray *)getGendersList;
+(NSString *)getTrainClassesValue:(NSString *)keyName;
+(NSArray *)getTrainClasses;
+(NSArray *)getTrainsQuota;
+(NSString *)getValueOfBerth:(NSString *)keyName;
+(NSArray *)getSleeper3ACBerthLevels;
+(NSArray *)get1ACBerthLevels;
+(NSArray *)get2ACBerthLevels;
+(NSArray *)getStampsContactsList;
+(NSArray*)getBloodgroupsArray;
+(NSArray *)rtoAgeProofCodes;
+(NSArray *)rtoAddressProofCodes;
+(NSArray *)getAppFonts;
+(NSString*)getNextDate:(NSString*)dateString addDays:(NSInteger)days;
+(NSString*)getdateMonthYear:(NSString*)dateString :(NSString*)oldFormat :(NSString*)newFormat;
+(NSString *) getLanguageStr :(NSString*)language ;
//MARK:- MysoreITS
+(NSArray *)getMysoreITSGenInfoServiceTypeList;
+ (NSString*) getSelectedMysoreITSServiceIDs:(NSString *)serviceType;
+(NSArray *)getMysoreITSGenInfoDirectionList;
+(NSArray *)getMysorePTIServiceTypeList;
+ (NSString*) getSelectedMysorePTIServiceIDs:(NSString *)serviceType;
+(NSArray *)getMysoreRTIServiceTypeList;
+ (NSString*) getSelectedMysoreRTIServiceIDs:(NSString *)serviceType;
+(NSArray *)getMysorePTIDayList;
+ (NSString*) getSelectedMysorePTIDaysIDs:(NSString *)selectedDay;
+(NSArray *)getWeatherInfoList;
+ (NSString*) getWeatherInfoListIDs:(NSString *)selectedType;
+(NSArray *)getGranularityList;
+(NSArray *)getHolidaysInfoList;
+ (NSString*) getHolidaysInfoListIDs:(NSString *)selectedType;

//MARK:- Get App Related Services
+ (NSString *)getServiceIdForPayment:(NSString *)keyName;
+(NSString *)getAppActionForDept:(NSString *)keyName;
+(NSArray *)getAllcompletedServices;

+ (NSMutableArray *) getUtilitesServices;
+ (NSMutableArray *) getPayFineChallans;
+ (NSMutableArray *) getPhoneBillsRecharges;
+ (NSMutableArray *) getRTOServices;
+ (NSMutableArray *) getBMRCLServices;
+ (NSMutableArray *) getBackwardclasses;
+ (NSMutableArray *) getSCRBServices;
+ (NSMutableArray *) getAadharServices;
+ (NSMutableArray *) getStampsRegistrationServices;
+ (NSMutableArray*)getTaxactionServices;
+ (NSMutableArray *) getKSRTCServices;
+ (NSMutableArray *) getIRCTCServices;
+ (NSMutableArray *) getPassportServices;
+ (NSMutableArray *) getMysoreITSServices;
+ (NSMutableArray *) getHDMCPropertyTaxServices;
+ (NSMutableArray *) getFRROPropertyServices;
+ (NSMutableArray *) getKSNDMCServices;
+ (NSMutableArray *) getKSTDCPropertyServices;

//MARK:- Get All Services
+(NSArray*) getAllServices :(NSArray*)favouritiesArray;
+(NSMutableArray *)getLocationServicesArray:(int)i favArray:(NSArray *)favouritiesArray;
+(NSMutableArray *)getRaiseComplaintsServicesArray:(int)i favArray:(NSArray *)favouritiesArray ;
+(NSMutableArray *) getGovernmentServicesArray :(int)i favArray:(NSArray *)favouritiesArray;
+(NSMutableArray*) getTransfortServicesArray:(int)i favArray:(NSArray *)favouritiesArray;
+(NSMutableArray *)getB2CServicesArray:(int)i favArray:(NSArray*)favouritiesArray;

+(NSArray *)getLanguageTypesArray;
+(NSArray *)getPackagesTypesArray;
+(NSArray *)getDamsTypesArray;
+(NSArray *)getFileTDRReasonsList;
+(NSAttributedString*)setAttributedStringForString:(NSString*)stringtoChange range:(NSRange)rangeofString colortochange:(UIColor*)color NormalTextFont:(UIFont*)font normalTextColor:(UIColor*)textColor Underline:(BOOL)isUnderLine;
+(NSAttributedString*)setDiffFontAttributedStringForString:(NSString*)stringtoChange range:(NSRange)rangeofString colortochange:(UIColor*)color NormalTextFont:(UIFont*)font normalTextColor:(UIColor*)textColor Underline:(BOOL)isUnderLine highLightTextFont:(UIFont*)font1;
+(NSAttributedString*)setAttributedStringForMultipleStrings:(NSString*)stringtoChange range:(NSRange)rangeofString range1:(NSRange)rangeofString1 range2:(NSRange)rangeofString2 range3:(NSRange)rangeofString3 colortochange:(UIColor*)color NormalTextFont:(UIFont*)font normalTextColor:(UIColor*)textColor Underline:(BOOL)isUnderLine;


#pragma mark - Toast Message
+ (void)writeToast:(NSString *)message;
+ (void) showErrorToastMessage:(id)object;
#pragma mark - Check Internet Availability
+ (BOOL)isInternetAvailable;
+(NSString*) checkNetworkCurrentStatusWithType;
@end
