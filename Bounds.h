//
//  Bounds.h
//  GOK
//
//  Created by admin on 4/16/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#ifndef Bounds_h
#define Bounds_h

#define BOUNDS [UIScreen mainScreen].bounds

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define LISTING_WIDTH SCREEN_WIDTH/2-10
#define LISTING_CONTENT_HEIGHT 132

#define BANNER_HEIGHT [UIScreen mainScreen].bounds.size.height*0.3

///////////////////// USER INTERFACE DEVICES ////////////////////////
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
#define IPHONE   UIUserInterfaceIdiomPhone
///////////////////// USER INTERFACE DEVICES ////////////////////////

///////////////////// TO IDENTIFY IPHONE MODELS ////////////////////////
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_ZOOMED (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5     (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6     (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P   (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X     (IS_IPHONE && SCREEN_MAX_LENGTH == 812 .0)

#define IS_IOS10_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
#define IS_IOS9_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
#define IS_IOS8_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
#define IS_IOS7_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define IS_IOS8_AND_BELOW ([[UIDevice currentDevice].systemVersion floatValue] <= 8.0)








///////////////////// USER INTERFACE DEVICES ////////////////////////


#endif /* Bounds_h */
