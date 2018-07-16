//
//  UserDefaults.h
//  GOK
//
//  Created by admin on 4/30/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

+(UserDefaults*)singletonUserDefaultsClass;

#pragma mark - Default Setters && Getters

+ (BOOL) isAppAlreadyLaunched;
+ (void) setAppAlreadyLaunched:(BOOL)launched;

+ (BOOL) isUserLoggedIn;
+ (void) setUserLoggedIn:(BOOL) firstTime;

+ (BOOL) isLanguageSelected;
+ (void) setLanguageSelected:(BOOL)language;

+ (BOOL) isFavorotiesCount;
+ (void) setFavorotiesCount:(BOOL)favCount;

+ (void)setAadharResponseString:(NSString *)aadharString;
+ (NSString *)getAadharResponseString;

+ (void)setAadharNumber:(NSString *)aadharNum;
+ (NSString *)getAadharNumber;

+ (void)setEmail:(NSString *)email;
+ (NSString *)getEmail;

+ (void)setLLTestSessionId:(NSString *)sessionId;
+ (NSString *)getLLTestSessionId;

+ (void)setLLDLApplicationType:(NSString *)lldlapplicationType;
+ (NSString *)getLLDLApplicationType;

+ (BOOL) showChangePasswordScreen;
+ (void) setToShowChangePasswordScreen:(BOOL)changePWD;

+ (void)setUserName:(NSString *)userMobile;
+ (NSString *)getUserName;

+ (void)setPassword:(NSString *)password;
+ (NSString *)getPassword;

+ (void)setUserMobile:(NSString *)userMobile;
+ (NSString *)getUserMobile;

+ (void)setUserProfileDict:(NSDictionary *)userProfile;
+ (NSDictionary *)getUserProfileDict;

+ (void)setPushRegistrationId:(NSString *)registrationId;
+ (NSString *)getPushRegistrationId;

+ (void)setUDID:(NSString *)UDID;
+ (NSString *)getUDID;

+ (BOOL) isNotificationEnabled;
+ (void) setNotificationEnable:(BOOL) notificaitonEnable;

+ (void)setScreenValue:(NSString *)screenStr;
+ (NSString *)getScreenValue;

@end
