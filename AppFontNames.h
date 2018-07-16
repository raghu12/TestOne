//
//  AppFontNames.h
//  GOK
//
//  Created by admin on 5/10/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#ifndef AppFontNames_h
#define AppFontNames_h

//MARK:- Fonts
#define APP_TOUR_BIG_REGULAR_FONT (IS_IPAD ? Roboto_Regular(28) : (IS_IPHONE_4_OR_LESS ? Roboto_Regular(16) : (IS_IPHONE_5 ? Roboto_Regular(18) : (IS_IPHONE_6 ? Roboto_Regular(20) : Roboto_Regular(24)))))
#define APP_TOUR_LIGHT_FONT (IS_IPAD ? Roboto_Light(24) : (IS_IPHONE_4_OR_LESS ? Roboto_Light(14) : (IS_IPHONE_5 ? Roboto_Light(16) : (IS_IPHONE_6 ? Roboto_Light(18) : Roboto_Light(20)))))


#define BIG_TITLE_ROBOTO_LIGHT_FONT (IS_IPAD ? Roboto_Light(20) : (IS_IPHONE_4_OR_LESS ? Roboto_Light(15) : (IS_IPHONE_5 ? Roboto_Light(17) : Roboto_Light(18))))
#define TITLE_ROBOTO_LIGHT_FONT (IS_IPAD ? Roboto_Light(18) : (IS_IPHONE_4_OR_LESS ? Roboto_Light(14) : (IS_IPHONE_5 ? Roboto_Light(15) : Roboto_Light(16))))
#define MEDIUM_TITLE_ROBOTO_LIGHT_FONT (IS_IPAD ? Roboto_Light(17) : (IS_IPHONE_4_OR_LESS ? Roboto_Light(13) : (IS_IPHONE_5 ? Roboto_Light(14) : Roboto_Light(15))))
#define SUB_TITLE_ROBOTO_LIGHT_FONT (IS_IPAD ? Roboto_Light(16) : (IS_IPHONE_4_OR_LESS ? Roboto_Light(12) : (IS_IPHONE_5 ? Roboto_Light(13) : Roboto_Light(14))))
#define SMALL_TITLE_ROBOTO_LIGHT_FONT (IS_IPAD ? Roboto_Light(14) : (IS_IPHONE_4_OR_LESS ? Roboto_Light(9) : (IS_IPHONE_5 ? Roboto_Light(10) : Roboto_Light(12))))

#define BUTTON_ROBOTO_REGULAR_FONT (IS_IPAD ? Roboto_Regular(18) : (IS_IPHONE_4_OR_LESS ? Roboto_Regular(14) : (IS_IPHONE_5 ? Roboto_Regular(15) : Roboto_Regular(16))))

#define BUTTON_ROBOTO_MIN_REGULAR_FONT (IS_IPAD ? Roboto_Regular(16) : (IS_IPHONE_4_OR_LESS ? Roboto_Regular(12) : (IS_IPHONE_5 ? Roboto_Regular(13) : Roboto_Regular(14))))



#define Roboto_Thin(n) [UIFont fontWithName:@"Roboto-Thin" size:n]
#define Roboto_ThinItalic(n) [UIFont fontWithName:@"Roboto-ThinItalic" size:n]
#define Roboto_Light(n) [UIFont fontWithName:@"Roboto-Light" size:n]
#define Roboto_LightItalic(n) [UIFont fontWithName:@"Roboto-LightItalic" size:n]
#define Roboto_BlackItalic(n) [UIFont fontWithName:@"Roboto-BlackItalic" size:n]
#define Roboto_Bold(n) [UIFont fontWithName:@"Roboto-Bold" size:n]
#define Roboto_BoldItalic(n) [UIFont fontWithName:@"Roboto-BoldItalic" size:n]
#define Roboto_Regular(n) [UIFont fontWithName:@"Roboto-Regular" size:n]
#define Roboto_Medium(n) [UIFont fontWithName:@"Roboto-Medium" size:n]
#define Roboto_MediumItalic(n) [UIFont fontWithName:@"Roboto-MediumItalic" size:n]

#define RobotoCondensed_Bold(n) [UIFont fontWithName:@"RobotoCondensed-Bold" size:n]
#define RobotoCondensed_BoldItalic(n) [UIFont fontWithName:@"RobotoCondensed-BoldItalic" size:n]
#define RobotoCondensed_Light(n) [UIFont fontWithName:@"RobotoCondensed-Light" size:n]
#define RobotoCondensed_LightItalic(n) [UIFont fontWithName:@"RobotoCondensed-LightItalic" size:n]
#define RobotoCondensed_Italic(n) [UIFont fontWithName:@"RobotoCondensed-Italic" size:n]
#define RobotoCondensed_Regular(n) [UIFont fontWithName:@"RobotoCondensed-Regular" size:n]


#define HELVETICA_LIGHT_FONT(n) [UIFont fontWithName:@"Helvetica Light" size:n]
#define SYSTEM_FONT(n) [UIFont systemFontOfSize:n]
#define BOLD_SYSTEM_FONT(n) [UIFont boldSystemFontOfSize:n]
#define TOAST_FONT_10 [UIFont systemFontOfSize:16]


#endif /* AppFontNames_h */
