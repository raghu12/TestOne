//
//  UserDefaults.m
//  GOK
//
//  Created by admin on 4/30/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#import "UserDefaults.h"
static UserDefaults *userDefaults = nil;

@implementation UserDefaults

#pragma mark -
#pragma mark - Singleton Class

+(UserDefaults*)singletonUserDefaultsClass {
    
    TCSTART
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        if (userDefaults==nil) {
            userDefaults = [[UserDefaults alloc] init];
        }
    });
    return userDefaults;
    
    TCEND
}

+(id)alloc {
    
    NSAssert(userDefaults == nil, @"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}


#pragma mark -
#pragma mark - Default Setters && Getters

//==================================================================//
+ (BOOL) isAppAlreadyLaunched {
    return [Defaults boolForKey:@"launched"];
}
+ (void) setAppAlreadyLaunched:(BOOL)launched {
    [Defaults setBool:launched forKey:@"launched"];
    [Defaults synchronize];
}

//==================================================================//
+ (BOOL) isUserLoggedIn {
    return [Defaults boolForKey:@"userLogged"];
}
+ (void) setUserLoggedIn:(BOOL) firstTime {
    [Defaults setBool:firstTime forKey:@"userLogged"];
    [Defaults synchronize];
}
//==================================================================//
+ (void)setUserName:(NSString *)name
{
    [Defaults setValue:name forKey:@"userName"];
    [Defaults synchronize];
}
+ (NSString *)getUserName
{
    return [Defaults valueForKey:@"userName"];

}
//==================================================================//
+ (BOOL) isLanguageSelected {
    return [Defaults boolForKey:@"language"];
}
+ (void) setLanguageSelected:(BOOL)language {
    [Defaults setBool:language forKey:@"language"];
    [Defaults synchronize];
}

//==================================================================//
+ (BOOL) isFavorotiesCount {
       return [Defaults boolForKey:@"favCount"];
}
+ (void) setFavorotiesCount:(BOOL)favCount {
    [Defaults setBool:favCount forKey:@"favCount"];
    [Defaults synchronize];
}

//==================================================================//
+ (void)setAadharResponseString:(NSString *)aadharString {
    [Defaults setValue:aadharString forKey:@"aadharString"];
    [Defaults synchronize];
}
+ (NSString *)getAadharResponseString {
    return [Defaults valueForKey:@"aadharString"];
}

//==================================================================//
+ (void)setAadharNumber:(NSString *)aadharNum {
    [Defaults setValue:aadharNum forKey:@"aadharNum"];
    [Defaults synchronize];
}
+ (NSString *)getAadharNumber {
    return [Defaults valueForKey:@"aadharNum"];
}

 //==================================================================//
+ (void)setEmail:(NSString *)email {
    [Defaults setValue:email forKey:@"email"];
    [Defaults synchronize];
}
+ (NSString *)getEmail {
    return [Defaults valueForKey:@"email"];
}

//==================================================================//
+ (void)setLLTestSessionId:(NSString *)sessionId {
    [Defaults setValue:sessionId forKey:@"sessionId"];
    [Defaults synchronize];
}
+ (NSString *)getLLTestSessionId {
    return [Defaults valueForKey:@"sessionId"];
}

//==================================================================//
+ (void)setLLDLApplicationType:(NSString *)lldlapplicationType {
    [Defaults setValue:lldlapplicationType forKey:@"lldlapplicationType"];
    [Defaults synchronize];
}
+ (NSString *)getLLDLApplicationType {
    return [Defaults valueForKey:@"lldlapplicationType"];
}

//==================================================================//
+ (BOOL) showChangePasswordScreen {
    return [Defaults boolForKey:@"changePWD"];
}
+ (void) setToShowChangePasswordScreen:(BOOL)changePWD {
    [Defaults setBool:changePWD forKey:@"changePWD"];
    [Defaults synchronize];
}

//==================================================================//
+ (void)setPassword:(NSString *)password {
    [Defaults setValue:password forKey:@"password"];
    [Defaults synchronize];
}
+ (NSString *)getPassword {
    return [Defaults valueForKey:@"password"];
}

//==================================================================//
+ (void)setUserMobile:(NSString *)userMobile {
    [Defaults setValue:userMobile forKey:@"userMobile"];
    [Defaults synchronize];
}
+ (NSString *)getUserMobile {
    return [Defaults valueForKey:@"userMobile"];
}

//==================================================================//
+ (void)setUserProfileDict:(NSDictionary *)userProfile {
    TCSTART
    NSData *data = nil;
    if (userProfile) {
        data = [NSKeyedArchiver archivedDataWithRootObject:userProfile];
    }
    [Defaults setObject:data forKey:@"userProfile"];
    [Defaults synchronize];
    TCEND
}
+ (NSDictionary *)getUserProfileDict {
    TCSTART
    NSData *data = [Defaults objectForKey:@"userProfile"];
    NSDictionary *userDict = nil;
    if (data) {
        userDict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return userDict;
    TCEND
}

//==================================================================//
+ (void)setPushRegistrationId:(NSString *)registrationId {
    [Defaults setValue:registrationId forKey:@"pushRegId"];
    [Defaults synchronize];
}
+ (NSString *)getPushRegistrationId {
    return [Defaults valueForKey:@"pushRegId"];
}

//==================================================================//
+ (void)setUDID:(NSString *)UDID {
    [Defaults setValue:UDID forKey:@"UDID"];
    [Defaults synchronize];
}
+ (NSString *)getUDID {
    return [Defaults valueForKey:@"UDID"];
}

//==================================================================//
+ (BOOL) isNotificationEnabled {
    return [Defaults boolForKey:@"notificaitonEnable"];
}
+ (void) setNotificationEnable:(BOOL) notificaitonEnable {
    [Defaults setBool:notificaitonEnable forKey:@"notificaitonEnable"];
    [Defaults synchronize];
}

//==================================================================//
+ (void)setScreenValue:(NSString *)screenStr {
    [Defaults setValue:screenStr forKey:@"scrname"];
    [Defaults synchronize];
}
+ (NSString *)getScreenValue {
    return [Defaults valueForKey:@"scrname"];
}

@end
