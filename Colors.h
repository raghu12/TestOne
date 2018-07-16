//
//  Colors.h
//  GOK
//
//  Created by admin on 4/11/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#ifndef Colors_h
#define Colors_h

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]


#define THICK_BLUE_COLOR RGB(24, 125 , 199)
#define APP_THEME_BLUE_COLOR RGB(15,48, 167)
#define TAB_BAR_COLOR RGB(82, 85, 228)
#define APP_LIGHT_GRAY_COLOR RGB(234, 236, 242)
#define TF_BG_COLOR RGB(246,247, 249)
#define APP_BUTTON_GRAY_COLOR RGB(108,127, 157)

#define SECTION_HEADER_BLUE_COLOR RGB(104, 138, 247)
#define BLACK_TEXT_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75]
#define PAYMENT_SECTION_HEADER_BLUE_COLOR RGB(179, 195, 250)

#define TEXT_APP_THEME_YELLOW_COLOR [UIColor colorFromHexString:@"#1d3e66" withOpacity:1.0]
#define MOST_USED_BG_COLOR [UIColor colorFromHexString:@"#d8dbec" withOpacity:1.0]
#define TEXT_GRAY_COLOR [UIColor colorFromHexString:@"#8f8e8e" withOpacity:1.0]
#define NAV_BAR_APP_THEME_YELLOW_COLOR [UIColor colorFromHexString:@"#112FA9" withOpacity:1.0]

#define APP_THEME_YELLOW_COLOR RGB(246, 206 , 70)
#define THEME_LIGHT_COLOR RGB(186, 163 , 61)
#define TAB_BAR_FONT_COLOR RGB(204, 204 , 204)
#define GREEN_TEXT_COLOR RGB(128, 220,  140)
#define RED_TEXT_COLOR RGB(233, 104, 98)
#define CAPTCHA_VIEW_BG_COLOR RGB(37,61,100)

#define LIGHT_GRAY_COLOR [UIColor lightGrayColor]
#define DARK_GRAY_COLOR [UIColor darkGrayColor]

#define BLACK_COLOR [UIColor blackColor]
#define BLUE_COLOR [UIColor blueColor]
#define RED_COLOR [UIColor redColor]
#define YELLOW_COLOR [UIColor yellowColor]
#define ORANGE_COLOR [UIColor orangeColor]

#define LINE_LIGHT_COLOR [UIColor colorWithWhite:1.0 alpha:0.3]
#define WHITE_COLOR [UIColor whiteColor]
#define GRAY_TRANSPARENT_COLOR [UIColor colorFromHexString:@"#F1F2F1" withOpacity:1.0]
#define BAR_BUTTON_GRAY_COLOR [UIColor colorFromHexString:@"#C9C9C9" withOpacity:1]
#define LIGHT_TRANSPARENT_COLOR [UIColor colorFromHexString:@"#AAAAAA" withOpacity:0.3]
#define WHITE_COLOR_LIGHT [UIColor colorWithWhite:1 alpha:0.5]
#define CLEAR_COLOR [UIColor clearColor]
#define BLACK_COLOR_WITH_OPACITY [UIColor colorFromHexString:@"#000000" withOpacity:0.6]



#define UIColorFromRGB(rgbValue) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8) /255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue &0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#endif /* Colors_h */
