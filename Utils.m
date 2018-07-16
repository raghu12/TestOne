//
//  Utils.m
//  GOK
//
//  Created by admin on 4/13/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#import "Utils.h"
static Utils *utils = nil;

@implementation Utils
+(Utils*)singletonUtilsClass {
    
    TCSTART
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        if (utils==nil) {
            utils = [[Utils alloc] init];
        }
    });
    return utils;
    
    TCEND
}

+(id)alloc {
    
    NSAssert(utils == nil, @"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}

#pragma mark - JSON Related

+ (NSDictionary*) parseURL:(NSURL *)url
{
    
    NSString * q = [url query];
    NSArray * pairs = [q componentsSeparatedByString:@"&"];
    NSMutableDictionary * kvPairs = [NSMutableDictionary dictionary];
    for (NSString * pair in pairs) {
        NSArray * bits = [pair componentsSeparatedByString:@"="];
        
        NSString * key = [[bits objectAtIndex:0] stringByRemovingPercentEncoding];
        NSString * value = [[bits objectAtIndex:1] stringByRemovingPercentEncoding];
        
        //        NSString * key = [[bits objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //        NSString * value = [[bits objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [kvPairs setObject:value forKey:key];
    }
    return kvPairs;
}

+ (NSString *)jsonFromId:(id)json
{
    NSError *error;
    NSData *jsonData;
    if (json) {
        jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSMutableDictionary *) dictionaryWithPropertiesOfObject:(id)obj
{
    
    TCSTART
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        id object = [obj valueForKey:key];
        if(object != nil)
            [dict setObject:object forKey:key];
    }
    
    free(properties);
    
    return [NSMutableDictionary dictionaryWithDictionary:dict];
    TCEND
}

+ (void)registerDeviceForRemoteNotifications
{
    
    TCSTART
#if !(TARGET_IPHONE_SIMULATOR)
    [SERVICE_MANAGER methodName:POST_REQUEST urlString:BASE_URL params:nil withLodingView:NO completion:^(id responseObject, long responseCode) {
        if (responseCode == 200) {
            DLog("Device Registration Success");
        } else {
            DLog("device registration failure");
        }
    } failure:^(id errorResponse) {
        DLog("device registration failure");
    }];
#endif
    
    TCEND
}

+ (void) removeNSUserDefaultsPersistanceStorage
{
    
    TCSTART
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        if ([key isKindOfClass:[NSString class]]) {
            NSString *myString = (NSString *)key;
            if ([myString isEqual:@"pushRegId"] || [myString isEqual:@"UDID"] || [myString isEqual:@"language"] || [myString isEqual:@"launched"] ) {
                DLog(@"---- don't remove keys --- %@", myString);
            } else {
                [defs removeObjectForKey:key];
                [defs synchronize];
            }
        }
    }
    TCEND
}


+ (NSAttributedString*) getAttributedTitle:(NSString*)string withFont:(UIFont*)font withColor:(UIColor *)color
{
    TCSTART
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
     NSDictionary *dict1 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle), NSFontAttributeName:font, NSParagraphStyleAttributeName:style, NSForegroundColorAttributeName: color};
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:dict1]];
    return attString;
    TCEND
}


+(BOOL)isEmptyValue:(id)object
{
    TCSTART
    if([object isKindOfClass:[NSNull class]] || object == nil || [object isEqual:@""] || [object isEqual:@" "] || object == (id)[NSNull null] || object == [NSNull null] ){
        return YES;
    }
    return NO;
    TCEND
}

+ (CGFloat)getLabelHeight:(UILabel*)label
{
    TCSTART
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
    TCEND
}

+(UIImage*)setColorForImageView:(UIImageView*)imageView withColor:(UIColor*) color
{
    TCSTART
    UIImage *coloredImage = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [imageView setTintColor:color];
    return coloredImage;
    TCEND
}

+(UIImage*)setColorForHilightedImageView:(UIImageView*)imageView withColor:(UIColor*) color
{
    TCSTART
    UIImage *coloredImage = [imageView.highlightedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [imageView setTintColor:color];
    return coloredImage;
    TCEND
}

+ (void)applyShadowToSubView : (UIView *) view withBackgroundColor:(UIColor*)viewBgColor
{
    TCSTART
    view.backgroundColor = viewBgColor;
    view.tintColor = WHITE_COLOR;
    view.layer.shadowColor = [DARK_GRAY_COLOR CGColor];
    view.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    view.layer.shadowRadius = 3.0f;
    view.layer.shadowOpacity = 2.0f;
    view.layer.masksToBounds=NO;
    TCEND
}

+(NSMutableAttributedString *)withAtrributedString:(NSString *)attrString withPlainString:(NSString *)plainString {
    
    TCSTART
    NSMutableAttributedString *mutableAttString = [[NSMutableAttributedString alloc] init];
    NSDictionary *attributes = @{
                                 NSFontAttributeName : TITLE_ROBOTO_LIGHT_FONT,
                                 NSForegroundColorAttributeName : DARK_GRAY_COLOR,
                                 };
    
    NSDictionary *attributes1 = @{
                                  NSFontAttributeName : SUB_TITLE_ROBOTO_LIGHT_FONT,
                                  NSForegroundColorAttributeName : DARK_GRAY_COLOR,
                                  };
    
    NSAttributedString *newAttString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: ", attrString] attributes:attributes];
    NSAttributedString *newAttString1 = [[NSAttributedString alloc] initWithString:plainString attributes:attributes1];
    [mutableAttString appendAttributedString:newAttString];
    [mutableAttString appendAttributedString:newAttString1];
    return  mutableAttString;
    TCEND
}

+(NSMutableAttributedString *)withString1:(NSString *)string1 withColor1:(UIColor*)color1 plainFont1:(UIFont*)font1 withColon:(NSString *)colon withString2:(NSString *)string2 withColor2:(UIColor*)color2 plainFont2:(UIFont*)font2{
    
    TCSTART
    NSMutableAttributedString *mutableAttString = [[NSMutableAttributedString alloc] init];
    NSDictionary *attributes = @{
                                 NSFontAttributeName : font1,
                                 NSForegroundColorAttributeName : color1,
                                 };
    NSDictionary *attributes1 = @{
                                  NSFontAttributeName : font2,
                                  NSForegroundColorAttributeName : color2,
                                  };
    NSAttributedString *newAttString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@ ", (![Utils isEmptyValue:string1] ? string1 : @""), colon] attributes:attributes];
    NSAttributedString *newAttString1 = [[NSAttributedString alloc] initWithString:(![Utils isEmptyValue:string2] ? string2 : @"") attributes:attributes1];
    [mutableAttString appendAttributedString:newAttString];
    [mutableAttString appendAttributedString:newAttString1];
    return  mutableAttString;
    TCEND
}


+(NSMutableAttributedString *)withPlainString:(NSString *)plainString plainColor:(UIColor*)plainColor withColon:(NSString *)colon withAtrributedString:(NSString *)attrString attributedColor:(UIColor*)attrColor{
    
    TCSTART
    NSMutableAttributedString *mutableAttString = [[NSMutableAttributedString alloc] init];
    NSDictionary *attributes = @{
                                 NSFontAttributeName : SUB_TITLE_ROBOTO_LIGHT_FONT,
                                 NSForegroundColorAttributeName : plainColor,
                                 };
    NSDictionary *attributes1 = @{
                                  NSFontAttributeName : ([plainColor isEqual:attrColor] ? SUB_TITLE_ROBOTO_LIGHT_FONT : MEDIUM_TITLE_ROBOTO_LIGHT_FONT),
                                  NSForegroundColorAttributeName : attrColor,
                                  };
    NSAttributedString *newAttString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@ ", (![Utils isEmptyValue:plainString] ? plainString : @""), colon] attributes:attributes];
    NSAttributedString *newAttString1 = [[NSAttributedString alloc] initWithString:(![Utils isEmptyValue:attrString] ? attrString : @"") attributes:attributes1];
    [mutableAttString appendAttributedString:newAttString];
    [mutableAttString appendAttributedString:newAttString1];
    return  mutableAttString;
    TCEND
}
+(NSAttributedString*)setAttributedStringForMultipleStrings:(NSString*)stringtoChange range:(NSRange)rangeofString range1:(NSRange)rangeofString1 range2:(NSRange)rangeofString2 range3:(NSRange)rangeofString3 colortochange:(UIColor*)color NormalTextFont:(UIFont*)font normalTextColor:(UIColor*)textColor Underline:(BOOL)isUnderLine
{
    NSMutableString * str = [[NSMutableString alloc] initWithString:stringtoChange];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, str.length)];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, str.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:rangeofString];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:rangeofString1];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:rangeofString2];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:rangeofString3];
    
    //TextColor
    if (isUnderLine) {
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:1] range:NSMakeRange(0, str.length)];
        [attributedString addAttribute:NSUnderlineColorAttributeName value:color range:NSMakeRange(0, str.length)];
    }
    
    return attributedString;
}
+(NSAttributedString*)setAttributedStringForString:(NSString*)stringtoChange range:(NSRange)rangeofString colortochange:(UIColor*)color NormalTextFont:(UIFont*)font normalTextColor:(UIColor*)textColor Underline:(BOOL)isUnderLine
{
    NSMutableString * str = [[NSMutableString alloc] initWithString:stringtoChange];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, str.length)];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, str.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:rangeofString];
    //TextColor
    if (isUnderLine) {
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:1] range:NSMakeRange(0, str.length)];
        [attributedString addAttribute:NSUnderlineColorAttributeName value:color range:NSMakeRange(0, str.length)];
    }
    
    return attributedString;
}

+(NSAttributedString*)setDiffFontAttributedStringForString:(NSString*)stringtoChange range:(NSRange)rangeofString colortochange:(UIColor*)color NormalTextFont:(UIFont*)font normalTextColor:(UIColor*)textColor Underline:(BOOL)isUnderLine highLightTextFont:(UIFont*)font1
{
    NSMutableString * str = [[NSMutableString alloc] initWithString:stringtoChange];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, str.length)];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, str.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:rangeofString];
    [attributedString addAttribute:NSFontAttributeName value:font1 range:rangeofString];
    //TextColor
    if (isUnderLine) {
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:1] range:NSMakeRange(0, str.length)];
        [attributedString addAttribute:NSUnderlineColorAttributeName value:color range:NSMakeRange(0, str.length)];
    }
    
    return attributedString;
}


+ (UIImage *)imageWithColor:(UIColor *)color {
    TCSTART
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    TCEND
}

#pragma mark - Getters

+ (BOOL)arraysContainSameObjects:(NSArray *)array1 andOtherArray:(NSArray *)array2 {
    TCSTART
    BOOL bothArraysContainTheSameObjects = NO;
    for (id objectInArray1 in array1) {
        BOOL objectFoundInArray2 = NO;
        for (id objectInArray2 in array2) {
            if ([objectInArray1 isEqual:objectInArray2]) {
                objectFoundInArray2 = YES;
                break;
            }
        }
        if (objectFoundInArray2) {
            bothArraysContainTheSameObjects = YES;
            break;
        }
    }
    return bothArraysContainTheSameObjects;
    TCEND
}

+(NSInteger) getDigitsFromText : (NSString *)text {
    
    TCSTART
    NSString *numberString;
    NSScanner *scanner = [NSScanner scannerWithString:text];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    return [numberString integerValue];
    TCEND
}
+(NSInteger) getAgeFromDOB:(NSString*)dob {
    TCSTART
    if (![Utils isEmptyValue:dob]) {
        NSDateFormatter *df = [NSDateFormatter new];
        [df setDateFormat:@"dd-MM-yyyy"];
        NSDate* now = [NSDate date];
        NSDateComponents* ageComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[df dateFromString:dob] toDate:now options:0];
        NSInteger age = [ageComponents year];
        return age;
    }
    return 0;
 
    TCEND
}
+ (NSMutableArray *) getMonthList
{
    TCSTART
    NSArray  *mutArrMonth = [[NSArray alloc] initWithObjects:@"01", @"02",@"03",@"04", @"05",@"06",@"07", @"08",@"09",@"10", @"11",@"12", nil];
    return [[NSMutableArray alloc] initWithArray:mutArrMonth];
    TCEND
}

+ (NSMutableArray *) getYearList
{
    TCSTART
    NSMutableArray  *mutArrYear = [[NSMutableArray alloc] init];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger toYear = [components year];
    NSInteger fromYear  = toYear - 9;
    for (NSInteger cnt = toYear; cnt >= fromYear; cnt --)     {
        [mutArrYear addObject:[NSString stringWithFormat:@"%ld",(long)cnt]];
    }
    return mutArrYear;
    TCEND
}

+ (NSMutableArray *) getAcademicYears
{
    TCSTART
    NSMutableArray  *mutArrYear = [[NSMutableArray alloc] init];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger fromYear = [components year] - 6;
    NSInteger toYear  = [components year];
    for (NSInteger cnt = toYear; cnt > fromYear; cnt --)     {
//        [mutArrYear insertObject:[NSString stringWithFormat:@"%ld - %ld",(long)cnt , ((long)cnt+1)] atIndex:cnt];
        NSString *yearString = [NSString stringWithFormat:@"%ld", ((long)cnt+1)];
        NSString *code = [yearString substringFromIndex: [yearString length] - 2];
        [mutArrYear addObject:[NSString stringWithFormat:@"%ld-%@",(long)cnt , code]];
    }
    return mutArrYear;
    TCEND
}

+ (NSMutableArray *) getRechargeAmounts
{
    TCSTART
    NSMutableArray *rcArray = [NSMutableArray new];
    for (int i =0; i<10; i++) {
        [rcArray insertObject:[NSString stringWithFormat:@"%ld", (long)((i+1)*50)] atIndex:i];
    }
    return rcArray;
    TCEND
}

 + (NSString*)getRandom:(NSInteger)lenth {
    TCSTART
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: lenth];
    
    for (int i=0; i<lenth; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length]) % [letters length]]];
    }
    return randomString;
    TCEND
}

+(NSString * )getAppVersion
{
    TCSTART
    NSString * appVersionString = [NSString stringWithFormat:@"App Version : %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    return appVersionString;
    TCEND
}

+(NSString*)getPrefixCharacterFrom:(NSString *)string
{
    
    TCSTART
    if (![Utils isEmptyValue:string]) {
        if (string.length > 1) {
        return [string substringToIndex:1];
        }
    }
    return @"";
   
    TCEND
}

+(NSString*)getFirstWordFromString:(NSString *)string withSeparator:(NSString *)separator
{
    
    TCSTART
    if (![Utils isEmptyValue:string]) {
        NSArray *stringsArray = [string componentsSeparatedByString:separator];
         NSString *subString;
        if (stringsArray.count >0) {
            subString = stringsArray[0];
        }
        return subString;
    }
    return string;
    
    TCEND
}

+(NSString*)getAllFirstCharacterFrom:(NSString *)string
{
    
    TCSTART
    if (![Utils isEmptyValue:string]) {
        NSArray *stringsArray = [string componentsSeparatedByString:@" "];
        NSMutableString *finalString = [NSMutableString new];
        for (int i =0; i<stringsArray.count; i++) {
            NSString *subString = stringsArray[i];
            if (subString.length > 1) {
                [finalString appendString:[subString substringToIndex:1]];
            }
        }
        return finalString;
    }
    return @"";
    
    TCEND
}

+(NSString*)getPrefix2CharactersFrom:(NSString *)string
{
    TCSTART
    if (![Utils isEmptyValue:string]) {
        if (string.length > 2) {
            return [string substringToIndex:2];
        }
    }
    
    return @"";
   
    TCEND
}

+(BOOL)celloneInvoiceNumberValidation :(NSString *)inputNum
{
    TCSTART
    BOOL numFlag=YES;
    if([inputNum length] == 0)     {
        DISPLAY_TOAST(ENTER_INVOICE_NUMBER);
        numFlag = NO;
        return numFlag;
    }
    if ([inputNum length ] < INVOICE_OR_ACCOUNT_MAX_DIGIT) {
        DISPLAY_TOAST(ENTER_VALID_INVOICE_NUMBER);
        numFlag= NO;
        return numFlag;
    }
    inputNum = [inputNum stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *frstCharcater = [inputNum substringToIndex:1];
    if([inputNum length]==9) {
        if([frstCharcater isEqualToString:@"2"] || [frstCharcater isEqualToString:@"3"] || [frstCharcater isEqualToString:@"6"] || [frstCharcater isEqualToString:@"7"] || [frstCharcater isEqualToString:@"8"]) {
            numFlag = YES;
        } else {
            DISPLAY_TOAST(ENTER_VALID_INVOICE_NUMBER);
            numFlag = NO;
        }
    }  else {
        DISPLAY_TOAST(ENTER_VALID_INVOICE_NUMBER);
        numFlag = NO;
    }
    return numFlag;
    TCEND
}

+(BOOL)celloneAccoutNumberValidation :(NSString *)inputNum
{
    TCSTART
    BOOL numFlag=YES;
    if([inputNum length] == 0)     {
        DISPLAY_TOAST(ENTER_ACCOUNT_NUMBER);
        numFlag = NO;
        return numFlag;
    }
    if ([inputNum length ] < INVOICE_OR_ACCOUNT_MAX_DIGIT) {
        DISPLAY_TOAST(ENTER_VALID_ACCOUNT_NUMBER);
        numFlag= NO;
        return numFlag;
    }
    inputNum = [inputNum stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *frstCharcater = [inputNum substringToIndex:1];
    if([inputNum length]==9) {
        if([frstCharcater isEqualToString:@"2"] || [frstCharcater isEqualToString:@"5"] ) {
            numFlag = YES;
        } else {
            DISPLAY_TOAST(ENTER_VALID_ACCOUNT_NUMBER);
            numFlag = NO;
        }
    }  else {
        DISPLAY_TOAST(ENTER_VALID_ACCOUNT_NUMBER);
        numFlag = NO;
    }
    return numFlag;
    TCEND
}

+(BOOL)validateEmergencyContact1 :(NSString *)inputNum
{

    TCSTART
    BOOL numFlag=YES;
    if([inputNum length] == 0)     {
        DISPLAY_TOAST(ENTER_EMER1_TOAST);
        numFlag = NO;
        return numFlag;
    }
    if ([inputNum length ] < 10) {
        DISPLAY_TOAST(ENTER_VALID_EMER1_TOAST);
        numFlag= NO;
        return numFlag;
    }
    inputNum = [inputNum stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *frstCharcater = [inputNum substringToIndex:1];
    NSString *frstTwoCharcaters = [inputNum substringToIndex:2];
    NSString *frstThreeCharcaters = [inputNum substringToIndex:3];
    
    
    if([inputNum length]==10) {
        if([frstCharcater isEqualToString:@"9"] || [frstCharcater isEqualToString:@"8"] || [frstCharcater isEqualToString:@"7"] || [frstCharcater isEqualToString:@"6"]) {
            numFlag = YES;
        } else {
            DISPLAY_TOAST(ENTER_VALID_EMER1_TOAST);
            numFlag = NO;
        }
    } else if ([inputNum length ] == 11 && [frstCharcater isEqualToString:@"0"]) {
        if([frstTwoCharcaters isEqualToString:@"09"] || [frstTwoCharcaters isEqualToString:@"08"] || [frstTwoCharcaters isEqualToString:@"07"] || [frstTwoCharcaters isEqualToString:@"06"]) {
            numFlag = YES;
        }
        else {
            DISPLAY_TOAST(ENTER_VALID_EMER1_TOAST);
            numFlag = NO;
        }
    } else if ([inputNum length ] == 11 && ![frstCharcater isEqualToString:@"0"]) {
        DISPLAY_TOAST(ENTER_VALID_EMER1_TOAST);
        numFlag = NO;
    } else  if ([inputNum length ] == 12 && ([frstTwoCharcaters isEqualToString:@"91"] || [frstTwoCharcaters isEqualToString:@"00"])) {
        if([frstThreeCharcaters isEqualToString:@"919"] || [frstThreeCharcaters isEqualToString:@"918"] || [frstThreeCharcaters isEqualToString:@"917"] || [frstThreeCharcaters isEqualToString:@"916"]) {
            numFlag = YES;
        } else {
            DISPLAY_TOAST(ENTER_VALID_EMER1_TOAST);
            numFlag = NO;
        }
    } else {
        DISPLAY_TOAST(ENTER_VALID_EMER1_TOAST);
        numFlag = NO;
    }
    return numFlag;
    TCEND
}


+(BOOL)validateEmergencyContact2 :(NSString *)inputNum
{
    TCSTART
    BOOL numFlag=YES;
    if([inputNum length] == 0)     {
        DISPLAY_TOAST(ENTER_EMER2_TOAST);
        numFlag = NO;
        return numFlag;
    }
    if ([inputNum length ] < 10) {
        DISPLAY_TOAST(ENTER_VALID_EMER2_TOAST);
        numFlag= NO;
        return numFlag;
    }
    inputNum = [inputNum stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *frstCharcater = [inputNum substringToIndex:1];
    NSString *frstTwoCharcaters = [inputNum substringToIndex:2];
    NSString *frstThreeCharcaters = [inputNum substringToIndex:3];
    
    
    if([inputNum length]==10) {
        if([frstCharcater isEqualToString:@"9"] || [frstCharcater isEqualToString:@"8"] || [frstCharcater isEqualToString:@"7"] || [frstCharcater isEqualToString:@"6"]) {
            numFlag = YES;
        } else {
            DISPLAY_TOAST(ENTER_VALID_EMER2_TOAST);
            numFlag = NO;
        }
    } else if ([inputNum length ] == 11 && [frstCharcater isEqualToString:@"0"]) {
        if([frstTwoCharcaters isEqualToString:@"09"] || [frstTwoCharcaters isEqualToString:@"08"] || [frstTwoCharcaters isEqualToString:@"07"] || [frstTwoCharcaters isEqualToString:@"06"]) {
            numFlag = YES;
        }
        else {
            DISPLAY_TOAST(ENTER_VALID_EMER2_TOAST);
            numFlag = NO;
        }
    } else if ([inputNum length ] == 11 && ![frstCharcater isEqualToString:@"0"]) {
        DISPLAY_TOAST(ENTER_VALID_EMER2_TOAST);
        numFlag = NO;
    } else  if ([inputNum length ] == 12 && ([frstTwoCharcaters isEqualToString:@"91"] || [frstTwoCharcaters isEqualToString:@"00"])) {
        if([frstThreeCharcaters isEqualToString:@"919"] || [frstThreeCharcaters isEqualToString:@"918"] || [frstThreeCharcaters isEqualToString:@"917"] || [frstThreeCharcaters isEqualToString:@"916"]) {
            numFlag = YES;
        } else {
            DISPLAY_TOAST(ENTER_VALID_EMER2_TOAST);
            numFlag = NO;
        }
    } else {
        DISPLAY_TOAST(ENTER_VALID_EMER2_TOAST);
        numFlag = NO;
    }
    return numFlag;
    TCEND
}
+(BOOL)isValidPinCode:(NSString*)pincode    {
    NSString *pinRegex = @"^[0-9]{6}$";
    NSPredicate *pinTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pinRegex];
    
    BOOL pinValidates = [pinTest evaluateWithObject:pincode];
    return pinValidates;
}

+(BOOL)vehicleValidation :(NSString *)inputNum
{
    TCSTART
    BOOL vehicleFlag=YES;
    if (inputNum.length == 0) {
        vehicleFlag = NO;
        DISPLAY_TOAST(ENTER_VEHICLE_REG_NUM_TOAST);
    } else {
        NSString *vehicleRegex = @"[A-Z]{2}+[0-9]{2}+[A-Z]{1,2}+[0-9]{4}";
        NSPredicate *vehicleTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", vehicleRegex];
        if (![vehicleTest evaluateWithObject:inputNum]) {
            vehicleFlag = NO;
            DISPLAY_TOAST(ENTER_VALID_VEHICLE_REG_NUM_TOAST);
        }
    }
    return vehicleFlag;
    TCEND
}

    
+(BOOL)mobileNumValidation :(NSString *)inputNum
{
    TCSTART
    BOOL numFlag=YES;
    if([inputNum length] == 0)     {
        DISPLAY_TOAST(ENTER_MOBILE_NUMBER_TOAST);
        numFlag = NO;
        return numFlag;
    }
    if ([inputNum length ] < 10) {
        DISPLAY_TOAST(ENTER_VALID_MOBILE_NUMBER_TOAST);
        numFlag= NO;
        return numFlag;
    }
    inputNum = [inputNum stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *frstCharcater = [inputNum substringToIndex:1];
    NSString *frstTwoCharcaters = [inputNum substringToIndex:2];
    NSString *frstThreeCharcaters = [inputNum substringToIndex:3];

    
    if([inputNum length]==10) {
        if([frstCharcater isEqualToString:@"9"] || [frstCharcater isEqualToString:@"8"] || [frstCharcater isEqualToString:@"7"] || [frstCharcater isEqualToString:@"6"]) {
            numFlag = YES;
        } else {
            DISPLAY_TOAST(ENTER_VALID_MOBILE_NUMBER_TOAST);
            numFlag = NO;
        }
    } else if ([inputNum length ] == 11 && [frstCharcater isEqualToString:@"0"]) {
         if([frstTwoCharcaters isEqualToString:@"09"] || [frstTwoCharcaters isEqualToString:@"08"] || [frstTwoCharcaters isEqualToString:@"07"] || [frstTwoCharcaters isEqualToString:@"06"]) {
             numFlag = YES;
         }
         else {
             DISPLAY_TOAST(ENTER_VALID_MOBILE_NUMBER_TOAST);
             numFlag = NO;
         }
    } else if ([inputNum length ] == 11 && ![frstCharcater isEqualToString:@"0"]) {
        DISPLAY_TOAST(ENTER_VALID_MOBILE_NUMBER_TOAST);
        numFlag = NO;
    } else  if ([inputNum length ] == 12 && ([frstTwoCharcaters isEqualToString:@"91"] || [frstTwoCharcaters isEqualToString:@"00"])) {
         if([frstThreeCharcaters isEqualToString:@"919"] || [frstThreeCharcaters isEqualToString:@"918"] || [frstThreeCharcaters isEqualToString:@"917"] || [frstThreeCharcaters isEqualToString:@"916"]) {
             numFlag = YES;
         } else {
             DISPLAY_TOAST(ENTER_VALID_MOBILE_NUMBER_TOAST);
             numFlag = NO;
         }
    } else {
        DISPLAY_TOAST(ENTER_VALID_MOBILE_NUMBER_TOAST);
        numFlag = NO;
    }
    return numFlag;
    TCEND
}


+ (BOOL)validateEmailWithString:(NSString*)email
{
    TCSTART
    BOOL emailFlag=YES;
    if (email.length == 0) {
        emailFlag = NO;
        DISPLAY_TOAST(ENTER_EMAIL_TOAST);
    } else {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        if (![emailTest evaluateWithObject:email]) {
            emailFlag = NO;
            DISPLAY_TOAST(ENTER_VALID_EMAIL_TOAST);
        }
    }
  
    return emailFlag;
    TCEND
}

+(NSString*) getRandomValueWithDate
{
    TCSTART
    long long milliseconds = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
    long val =  arc4random_uniform(9999) + 1;
    milliseconds = milliseconds *val;
    return [NSString stringWithFormat:@"%lld", milliseconds];
    
    TCEND
}

+(NSString *)getPlatformRawString
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine =  calloc(1, size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+(NSAttributedString*) getCaptchaString
{
    TCSTART
    NSArray * arrCapElements =@[@"0",@"1",@"2",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"3",@"4",@"5",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"6",@"7",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",@"8",@"9"];
    
    NSUInteger elmt1,elmt2,elmt3,elmt4,elmt5,elmt6;
    elmt1 = arc4random() % ([arrCapElements count]/2);
    elmt2= arc4random() % ([arrCapElements count]/2);
    elmt3 = arc4random() % ([arrCapElements count]/2);
    elmt4 = arc4random() % ([arrCapElements count]/2);
    elmt5 = arc4random() % ([arrCapElements count]/2);
    elmt6 = arc4random() % ([arrCapElements count]/2);

    if (elmt1 > arrCapElements.count || elmt1 == 0) { elmt1 = arrCapElements.count -38 ; }
    if (elmt2 > arrCapElements.count || elmt2 == 0) { elmt2 = arrCapElements.count/3 -6; }
    if (elmt3 > arrCapElements.count || elmt3 == 0 ) { elmt3 = arrCapElements.count -52; }
    if (elmt4 > arrCapElements.count || elmt4 == 0 ) { elmt4 = arrCapElements.count/2 -9; }
    if (elmt5 > arrCapElements.count || elmt5 == 0 ) { elmt5 = arrCapElements.count -26; }
    if (elmt6 > arrCapElements.count || elmt6 == 0 ) { elmt6 = arrCapElements.count/2 -26; }
  
    
    NSString *Captcha_string = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",arrCapElements[elmt1-1],arrCapElements[elmt2-1],arrCapElements[elmt3-1],arrCapElements[elmt4-1],arrCapElements[elmt5-1],arrCapElements[elmt6-1]];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:Captcha_string];
    
    [attString addAttribute: NSFontAttributeName value:  Roboto_Regular(30) range: NSMakeRange(0,1)];
    [attString addAttribute: NSFontAttributeName value:  Roboto_Light(28) range: NSMakeRange(2,1)];
    [attString addAttribute: NSFontAttributeName value:  [UIFont fontWithName:@"Chalkduster" size:26] range: NSMakeRange(4,1)];
    [attString addAttribute: NSFontAttributeName value:  RobotoCondensed_Italic(32) range: NSMakeRange(6,1)];
    [attString addAttribute: NSFontAttributeName value:  [UIFont fontWithName:@"Helvetica" size:36] range: NSMakeRange(8,1)];
    [attString addAttribute: NSFontAttributeName value:  [UIFont fontWithName:@"Chalkduster" size:28] range: NSMakeRange(10,1)];
    
    return attString;
    
    TCEND
}

+ (NSMutableArray *) getInitialScreensArray
{
    TCSTART
    NSMutableArray *initialContentArray = [NSMutableArray new];
    for (int i =0; i<6; i++) {
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:[NSString stringWithFormat:@"Intro_Screen%d", (i+1)] forKey:@"backImage"];
        [dict setObject:[NSString stringWithFormat:@"iScreen_Icon%d", (i+1)] forKey:@"icon"];
        
        switch (i) {
            case 0:
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"track_and_pay")] forKey:@"mainTitle"];
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"pbc")] forKey:@"subTitle"];
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"pbc_desc")] forKey:@"desc"];
                break;
                
            case 1:
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"plan_and_book")] forKey:@"mainTitle"];
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"tat")] forKey:@"subTitle"];
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"tat_desc")] forKey:@"desc"];
                break;
                
            case 2:
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"search")] forKey:@"mainTitle"];
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"lbs")] forKey:@"subTitle"];
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"lbs_desc")] forKey:@"desc"];
                break;
                
            case 3:
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"raise_your_concerns")] forKey:@"mainTitle"];
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"gs")] forKey:@"subTitle"];
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"gs_desc")] forKey:@"desc"];
                break;
                
            case 4:
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"b2c")] forKey:@"mainTitle"];
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"b2cservices")] forKey:@"subTitle"];
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"b2cservices_desc")] forKey:@"desc"];
                break;
                
            case 5:
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"cohort")] forKey:@"mainTitle"];
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"g2cservices")] forKey:@"subTitle"];
                [dict setObject:[NSString stringWithFormat:@"%@", languageForKey(@"g2cservices_desc")] forKey:@"desc"];
                break;
                
            default:
                break;
        }
        
        [initialContentArray insertObject:dict atIndex:i];
    }
    return  initialContentArray;
    TCEND
}

+(NSArray*)getComplaintZones {
    TCSTART
    NSArray *zones = @[@"Reach 1", @"Reach 3"];
    return zones;
    TCEND
}

+(NSArray*)getCentersForAadhar {
    TCSTART
    NSArray *zones = @[@"Bangalore One center", @"Karnataka One center", @"AJSK Center"];
    return zones;
    TCEND
}

+(NSArray*)getRequestZones {
    TCSTART
    NSArray *zones = @[@"Bangalore Urban", @"Bangalore Rural"];
    return zones;
    TCEND
}

+(NSArray*)getApplicationTypesForPoliceAmplifier {
    TCSTART
    NSArray *applicationTypes = @[@"Individual", @"Association/Firm"];
    return applicationTypes;
    TCEND
}

+(NSArray*)getInquiryTypesForVehicleStolen {
    TCSTART
    NSArray *applicationTypes = @[@"Recovery Status of Stolen Vehicle", @"Involvement in Crime"];
    return applicationTypes;
    TCEND
}
+(NSArray *)getCitizenships
{
    TCSTART
    NSArray *citizenTypes = @[@"Birth", @"Registration", @"Descent", @"Naturalization"];
    return citizenTypes;
    TCEND
}

+(NSArray *)getRelationTypes
{
    TCSTART
    NSArray *relationTypes = @[@"Father", @"Mother", @"Husband", @"Wife", @"Other"];
    return relationTypes;
    TCEND
}

+(NSArray *)getStampsDocsList
{
    TCSTART
    NSArray *relationTypes = @[@"Property Registration", @"Marriage Registration", @"Firm Registration", @"Society Registration", @"Firm Reconstitution"];
    return relationTypes;
    TCEND
}

+(NSArray*)getIRCTCQuestionsList
{
 TCSTART
    NSArray *questions = @[@"What is your pet’s name?", @"What was the name of your first school?", @"Who was your childhood hero?", @"What is your favorite passtime?", @"What is your all-time favorite sports team?", @"What is your father’s middle name?", @"What was your high school mascot?", @"What make was your first car or bike?", @"Where did you first meet your spouse?"];
    return questions;
    TCEND
}

+(NSArray*)getIRCTCRegisterUserOccupations
{
    TCSTART
    NSArray *occupations = @[@"Government", @"Public", @"Private", @"Professional", @"SelfEmployed", @"Student", @"Others"];
    return occupations;
    TCEND
}

+(NSArray *)getStampsFeesList
{
    TCSTART
    NSArray *relationTypes = @[@"Property Registration Fee", @"Society Registration Fee", @"Hindu Marriage Registration Fee", @"Special Marriage Registration Fee", @"Encumbrance Certificate Fee", @"Certified Copy Fee", @"Firm Registration Fee"];
    return relationTypes;
    TCEND
}

+(NSString *)getTrainClassesValue:(NSString *)keyName {
    TCSTART
    NSDictionary *trainClassesDict = @{@"FIRST AC": @"1A", @"SECOND AC" : @"2A", @"THIRD AC": @"3A", @"3 AC Economy":@"3E", @"AC CHAIR CAR":@"CC", @"FIRST CLASS":@"FC", @"SLEEPER CLASS":@"SL", @"SECOND SEATING":@"2S"};
    return [trainClassesDict valueForKey:keyName];
    TCEND
}

+(NSArray *)getTrainClasses {
    TCSTART
    NSArray *trainClasses = @[@"FIRST AC", @"SECOND AC", @"THIRD AC", @"3 AC Economy", @"AC CHAIR CAR", @"FIRST CLASS", @"SLEEPER CLASS", @"SECOND SEATING"];
    return trainClasses;
    TCEND
}

+(NSArray *)getTrainsQuota
{
    TCSTART
    NSArray *getTrainsQuota = @[@"General", @"Tatkal", @"Ladies", @"Premium Tatkal"];
    return getTrainsQuota;
    TCEND
}

+(NSString *)getValueOfBerth:(NSString *)keyName
{
    
    TCSTART
    NSDictionary *dict = @{@"NO CHOICE" : @"", @"LOWER" : @"LB", @"MIDDLE" : @"MB", @"UPPER" : @"UB", @"SIDE UPPER" : @"SU", @"SIDE LOWER" : @"SL", @"CABIN" : @"CB", @"COUPLE" : @"CP" };
    return [dict valueForKey:keyName];
 TCEND
}

+(NSArray *)getSleeper3ACBerthLevels // sl and 3rd ac
{
    TCSTART
    NSArray *berthList = @[@"NO CHOICE", @"LOWER", @"MIDDLE",  @"UPPER", @"SIDE UPPER", @"SIDE LOWER"];
    return berthList;
    TCEND
}

+(NSArray *)get1ACBerthLevels  {// 1rd ac
    TCSTART
    NSArray *berthList = @[@"NO CHOICE", @"LOWER", @"UPPER",  @"CABIN", @"COUPLE"];//
    return berthList;
    TCEND
}

+(NSArray *)get2ACBerthLevels {// 2nd ac
    TCSTART
    NSArray *berthList = @[@"NO CHOICE", @"LOWER", @"UPPER", @"SIDE UPPER", @"SIDE LOWER"];//
    
    return berthList;
    TCEND
}

+(NSArray *)getGendersList
{
    TCSTART
    NSArray *gendersList = @[@"Male", @"Female"];
    return gendersList;
    TCEND
}

+(NSArray *)getStampsContactsList
{
    TCSTART
    NSArray *relationTypes = @[@"Department Contacts", @"Department Contacts - Head Office"];
    return relationTypes;
    TCEND
}

+(NSArray*)getBloodgroupsArray
{
    TCSTART
    NSArray *booldgroupsArray = @[@"O+", @"O-", @"A+", @"A-", @"B+", @"B-", @"AB+", @"AB-"];
    return booldgroupsArray;
    TCEND
}

+(NSArray*)rtoAgeProofCodes
{
    TCSTART
    NSArray *ageproofcodes = @[@"E", @"A", @"1", @"2"];
    return ageproofcodes;
    TCEND
}

+(NSArray *)rtoAddressProofCodes
{
    TCSTART
    NSArray *addrsProofcodes = @[@"P", @"3", @"4", @"5", @"6", @"8", @"G", @"J", @"K", @"N"];
    return addrsProofcodes;
    TCEND
}

+(NSArray *)getLicenceTypesArray
{
    TCSTART
    NSArray *licencetypes = @[@"Driving Licence", @"Learning Licence"];
    return licencetypes;
    TCEND
}
+(NSArray *)getLanguageTypesArray
{
    TCSTART
    NSArray *licencetypes = @[@"English", @"Kannada"];
    return licencetypes;
    TCEND
}

+(NSArray *)getPackagesTypesArray
{
    TCSTART
    NSArray *licencetypes = @[@"6 months", @"12 months", @"24 months"];
    return licencetypes;
    TCEND
}

+(NSArray *)getDamsTypesArray
{
    TCSTART
    NSArray *licencetypes = @[@"Major dams", @"Medium dams"];
    return licencetypes;
    TCEND
}

+(NSArray *)getFileTDRReasonsList
{
    TCSTART
    NSArray *reasonslist = @[@"Train cancelled by Railways", @"Train running late by more than three hours", @"Difference of Fare in case proper coach not attached", @"AC Failure" , @"Travelled without proper ID proof" , @"Wrongly charged by TTE", @"Passenger not travelled", @"Others"];
    return reasonslist;
    TCEND
}

+(NSArray *)getAppFonts
{
    TCSTART
    NSArray *fontFamilies = [UIFont familyNames];
    
    for (int i = 0; i < [fontFamilies count]; i++)
    {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
        NSLog (@"%@: %@", fontFamily, fontNames);
    }
    return fontFamilies;
    TCEND
}

+(NSString*)getNextDate:(NSString*)dateString addDays:(NSInteger)days
{
    TCSTART
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd-MM-yyyy"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:days];
    NSDate *maxdate = [gregorian dateByAddingComponents:comps toDate:[df dateFromString:dateString]  options:0];
    return [df stringFromDate:maxdate];
    TCEND
}
+(NSString*)getdateMonthYear:(NSString*)dateString :(NSString*)oldFormat :(NSString*)newFormat
{
    TCSTART
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:oldFormat];
    
    NSDateFormatter *newDf = [NSDateFormatter new];
    [newDf setDateFormat:newFormat];
    NSDate *date1 = [df dateFromString:dateString];
    return [newDf stringFromDate:date1];
    TCEND
}

+(BOOL)checkdaDateComparisionWithFirstDate:(NSString *)fdate secondDate:(NSString *)sdate toastMsg:(NSString *)msg {
    TCSTART
    if (![Utils isEmptyValue:fdate] &&  ![Utils isEmptyValue:sdate]) {
        BOOL isTrue = YES;
        switch ([fdate compare:sdate]) {
            case NSOrderedAscending: DLog(@"%@ is in future from %@", fdate, sdate);  break;
            case NSOrderedDescending:  {
                DLog(@"%@ is in past from %@", fdate, sdate);
                DISPLAY_TOAST(msg);
                isTrue  = NO;
            }
                break ;
            case NSOrderedSame: DLog(@"%@ is the same as %@", fdate, sdate); break;
            default: NSLog(@"erorr dates %@, %@", fdate, sdate); break;
        }
        return isTrue;
    }
    return NO;
    
    TCEND
}

+(void)updateButtonGlobally:(UIButton*)button {
    TCSTART
    [button setTitleColor:BLACK_TEXT_COLOR forState:UIControlStateNormal];
    button.titleLabel.font = SUB_TITLE_ROBOTO_LIGHT_FONT;
    TCEND
}
+(void)updateTitleLabelGlobally:(UILabel*)label {
    TCSTART
    label.textColor = APP_THEME_BLUE_COLOR;
    label.font = BIG_TITLE_ROBOTO_LIGHT_FONT;
    TCEND
}
+(void)updateSubTitleLabelGlobally:(UILabel*)label {
    TCSTART
    label.textColor = BLACK_TEXT_COLOR;
    label.font = SUB_TITLE_ROBOTO_LIGHT_FONT;
    TCEND
}
+(void)updateTextFieldGlobally:(UITextField*)textfield {
    TCSTART
    textfield.font = TITLE_ROBOTO_LIGHT_FONT;
    textfield.backgroundColor = TF_BG_COLOR;
    textfield.textColor = BLACK_TEXT_COLOR;
    textfield.tintColor = BLACK_TEXT_COLOR;
    [textfield setValue:LIGHT_GRAY_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    TCEND
}

+(void)updateTextViewGlobally:(PlaceholderTextView*)textView {
    TCSTART
    textView.font = TITLE_ROBOTO_LIGHT_FONT;
    textView.backgroundColor = TF_BG_COLOR;
    textView.textColor = BLACK_TEXT_COLOR;
    textView.tintColor = BLACK_TEXT_COLOR;
    textView.layer.borderWidth = 0.8;
    textView.layer.borderColor = TF_BG_COLOR.CGColor;
    textView.layer.masksToBounds = YES;
    textView.placeholderLabel.textColor = LIGHT_GRAY_COLOR;
      TCEND
}

+(void)updateSubmitButton:(UIButton*)button withBCColor:(UIColor*)bgcolor withTtileColor:(UIColor*)titleColor{
    TCSTART
    button.cornerRadius = button.frame.size.height/2;
    button.titleLabel.font = BUTTON_ROBOTO_REGULAR_FONT;
    [button setBackgroundColor:bgcolor];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    TCEND
}

+(NSString *)getPayCardType:(NSString *)keyName {
    
    TCSTART
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"Credit/Debit Card" forKey:@"01"];
    [dict setObject:@"Net Banking" forKey:@"02"];
    [dict setObject:@"IMPS" forKey:@"03"];
    [dict setObject:@"Cash Card" forKey:@"04"];
    [dict setObject:@"Mobile Wallets" forKey:@"05"];
    [dict setObject:@"MobiKwik" forKey:@"10"];
    [dict setObject:@"Others" forKey:@"all"];
    return [dict valueForKey:keyName];
    TCEND
}

+(NSString *)getPolicePayCardType:(NSString *)keyName {
    
    TCSTART
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"DC" forKey:@"01"];
    [dict setObject:@"NB" forKey:@"02"];
    [dict setObject:@"M" forKey:@"03"];
    [dict setObject:@"M" forKey:@"04"];
    [dict setObject:@"M" forKey:@"05"];
    return [dict valueForKey:keyName];
    TCEND
}

+(NSString *) getLanguageStr :(NSString*)language {
    TCSTART
    
    if([language isEqualToString:@"en"] || [language isEqualToString:@"kn"]) {
        language = language;
    } else {
        if([language isEqualToString:@"english"]  || [language isEqualToString:@"ENGLISH"] || [language isEqualToString:@"KANNADA"] || [language isEqualToString:@"kannada"]) {
            if ([language isEqualToString:@"english"]  || [language isEqualToString:@"ENGLISH"] ) {
                language = @"en";
            } else {
                language = @"kn";
            }
        } else {
            language = @"en";
        }
    }
    return language;
    TCEND
}

+(NSMutableArray*)getTripType
{
    TCSTART
    NSArray  *mutArrMonth = [[NSArray alloc] initWithObjects:@"One Way", @"Round Trip", nil];
    return [[NSMutableArray alloc] initWithArray:mutArrMonth];
    TCEND
}
+(NSMutableArray*)getNumberOfPassengers
{
    TCSTART
    NSArray  *mutArrMonth = [[NSArray alloc] initWithObjects:@"1", @"2",@"3",@"4",@"5",@"6", nil];
    return [[NSMutableArray alloc] initWithArray:mutArrMonth];
    TCEND
}

+ (NSMutableArray *)getIcareDepartmentNames
{
    TCSTART
    NSArray  *mutArrMonth = [[NSArray alloc] initWithObjects:@"Traffic Police", @"RTO",@"BBMP", nil];
    return [[NSMutableArray alloc] initWithArray:mutArrMonth];
    TCEND
}
+ (NSMutableArray *)getIcareCategory:(NSString*)Key
{
    TCSTART
    NSDictionary *allDeptNames=@{@"Traffic Police":@[@"Tinted windows",@"Illegal U-Turn",@"Not wearing seat belt",@"One way/no entry violation",@"Riding on footpath",@"Parking violation",@"Riding without helmet",@"Stop on/beyond zebra crossing",@"Triple riding",@"Using mobile phone while driving",@"Violating lane discipline"], @"RTO":@[@"Unregistered vehicles",@"Broken road signs",@"Pollution",@"Parking charge"],@"BBMP":@[@"Garbage collection",@"Broken streetlights",@"Illegal/unauthorized construction",@"Damaged municipal property",@"Unauthorized digging",@"Lakes",@"Roads"]};
    NSArray  *mutArrMonth = [[NSArray alloc] initWithArray:[allDeptNames objectForKey:Key]];
    return [[NSMutableArray alloc] initWithArray:mutArrMonth];
    TCEND
}

//MARK:- MysoreITS
+(NSArray *)getMysoreITSGenInfoServiceTypeList
{
    TCSTART
    NSArray *serviceTypeList = @[@"Get Stop Code By Stop Name",@"Get Routes By Stop Code",@"Get Route Details By Route Number"];
    return serviceTypeList;
    TCEND
}

+(NSArray *)getMysoreITSGenInfoDirectionList
{
    TCSTART
    NSArray *directionList = @[@"Up",@"Down"];
    return directionList;
    TCEND
}

+ (NSString*) getSelectedMysoreITSServiceIDs:(NSString *)serviceType
{
    TCSTART
    NSDictionary *serviceIDsDict = @{ @"Get Stop Code By Stop Name" : @"02", @"Get Routes By Stop Code" : @"03", @"Get Route Details By Route Number" : @"04",@"Up":@"U",@"Down":@"D"};
    
    NSString *selectedServiceTypeID = [serviceIDsDict objectForKey:serviceType];
    return selectedServiceTypeID;
    TCEND
}

+(NSArray *)getMysoreRTIServiceTypeList
{
    TCSTART
    NSArray *serviceTypeList = @[@"Get Time Of Arrival information at a given Stop",@"Get Time Of Arrival for a particular route for a given stop"];
    return serviceTypeList;
    TCEND
}

+ (NSString*) getSelectedMysoreRTIServiceIDs:(NSString *)serviceType
{
    TCSTART
    NSDictionary *serviceIDsDict = @{ @"Get Time Of Arrival information at a given Stop" : @"02", @"Get Time Of Arrival for a particular route for a given stop" : @"03"};
    NSString *selectedServiceTypeID = [serviceIDsDict objectForKey:serviceType];
    return selectedServiceTypeID;
    TCEND
}

+(NSArray *)getMysorePTIServiceTypeList
{
    TCSTART
    NSArray *serviceTypeList = @[@"Get Time of Arrival at a stop for a given time",@"Get Time of Arrival for a given route at a stop at a given time for the current day",@"Get Time of Arrival for at a stop at a given time on certain days",@"Unsubscribe from Mitra Services"];
    return serviceTypeList;
    TCEND
}

+ (NSString*) getSelectedMysorePTIServiceIDs:(NSString *)serviceType
{
    TCSTART
    NSDictionary *serviceIDsDict = @{ @"Get Time of Arrival at a stop for a given time" : @"02", @"Get Time of Arrival for a given route at a stop at a given time for the current day" : @"03",@"Get Time of Arrival for at a stop at a given time on certain days":@"04",@"Unsubscribe from Mitra Services":@"05"};
    
    NSString *selectedServiceTypeID = [serviceIDsDict objectForKey:serviceType];
    return selectedServiceTypeID;
    TCEND
}

+(NSArray *)getMysorePTIDayList
{
    TCSTART
    NSArray *serviceTypeList = @[@"All days",@"Weekdays",@"Weekends",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday"];
    return serviceTypeList;
    TCEND
}

+ (NSString*) getSelectedMysorePTIDaysIDs:(NSString *)selectedDay
{
    TCSTART
    NSDictionary *serviceIDsDict = @{@"All days":@"all",@"Weekdays":@"wd",@"Weekends":@"we",@"Monday":@"MO",@"Tuesday":@"TU",@"Wednesday":@"WN",@"Thursday":@"TH",@"Friday":@"FR",@"Saturday":@"SA",@"Sunday":@"SU"};
    NSString *selectedServiceTypeID = [serviceIDsDict objectForKey:selectedDay];
    return selectedServiceTypeID;
    TCEND
}
+(NSArray *)getWeatherInfoList
{
    TCSTART
    NSArray *weatherInfoList = @[@"RAINFALL",@"WEATHER",@"ALERT",@"FORECAST"];
    return weatherInfoList;
    TCEND
}
+ (NSString*) getWeatherInfoListIDs:(NSString *)selectedType
{
    TCSTART
    NSDictionary *serviceIDsDict = @{@"RAINFALL":@"RAINFALL",@"WEATHER":@"WEATHER",@"ALERT":@"ALERT",@"FORECAST":@"FORECAST"};
    NSString *selectedServiceTypeID = [serviceIDsDict objectForKey:selectedType];
    return selectedServiceTypeID;
    TCEND
}

+(NSArray *)getGranularityList
{
    TCSTART
    NSArray *granularityList = @[languageForKey(@"district"),languageForKey(@"taluka"),languageForKey(@"hobile")];
    return granularityList;
    TCEND
}

+(NSArray *)getHolidaysInfoList
{
    TCSTART
    NSArray *holidaysList = @[@"All"];
    return holidaysList;
    TCEND
}
+ (NSString*) getHolidaysInfoListIDs:(NSString *)selectedType
{
    TCSTART
    NSDictionary *serviceIDsDict = @{@"All":@"1"};
    NSString *selectedServiceTypeID = [serviceIDsDict objectForKey:selectedType];
    return selectedServiceTypeID;
    TCEND
}

//MARK:- Get All Services

+(NSArray*) getAllServices :(NSArray*)favouritiesArray{
    
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    
    NSArray *services = @[languageForKey(@"pbc1"), languageForKey(@"govts"), languageForKey(@"rs"), languageForKey(@"tat1"),  languageForKey(@"ls"), languageForKey(@"b2cservices"), languageForKey(@"g2bservices"), languageForKey(@"g2gservices")];
    NSArray *serviceImages = @[@"payBillService", @"g2bService", @"complaintService", @"travelService",  @"locationService", @"b2cService", @"g2bService", @"g2gService"];
    
    for (int i=0; i<services.count; i++) {
        NSMutableDictionary *mainDict = [NSMutableDictionary new];
        [mainDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
        [mainDict  setObject:serviceImages[i] forKey:@"image_name"];
        [mainDict  setObject:services[i] forKey:@"item_name"];
        [mainDict  setObject:services[i] forKey:@"deptname"];
        [mainDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
        NSMutableArray *subItemArray = [NSMutableArray new];
        
        NSArray *g2bServices  =@[@"E-Procurement-Verify EMD Status", @"E-Procurement-Supplier Registration Status", @"E-Procurement-Verify Supplier Registration Expiration", @"E-Procurement-Grievance"];
        NSArray *g2gServices  =@[@"HRMS Service", @"Directory Service Admin - Add  Department", @"Directory Service Admin - Add/Edit Line Dept", @"Directory Service Admin - Add/Edit Officer's Details", @"Directory Services View Details", @"Suvarna Arogya Suraksha Trust - Admin"];
        NSArray *g2gServicesdeptnames  =@[@"hrms", @"directory- add", @"directory-admin", @"directory-officer", @"directory-view", @"civic"];

        
        NSArray *paybillschallan  =@[languageForKey(@"utilities"), languageForKey(@"fineschallans"), languageForKey(@"pbr")];
        
        if (i==0) { // paybillschallan
            NSArray *utilitiesdeptnames = @[@"bescom", @"cescom", @"gescom", @"mescom", @"hescom",  @"bwssb"];
            NSArray *utilities = @[languageMergeTwoKeys(@"bescom", @" ", @"billpayments"), languageMergeTwoKeys(@"cescom", @" ", @"billpayments"), languageMergeTwoKeys(@"gescom", @" ",  @"billpayments"),languageMergeTwoKeys(@"mescom",  @" ", @"billpayments"), languageMergeTwoKeys(@"hescom",  @" ", @"billpayments"), languageMergeTwoKeys(@"bwssb",  @" ", @"billpayments")];
            NSArray *pbr = @[languageForKey(@"prepaidrecharge1"), languageMergeTwoKeys(@"airtel", @" ",  @"postpaidbill"), languageMergeTwoKeys(@"vodafone",  @" ", @"postpaidbill"), languageMergeTwoKeys(@"idea",  @" ", @"postpaidbill"), languageMergeTwoKeys(@"tata",  @" ", @"billpayments"), languageMergeTwoKeys(@"cellone",  @" ", @"billpayments")];
            NSArray *pbrdeptnames = @[@"recharge", @"airtel", @"vodafone", @"idea", @"tata",  @"cellone"]; //
            
            for (int j=0; j<paybillschallan.count; j++) {
                NSMutableDictionary *itemDict = [NSMutableDictionary new];
                [itemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [itemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+120)] forKey:@"sub_item_id"];
                [itemDict  setObject:paybillschallan[j] forKey:@"item_name"];
                [itemDict  setObject:paybillschallan[j] forKey:@"deptname"];
                [itemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                [itemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                if(j==0) {
                    NSMutableArray *childItemArray = [NSMutableArray new];
                    for (int k=0; k<utilities.count; k++) {
                        NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                        [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                        [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+120)] forKey:@"sub_item_id"];
                        [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+920)] forKey:@"item_id"];
                        [childitemDict  setObject:utilities[k] forKey:@"item_name"];
                        [childitemDict  setObject:utilitiesdeptnames[k] forKey:@"deptname"];
                        [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                        if (favouritiesArray.count > 0) {
                            if ([favouritiesArray containsObject:utilitiesdeptnames[k]]) {
                                [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                            }
                        }
                        [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                        [childItemArray addObject:childitemDict];
                    }
                    [itemDict  setObject:childItemArray forKey:@"subItems"];
                    [subItemArray addObject:itemDict];
                } else   if(j==1) {
                    NSMutableArray *childItemArray = [NSMutableArray new];
                    for (int k=0; k<1; k++) {
                        NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                        [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                        [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+120)] forKey:@"sub_item_id"];
                        [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+1020)] forKey:@"item_id"];
                        [childitemDict  setObject:@"Bangalore Traffic Police - Pay Fine" forKey:@"item_name"];
                        [childitemDict  setObject:@"btp" forKey:@"deptname"];
                        [childitemDict  setObject:@"btp-payfine" forKey:@"subdeptname"];
                        [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                        if (favouritiesArray.count > 0) {
                            if ([favouritiesArray containsObject:@"btp-payfine"]) {
                                [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                            }
                        }
                        [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                        [childItemArray addObject:childitemDict];
                    }
                    [itemDict  setObject:childItemArray forKey:@"subItems"];
                    [subItemArray addObject:itemDict];
                } else  if(j==2) {
                    NSMutableArray *childItemArray = [NSMutableArray new];
                    for (int k=0; k<pbr.count; k++) {
                        NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                        [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                        [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+120)] forKey:@"sub_item_id"];
                        [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+1120)] forKey:@"item_id"];
                        [childitemDict  setObject:pbr[k] forKey:@"item_name"];
                        [childitemDict  setObject:pbrdeptnames[k] forKey:@"deptname"];
                        [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                        if (favouritiesArray.count > 0) {
                            if ([favouritiesArray containsObject:pbrdeptnames[k]]) {
                                [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                            }
                        }
                        [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                        [childItemArray addObject:childitemDict];
                    }
                    [itemDict  setObject:childItemArray forKey:@"subItems"];
                    [subItemArray addObject:itemDict];
                }
            }
            [mainDict  setObject:subItemArray forKey:@"subItems"];
            [finalArray addObject:mainDict];
        } else if (i == 1) { // governmentServices
            NSMutableArray *temparr =  [[Utils getGovernmentServicesArray:i favArray:favouritiesArray] mutableCopy];
            [mainDict  setObject:temparr forKey:@"subItems"];
            [finalArray addObject:mainDict];
        } else if (i == 2) { //raisecomplaint
            NSMutableArray *temparr =  [[Utils getRaiseComplaintsServicesArray:i favArray:favouritiesArray] mutableCopy];
            [mainDict  setObject:temparr forKey:@"subItems"];
            [finalArray addObject:mainDict];
        }  else if (i ==3) {//traveltransport
            NSMutableArray *temparr =  [[Utils getTransfortServicesArray:i favArray:favouritiesArray] mutableCopy];
            [mainDict  setObject:temparr forKey:@"subItems"];
            [finalArray addObject:mainDict];
        } else if (i ==4) { //Location Services
            NSMutableArray *temparr =  [[Utils getLocationServicesArray:i favArray:favouritiesArray] mutableCopy];
            [mainDict  setObject:temparr forKey:@"subItems"];
            [finalArray addObject:mainDict];
        } else if (i==5) { //b2cServices
            NSMutableArray *temparr =  [[Utils getB2CServicesArray:i favArray:favouritiesArray] mutableCopy];
            [mainDict  setObject:temparr forKey:@"subItems"];
            [finalArray addObject:mainDict];
        }  else if (i == 6) { // g2bServices
            for (int j=0; j<g2bServices.count; j++) {
                NSMutableDictionary *itemDict = [NSMutableDictionary new];
                [itemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [itemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+480)] forKey:@"sub_item_id"];
                [itemDict  setObject:g2bServices[j] forKey:@"item_name"];
                [itemDict  setObject:g2bServices[j] forKey:@"deptname"];
                [itemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                [itemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [itemDict  setObject:@[] forKey:@"subItems"];
                [subItemArray addObject:itemDict];
            }
            [mainDict  setObject:subItemArray forKey:@"subItems"];
            [finalArray addObject:mainDict];
        }  else if (i == 7) { //g2gServices
            for (int j=0; j<g2gServices.count; j++) {
                NSMutableDictionary *itemDict = [NSMutableDictionary new];
                [itemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [itemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+520)] forKey:@"sub_item_id"];
                [itemDict  setObject:g2gServices[j] forKey:@"item_name"];
                [itemDict  setObject:g2gServicesdeptnames[j] forKey:@"deptname"];
                [itemDict  setObject:g2gServicesdeptnames[j] forKey:@"subdeptname"];
                [itemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [itemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                [itemDict  setObject:@[] forKey:@"subItems"];
                [subItemArray addObject:itemDict];
            }
            [mainDict  setObject:subItemArray forKey:@"subItems"];
            [finalArray addObject:mainDict];
        }
    }
    
    return finalArray;
    TCEND
}

+(NSMutableArray *)getLocationServicesArray:(int)i favArray:(NSArray *)favouritiesArray {
    TCSTART
    NSMutableArray *subItemArray = [NSMutableArray new];
    
    for (int j=0; j<1; j++) {
        NSMutableDictionary *itemDict = [NSMutableDictionary new];
        [itemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
        [itemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+360)] forKey:@"sub_item_id"];
        [itemDict  setObject:@"Bangalore City Police Locate Police Station" forKey:@"item_name"];
        [itemDict  setObject:@"bcp" forKey:@"deptname"];
        [itemDict  setObject:@"bcp-locate" forKey:@"subdeptname"];
        [itemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
        if (favouritiesArray.count > 0) {
            if ([favouritiesArray containsObject:@"bcp-locate"]) {
                [itemDict  setObject:@"1" forKey:@"favourite"]; //favourite
            }
        }
        [itemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
        [itemDict  setObject:@[] forKey:@"subItems"];
        [subItemArray addObject:itemDict];
    }
    return subItemArray;
    TCEND
}
+(NSMutableArray *)getRaiseComplaintsServicesArray:(int)i favArray:(NSArray *)favouritiesArray {
    TCSTART
    NSArray *raisecomplaint = @[@"Bangalore City Police Raise Complaint", @"Icare-Grievance"];
    NSArray *rcdeptnames = @[@"bcp", @"icare"];
    NSArray *rcsubdeptnames = @[@"bcp-complaint", @"icare"];
    NSMutableArray *subItemArray = [NSMutableArray new];
    
    for (int j=0; j<raisecomplaint.count; j++) {
        NSMutableDictionary *itemDict = [NSMutableDictionary new];
        [itemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
        [itemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+2820)] forKey:@"sub_item_id"];
        [itemDict  setObject:raisecomplaint[j] forKey:@"item_name"];
        [itemDict  setObject:rcdeptnames[j] forKey:@"deptname"];
        [itemDict  setObject:rcsubdeptnames[j] forKey:@"subdeptname"];
        [itemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
        if (favouritiesArray.count > 0) {
            if ([favouritiesArray containsObject:rcsubdeptnames[j]] ) {
                [itemDict  setObject:@"1" forKey:@"favourite"]; //favourite
            }
        }
        [itemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
        [itemDict  setObject:@[] forKey:@"subItems"];
        [subItemArray addObject:itemDict];
    }
    return subItemArray;
    TCEND
}

+(NSMutableArray *)getB2CServicesArray:(int)i favArray:(NSArray*)favouritiesArray {
    TCSTART
    NSArray *b2cServices = @[@"Banking", @"Healthcare", @"RML-Subscription", @"Accenture Crop Solution -Register Farmer", @"Accenture Crop Solution -Register Crop"];
    NSArray *b2cServicesdeptnames = @[@"banking", @"healthcare", @"rml", @"accenture-register-farmer", @"accenture -register-crop"];
    
    NSArray *banking =  @[@"Canara Bank", @"ICICI Bank", @"PNB", @"Axis Bank" , @"SBI" , @"HDFC Bank", @"Syndicate Bank"];
    NSArray *bankingsubdeptnames =  @[@"canara", @"icici", @"pnb", @"axis" , @"sbi" , @"hdfc", @"syndicate"];
    
    NSArray *healthCare =@[@"Accenture Maternal and Child Solution-Regsitration", @"Accenture Maternal and Child Solution-View Details", @"Practo-Book Appointment", @"Centricity Tele-ICU-GE"];
    
    
    NSArray *healthCaresubdeptnames =@[@"accenture-regsitration", @"accenture-view", @"practo", @"centricity"];
    
    NSMutableArray *subItemArray = [NSMutableArray new];
    
    for (int j=0; j<b2cServices.count; j++) {
        NSMutableDictionary *itemDict = [NSMutableDictionary new];
        [itemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
        [itemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+420)] forKey:@"sub_item_id"];
        [itemDict  setObject:b2cServices[j] forKey:@"item_name"];
        [itemDict  setObject:b2cServicesdeptnames[j] forKey:@"deptname"];
        [itemDict  setObject:b2cServicesdeptnames[j] forKey:@"subdeptname"];
        [itemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
        [itemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
        if(j==0) {//banking
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<banking.count; k++) {
                
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+420)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+3820)] forKey:@"item_id"];
                [childitemDict  setObject:banking[k] forKey:@"item_name"];
                [childitemDict  setObject:b2cServicesdeptnames[j] forKey:@"deptname"];
                [itemDict  setObject:bankingsubdeptnames[k] forKey:@"subdeptname"];
                [itemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:bankingsubdeptnames[j]] ) {
                        [itemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if(j==1) {//healthCare
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<healthCare.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+420)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+3920)] forKey:@"item_id"];
                [childitemDict  setObject:healthCare[k] forKey:@"item_name"];
                [childitemDict  setObject:healthCaresubdeptnames[j] forKey:@"deptname"];
                [itemDict  setObject:bankingsubdeptnames[k] forKey:@"subdeptname"];
                [itemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:healthCaresubdeptnames[j]] ) {
                        [itemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else {//otheritems
            [itemDict  setObject:@[] forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        }
    }
    return subItemArray;
    TCEND
}

+(NSMutableArray *) getTransfortServicesArray :(int)i favArray:(NSArray *)favouritiesArray{
    
    TCSTART
    NSArray *traveltransport = @[languageForKey(@"rto"), languageForKey(@"ksrtc"), languageForKey(@"irctc"), languageForKey(@"redbus"), languageForKey(@"kstdc"), languageForKey(@"cauvery"), languageForKey(@"rindigo"),  languageForKey(@"mysoreITS"), languageForKey(@"bmrcl")];
    NSArray *travelDepts = @[@"rto", @"ksrtc", @"irctc", @"redbus", @"kstdc",  @"cauvery", @"rindigo", @"mysore-its", @"bmrcl"];

    NSMutableArray *subItemArray = [NSMutableArray new];
    NSArray *rto = @[languageForKey(@"rto-lltest"), languageForKey(@"rto-lldl"), languageForKey(@"rto-dlextract"), languageForKey(@"rto-rcextract")];
    NSArray *rtosubdepts = @[@"rto-lltest",@"rto-lldl", @"rto-dlextract", @"rto-rcextract"];

    NSArray *ksrtc = @[languageForKey(@"booktickets"), languageForKey(@"canceltickets"), languageForKey(@"bookinghistory")];
    NSArray *ksrtcsubdepts = @[@"ksrtc-book", @"ksrtc-cancel", @"ksrtc-history"];

    NSArray *irctc = @[languageForKey(@"irctc-book"), languageForKey(@"irctc-booking-history"), languageForKey(@"irctc-cancel"),  languageForKey(@"irctc-file-tdr"), languageForKey(@"irctc-tdr-history")];
    NSArray *irctcsubdeptnames = @[@"irctc-book", @"irctc-booking-history", @"irctc-cancel", @"irctc-file-tdr", @"irctc-tdr-history"];

    NSArray *redbus = @[languageForKey(@"booktickets"), languageForKey(@"canceltickets"), languageForKey(@"tickethistory")];
    NSArray *redbussubdepts = @[@"redbus-book", @"redbus-cancel", @"redbus-history"];
    
    NSArray *kstdc = @[languageForKey(@"enquirepackage"), languageForKey(@"bookpackage"), languageForKey(@"cancelpackage"), languageForKey(@"bookinghistory")];
     NSArray *kstdcsubdepts = @[@"kstdc-enquire", @"kstdc-book", @"kstdc-cancel",@"kstdc-history"];
    
    NSArray *rindigo = @[languageForKey(@"registration"), languageForKey(@"booking")];
    NSArray *bmrcl = @[languageForKey(@"bmrcl-topup"), languageForKey(@"bmrcl-history"), languageForKey(@"bmrcl-fare")];
    NSArray *bmrclsubdepts = @[@"bmrcl-topup", @"bmrcl-history", @"bmrcl-fare"];

    NSArray *cauvery = @[languageForKey(@"cauverynn")];
    NSArray *mysore = @[languageForKey(@"mysore-its-geninfo"),languageForKey(@"mysore-its-pretrip"),languageForKey(@"mysore-its-real")];
    NSArray *mysoresubdepts = @[@"mysore-its-geninfo", @"mysore-its-pretrip", @"mysore-its-real"];

    for (int j=0; j<traveltransport.count; j++) {
        NSMutableDictionary *itemDict = [NSMutableDictionary new];
        [itemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
        [itemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+300)] forKey:@"sub_item_id"];
        [itemDict  setObject:traveltransport[j] forKey:@"item_name"];
        [itemDict  setObject:travelDepts[j] forKey:@"deptname"];
        [itemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
        [itemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
        if(j==0) {//rto
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<rto.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+300)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+2920)] forKey:@"item_id"];
                [childitemDict  setObject:rto[k] forKey:@"item_name"];
                [childitemDict  setObject:travelDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:rtosubdepts[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:rtosubdepts[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if (j==1) {//ksrtc
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<ksrtc.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+300)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+3020)] forKey:@"item_id"];
                [childitemDict  setObject:ksrtc[k] forKey:@"item_name"];
                [childitemDict  setObject:travelDepts[j] forKey:@"deptname"];
                 [childitemDict  setObject:ksrtcsubdepts[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:ksrtcsubdepts[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else  if(j==2) {//irctc
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<irctc.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+300)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+3120)] forKey:@"item_id"];
                [childitemDict  setObject:irctc[k] forKey:@"item_name"];
                [childitemDict  setObject:travelDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:irctcsubdeptnames[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:irctcsubdeptnames[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else  if(j==3) {//redbus
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<redbus.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+300)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+3220)] forKey:@"item_id"];
                [childitemDict  setObject:redbus[k] forKey:@"item_name"];
                [childitemDict  setObject:travelDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:redbussubdepts[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:redbussubdepts[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        }  else  if(j==4) {//kstdc
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<kstdc.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+300)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+3320)] forKey:@"item_id"];
                [childitemDict  setObject:kstdc[k] forKey:@"item_name"];
                [childitemDict  setObject:travelDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:kstdcsubdepts[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:kstdcsubdepts[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else  if(j==5) {//cauvery
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<cauvery.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+300)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+3420)] forKey:@"item_id"];
                [childitemDict  setObject:cauvery[k] forKey:@"item_name"];
                [childitemDict  setObject:travelDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:@"cauvery" forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:@"cauvery"]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else  if(j==6) {//rindigo
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<rindigo.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+300)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+3520)] forKey:@"item_id"];
                [childitemDict  setObject:rindigo[k] forKey:@"item_name"];
                [childitemDict  setObject:travelDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else  if(j==7) {//mysore
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<mysore.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+300)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+3620)] forKey:@"item_id"];
                [childitemDict  setObject:mysore[k] forKey:@"item_name"];
                [childitemDict  setObject:travelDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:mysoresubdepts[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:mysoresubdepts[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else  if(j==8) {//bmrcl
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<bmrcl.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+300)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+3720)] forKey:@"item_id"];
                [childitemDict  setObject:bmrcl[k] forKey:@"item_name"];
                [childitemDict  setObject:travelDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:bmrclsubdepts[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:bmrclsubdepts[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
            
        }
    }
    return subItemArray;
    TCEND
}

+(NSMutableArray *) getGovernmentServicesArray :(int)i  favArray:(NSArray *)favouritiesArray {
    
    TCSTART
    NSArray *governmentDepts  =@[@"municipal", @"passport", @"taxation", @"stamps", @"agriculture", @"sakala", @"kseeb", @"postal", @"frro", @"backwardclasses", @"khajane2", @"aadhar", @"eci", @"scrb", @"civic", @"babajob"];
    
    NSArray *governmentServices  =@[@"Municipal", @"Passport", @"Taxation", @"Stamps & Registration", @"Agriculture", @"Sakala", @"School & Education", @"Postal", @"FRRO", @"Scholarship", @"Challan", @"Aadhar", @"Election Commission", @"Police", @"Healthcare", @"Employment - Baba Job"];
    
    NSArray *muncipal = @[@"BBMP PID Search", @"BBMP Property Tax Payment", @"DMA Janhita-Registration", @"DMA Janhita-Raise Grievance", @"DMA Janhita-View Grievance", languageForKey(@"hdmc-reg"), languageForKey(@"hdmc-paytax"),];
    NSArray *muncipalDepts = @[@"bbmp", @"bbmp", @"janhita", @"janhita", @"janhita", @"hdmc", @"hdmc"];
    NSArray *muncipalsubdepts = @[@"bbmp-pid", @"bbmp-paytax", @"janhita-reg", @"janhita-complaint", @"janhita-view", @"hdmc-reg", @"hdmc-paytax"];
    
    NSArray *passport = @[@"Passport - Fee Calculator", @"Passport-Status Tracker", @"Passport-Locate Center"];
    NSArray *passportsubdeptnames = @[@"passport-fee", @"passport-status", @"passport-locate"];

    NSArray *taxation = @[@"ITR Rectification", @"ITR Refund Status", @"ITR Status", @"ITR Payment", @"ClearTax", @"Commercial Tax Tin Verification", @"Commercial Tax Cform Verification", @"Commercial Tax Obtain E-Sugam"];
    NSArray *taxationsubeptnames = @[@"itr-rectification", @"itr-refund", @"itr-status", @"itr-payment", @"cleartax", @"ctax-tin", @"ctax-cst", @"ctax-msugam"];

    
    NSArray *stampsArray = @[@"Registration Fees", @"Registration Documents", @"Department Contacts"];
    NSArray *stampssubdeptnames = @[ @"stamps-fee", @"stamps-docs", @"stamps-contacts"];
    NSArray *agriculture = @[@"KSDA-Subscription", @"KSNDMC-Subscription"];
    NSArray *agriculturesubdepts = @[@"ksda-sub",@"ksndmc-sub"];
    NSArray *sakala = @[@"Sakala - Check Status"];
    NSArray *schooleducation = @[@"KSEEB-Locate Center", @"KSEEB-Photocopy Application", @"KSEEB-Re-Total Application", @"KSEEB-Revaluation Application"];
    NSArray *postal = @[@"Postal Service Tracking Article"];
    
    NSArray *frro = @[@"Contact List",@"Documents",@"FAQ",@"Visa Reg"];
    NSArray *frrosubdeptnames = @[@"frro-contact", @"frro-document", @"frro-faq",@"frro-visa"];
    
    
    NSArray *scholarship = @[@"Backward Classes-Get Application Number", @"Backward Classes-Get Application Status"];
    NSArray *bwcsubdepts = @[@"bc-appno",@"bc-appstatus"];

    NSArray *challan = @[@"Khajane 2- Find Challan"];
    
    NSArray *aadhar = @[languageForKey(@"aadhar-edoc"), languageForKey(@"aadhar-ecenter"), languageForKey(@"aadhar-coordinator")];
    NSArray *aadharsubdepts = @[@"aadhar-edoc", @"aadhar-ecenter", @"aadhar-coordinator"];
    
    NSArray *electioncommission = @[@"Election Commission of India"];
    NSArray *police = @[@"Bangalore Traffic Police Registration", @"Police Verifcation Certificate", @"Amplifier Setup Permission", @"Vehicle Stolen and Recovered Report"];
    NSArray *policesubdepts = @[@"btp-register", @"scrb-pvc", @"scrb-amp", @"scrb-vsrp"];

    NSArray *employment = @[@"Employment - Baba Job"];
    NSMutableArray *subItemArray = [NSMutableArray new];
    
    for (int j=0; j<governmentServices.count; j++) {
        NSMutableDictionary *itemDict = [NSMutableDictionary new];
        [itemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
        [itemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
        [itemDict  setObject:governmentServices[j] forKey:@"item_name"];
        [itemDict  setObject:governmentDepts[j] forKey:@"deptname"];
        [itemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
        [itemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
        if(j==0) {//muncipal
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<muncipal.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+1220)] forKey:@"item_id"];
                [childitemDict  setObject:muncipal[k] forKey:@"item_name"];
                [childitemDict  setObject:muncipalDepts[k] forKey:@"deptname"];
                [childitemDict  setObject:muncipalsubdepts[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:muncipalsubdepts[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if(j==1) {//passport
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<passport.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+1320)] forKey:@"item_id"];
                [childitemDict  setObject:passport[k] forKey:@"item_name"];
                [childitemDict  setObject:governmentDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:passportsubdeptnames[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:passportsubdeptnames[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if(j==2) {//taxaction
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<taxation.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+1420)] forKey:@"item_id"];
                [childitemDict  setObject:taxation[k] forKey:@"item_name"];
                [childitemDict  setObject:((k>4) ? @"commercialtax": @"incometax") forKey:@"deptname"];
                [childitemDict  setObject:taxationsubeptnames[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:taxationsubeptnames[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                //                [childitemDict  setObject:rtosubdepts[k] forKey:@"subdeptname"];
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if(j==3) {//sar
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<stampsArray.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+1520)] forKey:@"item_id"];
                [childitemDict  setObject:stampsArray[k] forKey:@"item_name"];
                [childitemDict  setObject:governmentDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:stampssubdeptnames[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:stampssubdeptnames[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if(j==4) {//agriculture
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<agriculture.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+1620)] forKey:@"item_id"];
                [childitemDict  setObject:agriculture[k] forKey:@"item_name"];
                [childitemDict  setObject:governmentDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:agriculturesubdepts[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if(j==5) {//sakala
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<sakala.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+1720)] forKey:@"item_id"];
                [childitemDict  setObject:sakala[k] forKey:@"item_name"];
                [childitemDict  setObject:governmentDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:@"sakala" forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:@"sakala"]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if(j==6) {//schooleducation
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<schooleducation.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+1820)] forKey:@"item_id"];
                [childitemDict  setObject:schooleducation[k] forKey:@"item_name"];
                [childitemDict  setObject:governmentDepts[j] forKey:@"deptname"];
                //                [childitemDict  setObject:rtosubdepts[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if(j==7) {//postal
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<postal.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+1920)] forKey:@"item_id"];
                [childitemDict  setObject:postal[k] forKey:@"item_name"];
                [childitemDict  setObject:governmentDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:@"postal" forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:@"postal"]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if(j==8) {//frro
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<frro.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+2020)] forKey:@"item_id"];
                [childitemDict  setObject:frro[k] forKey:@"item_name"];
                [childitemDict  setObject:governmentDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:frrosubdeptnames[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        }else if(j==9) {//scholarship
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<scholarship.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+2120)] forKey:@"item_id"];
                [childitemDict  setObject:scholarship[k] forKey:@"item_name"];
                [childitemDict  setObject:governmentDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:bwcsubdepts[k] forKey:@"subdeptname"];
               // [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:bwcsubdepts[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if(j==10) {//challan
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<challan.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+2220)] forKey:@"item_id"];
                [childitemDict  setObject:challan[k] forKey:@"item_name"];
                [childitemDict  setObject:governmentDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:@"khajane2" forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:@"khajane2"]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        }  else if(j==11) {//aadhar
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<aadhar.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+2320)] forKey:@"item_id"];
                [childitemDict  setObject:aadhar[k] forKey:@"item_name"];
                [childitemDict  setObject:governmentDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:aadharsubdepts[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:aadharsubdepts[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if(j==12) {//electioncommission
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<electioncommission.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+2420)] forKey:@"item_id"];
                [childitemDict  setObject:electioncommission[k] forKey:@"item_name"];
                [childitemDict  setObject:governmentDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:@"eci" forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:@"eci"]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if (j == 13) {//police
            NSMutableArray *childItemArray1 = [NSMutableArray new];
            for (int k=0; k<police.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+2520)] forKey:@"item_id"];
                [childitemDict  setObject:police[k] forKey:@"item_name"];
                [childitemDict  setObject:(k==0 ? @"btp" : @"scrb") forKey:@"deptname"];
                [childitemDict  setObject:policesubdepts[k] forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:policesubdepts[k]]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray1 addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray1 forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if (j==14) {//healthcare
            NSMutableArray *childItemArray1 = [NSMutableArray new];
            for (int k=0; k<1; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+2620)] forKey:@"item_id"];
                [childitemDict  setObject:@"Suvarna Arogya Suraksha Trust -View Details" forKey:@"item_name"];
                [childitemDict  setObject:governmentDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:@"civic" forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:@"civic"]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray1 addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray1 forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        } else if (j==15) {//
            NSMutableArray *childItemArray = [NSMutableArray new];
            for (int k=0; k<employment.count; k++) {
                NSMutableDictionary *childitemDict = [NSMutableDictionary new];
                [childitemDict  setObject:[NSNumber numberWithInt:i+1] forKey:@"service_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:(j+(i+1)+180)] forKey:@"sub_item_id"];
                [childitemDict  setObject:[NSNumber numberWithInt:((k+(j+1)+(i+1))+2720)] forKey:@"item_id"];
                [childitemDict  setObject:employment[k] forKey:@"item_name"];
                [childitemDict  setObject:governmentDepts[j] forKey:@"deptname"];
                [childitemDict  setObject:@"babajob" forKey:@"subdeptname"];
                [childitemDict  setObject:@"0" forKey:@"favourite"]; // unfavourite
                if (favouritiesArray.count > 0) {
                    if ([favouritiesArray containsObject:@"babajob"]) {
                        [childitemDict  setObject:@"1" forKey:@"favourite"]; //favourite
                    }
                }
                 [childitemDict  setObject:languageForKey(@"instructionalmessage") forKey:@"message"];
                [childItemArray addObject:childitemDict];
            }
            [itemDict  setObject:childItemArray forKey:@"subItems"];
            [subItemArray addObject:itemDict];
        }
    }
    return subItemArray;
    TCEND
    //raghu
}

//MARK:- Get App Related Services
+(NSString *)getServiceIdForPayment:(NSString *)keyName {
    
    TCSTART
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"GOV005" forKey:@"BESCOM"];
    [dict setObject:@"GOI005" forKey:@"IRCTC"];
    [dict setObject:@"GOV001" forKey:@"RTO"];
    [dict setObject:@"GOV004" forKey:@"BWSSB"];
    [dict setObject:@"GOV006" forKey:@"BTP"];
    [dict setObject:@"GOV007" forKey:@"HESCOM"];
    [dict setObject:@"GOV012" forKey:@"SCRB"];
    [dict setObject:@"GOV020" forKey:@"KSRTC"];
    [dict setObject:@"VAS001" forKey:@"AIRTEL"];
    [dict setObject:@"VAS002" forKey:@"CELLONE"];
    [dict setObject:@"VAS003" forKey:@"IDEA"];
    [dict setObject:@"VAS004" forKey:@"VODAFONE"];
    [dict setObject:@"VAS005" forKey:@"TATA"];
    [dict setObject:@"VAS033" forKey:@"RML"];
    [dict setObject:@"VAS037" forKey:@"RECHARGE"];
    [dict setObject:@"GOV015" forKey:@"BMRCL"];
    [dict setObject:@"GOV032" forKey:@"CESCOM"];
    [dict setObject:@"GOV033" forKey:@"MESCOM"];
    [dict setObject:@"GOV034" forKey:@"GESCOM"];
    [dict setObject:@"GOV035" forKey:@"KSEEB"];
    
    return [dict valueForKey:keyName];
    TCEND
}

+(NSString *)getAppActionForDept:(NSString *)keyName {
 
    TCSTART
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [dict setObject:@"1" forKey:@"bescom"];
    [dict setObject:@"2" forKey:@"cescom"];
    [dict setObject:@"3" forKey:@"gescom"];
    [dict setObject:@"4" forKey:@"mescom"];
    [dict setObject:@"5" forKey:@"hescom"];
    [dict setObject:@"6" forKey:@"bwssb"];
    
    [dict setObject:@"7" forKey:@"recharge"];
    [dict setObject:@"8" forKey:@"airtel"];
    [dict setObject:@"9" forKey:@"vodafone"];
    [dict setObject:@"10" forKey:@"idea"];
    [dict setObject:@"11" forKey:@"tata"];
    [dict setObject:@"12" forKey:@"cellone"];
    
    [dict setObject:@"13" forKey:@"rto-lltest"];
    [dict setObject:@"14" forKey:@"rto-lldl"];
    [dict setObject:@"15" forKey:@"rto-dlextract"];
    [dict setObject:@"16" forKey:@"rto-rcextract"];
    
    [dict setObject:@"17" forKey:@"sakala"];
    
    [dict setObject:@"18" forKey:@"postal"];
    
    [dict setObject:@"19" forKey:@"khajane2"];
    
    [dict setObject:@"20" forKey:@"bc-appno"];
    [dict setObject:@"21" forKey:@"bc-appstatus"];
    
    [dict setObject:@"22" forKey:@"bmrcl-topup"];
    [dict setObject:@"23" forKey:@"bmrcl-history"];
    [dict setObject:@"24" forKey:@"bmrcl-fare"];
    
    [dict setObject:@"25" forKey:@"btp-payfine"];
    [dict setObject:@"26" forKey:@"btp-register"];
    [dict setObject:@"27" forKey:@"scrb-pvc"];
    [dict setObject:@"28" forKey:@"scrb-amp"];
    [dict setObject:@"29" forKey:@"scrb-vsrp"];
    [dict setObject:@"30" forKey:@"bcp-complaint"];
    [dict setObject:@"31" forKey:@"bcp-locate"];
    
    [dict setObject:@"32" forKey:@"icare"];
    
    [dict setObject:@"33" forKey:@"aadhar-edoc"];
    [dict setObject:@"34" forKey:@"aadhar-ecenter"];
    [dict setObject:@"35" forKey:@"aadhar-coordinator"];
    
    [dict setObject:@"36" forKey:@"stamps-fee"];
    [dict setObject:@"37" forKey:@"stamps-docs"];
    [dict setObject:@"38" forKey:@"stamps-contacts"];
    
    [dict setObject:@"39" forKey:@"civic"];
    
    [dict setObject:@"40" forKey:@"ksrtc-book"];
    [dict setObject:@"41" forKey:@"ksrtc-cancel"];
    [dict setObject:@"42" forKey:@"ksrtc-history"];
    [dict setObject:@"43" forKey:@"irctc-reg"];
    [dict setObject:@"44" forKey:@"irctc-book"];
    [dict setObject:@"45" forKey:@"irctc-cancel"];
    [dict setObject:@"46" forKey:@"irctc-file-tdr"];
    [dict setObject:@"47" forKey:@"irctc-tdr-history"];
    [dict setObject:@"48" forKey:@"irctc-booking-history"];
    
    [dict setObject:@"49" forKey:@"itr-rectification"];
    [dict setObject:@"50" forKey:@"itr-refund"];
    [dict setObject:@"51" forKey:@"itr-payment"];
    [dict setObject:@"52" forKey:@"itr-itrv"];
    [dict setObject:@"53" forKey:@"cleartax"];
    [dict setObject:@"54" forKey:@"ctax-tin"];
    [dict setObject:@"55" forKey:@"ctax-cst"];
    [dict setObject:@"56" forKey:@"ctax-msugam"];
    [dict setObject:@"57" forKey:@"rml"];
 
    [dict setObject:@"59" forKey:@"canara"];
    [dict setObject:@"60" forKey:@"icici"];
    [dict setObject:@"61" forKey:@"pnb"];
    [dict setObject:@"62" forKey:@"axis"];
    [dict setObject:@"63" forKey:@"sbi"];
    [dict setObject:@"64" forKey:@"hdfc"];
    [dict setObject:@"65" forKey:@"syndicate"];
    [dict setObject:@"66" forKey:@"cnnl"];//cauvery
    [dict setObject:@"67" forKey:@"eci"];
    [dict setObject:@"68" forKey:@"passport-fee"];
    [dict setObject:@"69" forKey:@"passport-status"];
    [dict setObject:@"70" forKey:@"passport-locate"];
    [dict setObject:@"71" forKey:@"babajob"];
    
    [dict setObject:@"72" forKey:@"mysore-its-geninfo"];
    [dict setObject:@"73" forKey:@"mysore-its-pretrip"];
    [dict setObject:@"74" forKey:@"mysore-its-real"];
    
    [dict setObject:@"75" forKey:@"hdmc-reg"];
    [dict setObject:@"76" forKey:@"hdmc-paytax"];
    
    [dict setObject:@"77" forKey:@"frro-visa"];
    [dict setObject:@"78" forKey:@"frro-faq"];
    [dict setObject:@"79" forKey:@"frro-document"];
    [dict setObject:@"80" forKey:@"frro-contact"];
    [dict setObject:@"81" forKey:@"ksndmc-sub"];
    
    [dict setObject:@"82" forKey:@"kstdc-enquire"];
    [dict setObject:@"83" forKey:@"kstdc-book"];
    [dict setObject:@"84" forKey:@"kstdc-cancel"];
    [dict setObject:@"85" forKey:@"kstdc-history"];
    
    
//    [dict setObject:@"71" forKey:@"redbus-book"];
//    [dict setObject:@"72" forKey:@"redbus-cancel"];
//    [dict setObject:@"73" forKey:@"redbus-history"];
    
    //    [dict setObject:@"71" forKey:@"itr-itrv"];
    //    [dict setObject:@"72" forKey:@"cleartax"];
    //    [dict setObject:@"73" forKey:@"ctax-tin"];
    //    [dict setObject:@"74" forKey:@"ctax-cst"];
    //    [dict setObject:@"75" forKey:@"ctax-msugam"];
 
//    bbmp-paytax
//    janhita-reg
//    janhita-complaint
//    janhita-view
 
 //    ksda
//    ksndmc-sub
 //   kseeb-locate
//    kseeb-pc
//    kseeb-retotal
//    kseeb-reval
 //    frro
 //
//    redbus-book
//    redbus-cancel
//    redbus-history
//    kstdc-enquire
//    kstdc-book
//    kstdc-cancel
//    kstdc-history
 //   ridingo-reg
//    ridingo-book
 
//    accenture-wc-reg
//    accenture-wc-view
//    practo
//    centricity
//    accenture-reg-farmer
//    accentuer-reg-crop
//    eproc-emd
//    eproc-regstatus
//    eproc-verifyreg
//    eproc-grievance
//    hrms
//    directory-adddept
//    directory-editline
//    directory-addofficer
//    directory-view
//    suvarna-admin
//    suvarna-view
//    civic
//    mpower-config
//    mpower-raise
//    mpower-setprofile
//    kries
//    childlabour
    return [dict valueForKey:keyName];
    TCEND
}

+(NSArray *)getAllcompletedServices {
    
    TCSTART
    NSArray *servicesArray = @[@"bescom", @"cescom", @"gescom", @"mescom", @"hescom", @"bwssb", @"recharge", @"airtel", @"vodafone", @"idea", @"tata", @"cellone", @"rto-lltest", @"rto-lldl", @"rto-dlextract", @"rto-rcextract", @"sakala", @"postal", @"khajane2", @"bc-appno", @"bc-appstatus", @"bmrcl-topup", @"bmrcl-history", @"bmrcl-fare", @"btp-payfine", @"btp-register", @"scrb-pvc", @"scrb-amp", @"scrb-vsrp", @"bcp-complaint", @"bcp-locate", @"icare", @"aadhar-edoc", @"aadhar-ecenter", @"aadhar-coordinator", @"stamps-fee", @"stamps-docs", @"stamps-contacts", @"suvarna-admin", @"ksrtc-book", @"ksrtc-cancel", @"ksrtc-history", @"irctc-reg", @"irctc-book", @"irctc-cancel", @"irctc-file-tdr", @"irctc-tdr-history", @"irctc-booking-history", @"itr-rectification", @"itr-refund", @"itr-payment", @"itr-itrv", @"cleartax", @"ctax-tin", @"ctax-cst", @"ctax-msugam", @"redbus-book", @"redbus-cancel", @"redbus-history", @"mysore-its-geninfo", @"mysore-its-pretrip", @"mysore-its-real", @"hdmc-reg", @"hdmc-paytax",@"frro-visa",@"frro-faq",@"frro-document",@"frro-contact",@"ksndmc-sub",@"kstdc-enquire",@"kstdc-book",@"kstdc-cancel",@"kstdc-history"];
        return servicesArray;
    TCEND
}

+ (NSMutableArray *) getUtilitesServices {
   
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];

    for (int i = 0; i<6; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"BESCOM" forKey:@"image"];
            [dict setObject:languageForKey(@"bescom") forKey:@"title"];
            [dict setObject:@"bescom" forKey:@"deptname"];
            [dict setObject:@"1" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"CESCOM" forKey:@"image"];
            [dict setObject:languageForKey(@"cescom") forKey:@"title"];
            [dict setObject:@"cescom" forKey:@"deptname"];
            [dict setObject:@"2" forKey:@"appaction"];
        } else if (i==2) {
            [dict setObject:@"GESCOM" forKey:@"image"];
            [dict setObject:languageForKey(@"gescom") forKey:@"title"];
            [dict setObject:@"gescom" forKey:@"deptname"];
            [dict setObject:@"3" forKey:@"appaction"];
        } else if (i==3) {
            [dict setObject:@"MESCOM" forKey:@"image"];
            [dict setObject:languageForKey(@"mescom") forKey:@"title"];
            [dict setObject:@"mescom" forKey:@"deptname"];
            [dict setObject:@"4" forKey:@"appaction"];
        } else if (i==4) {
            [dict setObject:@"HESCOM" forKey:@"image"];
            [dict setObject:languageForKey(@"hescom") forKey:@"title"];
            [dict setObject:@"hescom" forKey:@"deptname"];
            [dict setObject:@"5" forKey:@"appaction"];
        } else if (i==5) {
            [dict setObject:@"BWSSB" forKey:@"image"];
            [dict setObject:languageForKey(@"bwssb") forKey:@"title"];
            [dict setObject:@"bwssb" forKey:@"deptname"];
            [dict setObject:@"6" forKey:@"appaction"];
        }
        
        [finalArray insertObject:dict atIndex:i];
    }
    return finalArray;
    TCEND
}
+ (NSMutableArray *) getPayFineChallans {
    
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"btp-payfine" forKey:@"image"];
    [dict setObject:languageForKey(@"btp-payfine") forKey:@"title"];
    [dict setObject:@"btp" forKey:@"deptname"];
    [dict setObject:@"btp-payfine" forKey:@"subdeptname"];
    [dict setObject:@"7" forKey:@"appaction"];
    [finalArray insertObject:dict atIndex:0];
    return finalArray;

    TCEND
}


+ (NSMutableArray *) getPhoneBillsRecharges {
    
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    
    for (int i = 0; i<6; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"RECHARGE" forKey:@"image"];
            [dict setObject:languageForKey(@"prepaid") forKey:@"title"];
            [dict setObject:@"recharge" forKey:@"deptname"];
            [dict setObject:@"7" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"AIRTEL" forKey:@"image"];
            [dict setObject:languageForKey(@"airtel") forKey:@"title"];
            [dict setObject:@"airtel" forKey:@"deptname"];
            [dict setObject:@"8" forKey:@"appaction"];
        } else if (i==2) {
            [dict setObject:@"VODAFONE" forKey:@"image"];
            [dict setObject:languageForKey(@"vodafone") forKey:@"title"];
            [dict setObject:@"vodafone" forKey:@"deptname"];
            [dict setObject:@"9" forKey:@"appaction"];
        } else if (i==3) {
            [dict setObject:@"IDEA" forKey:@"image"];
            [dict setObject:languageForKey(@"idea") forKey:@"title"];
            [dict setObject:@"idea" forKey:@"deptname"];
            [dict setObject:@"10" forKey:@"appaction"];
        } else if (i==4) {
            [dict setObject:@"TATA" forKey:@"image"];
            [dict setObject:languageForKey(@"tata") forKey:@"title"];
            [dict setObject:@"tata" forKey:@"deptname"];
            [dict setObject:@"11" forKey:@"appaction"];
        } else if (i==5) {
            [dict setObject:@"CELLONE" forKey:@"image"];
            [dict setObject:languageForKey(@"cellone") forKey:@"title"];
            [dict setObject:@"cellone" forKey:@"deptname"];
            [dict setObject:@"12" forKey:@"appaction"];
        }
        
        [finalArray insertObject:dict atIndex:i];
    }
    return finalArray;
    TCEND
}

+ (NSMutableArray *) getRTOServices {
    
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];

    for (int i = 0; i<3; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"RTO" forKey:@"image"];
            [dict setObject:languageForKey(@"rto-lldl") forKey:@"title"];
            [dict setObject:@"rto" forKey:@"deptname"];
            [dict setObject:@"rto-lldl" forKey:@"subdeptname"];
            [dict setObject:@"14" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"RTO" forKey:@"image"];
            [dict setObject:languageForKey(@"rto-dlextract") forKey:@"title"];
            [dict setObject:@"rto" forKey:@"deptname"];
            [dict setObject:@"rto-dlextract" forKey:@"subdeptname"];
            [dict setObject:@"15" forKey:@"appaction"];
        } else if (i==2) {
            [dict setObject:@"RTO" forKey:@"image"];
            [dict setObject:languageForKey(@"rto-rcextract") forKey:@"title"];
            [dict setObject:@"rto" forKey:@"deptname"];
            [dict setObject:@"rto-rcextract" forKey:@"subdeptname"];
            [dict setObject:@"16" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    
    return finalArray;
    TCEND
}

+ (NSMutableArray *) getBackwardclasses { //sakala18, postal 19, khajane 20
    
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    
    for (int i = 0; i<2; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"RECHARGE" forKey:@"image"];
            [dict setObject:languageForKey(@"bc-appno") forKey:@"title"];
            [dict setObject:@"backwardclasses" forKey:@"deptname"];
            [dict setObject:@"bc-appno" forKey:@"subdeptname"];
            [dict setObject:@"20" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"RECHARGE" forKey:@"image"];
            [dict setObject:languageForKey(@"bc-appstatus") forKey:@"title"];
            [dict setObject:@"backwardclasses" forKey:@"deptname"];
            [dict setObject:@"bc-appstatus" forKey:@"subdeptname"];
            [dict setObject:@"21" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    
    return finalArray;
    TCEND
}

+ (NSMutableArray *) getBMRCLServices {
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    
    for (int i = 0; i<3; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"BMRCL" forKey:@"image"];
            [dict setObject:languageForKey(@"bmrcl-topup") forKey:@"title"];
            [dict setObject:@"bmrcl" forKey:@"deptname"];
            [dict setObject:@"bmrcl-topup" forKey:@"subdeptname"];
            [dict setObject:@"22" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"BMRCL" forKey:@"image"];
            [dict setObject:languageForKey(@"bmrcl-history") forKey:@"title"];
            [dict setObject:@"bmrcl" forKey:@"deptname"];
            [dict setObject:@"bmrcl-history" forKey:@"subdeptname"];
            [dict setObject:@"23" forKey:@"appaction"];
        } else if (i==2) {
            [dict setObject:@"BMRCL" forKey:@"image"];
            [dict setObject:languageForKey(@"bmrcl-fare") forKey:@"title"];
            [dict setObject:@"bmrcl" forKey:@"deptname"];
            [dict setObject:@"bmrcl-fare" forKey:@"subdeptname"];
            [dict setObject:@"24" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    
    return finalArray;
    TCEND
}


+ (NSMutableArray *) getAadharServices {
    
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    for (int i = 0; i<3; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"AADHAR" forKey:@"image"];
            [dict setObject:languageForKey(@"aadhar-edoc") forKey:@"title"];
            [dict setObject:@"aadhar" forKey:@"deptname"];
            [dict setObject:@"aadhar-edoc" forKey:@"subdeptname"];
            [dict setObject:@"33" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"AADHAR" forKey:@"image"];
            [dict setObject:languageForKey(@"aadhar-ecenter") forKey:@"title"];
            [dict setObject:@"aadhar" forKey:@"deptname"];
            [dict setObject:@"aadhar-ecenter" forKey:@"subdeptname"];
            [dict setObject:@"34" forKey:@"appaction"];
        } else if (i==2) {
            [dict setObject:@"AADHAR" forKey:@"image"];
            [dict setObject:languageForKey(@"aadhar-coordinator") forKey:@"title"];
            [dict setObject:@"aadhar" forKey:@"deptname"];
            [dict setObject:@"aadhar-coordinator" forKey:@"subdeptname"];
            [dict setObject:@"35" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    
    return finalArray;
    TCEND
}

+ (NSMutableArray *) getStampsRegistrationServices {
    
    
     TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    for (int i = 0; i<3; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"STAMPS" forKey:@"image"];
            [dict setObject:languageForKey(@"stamps-fee") forKey:@"title"];
            [dict setObject:@"stamps" forKey:@"deptname"];
            [dict setObject:@"stamps-fee" forKey:@"subdeptname"];
            [dict setObject:@"36" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"STAMPS" forKey:@"image"];
            [dict setObject:languageForKey(@"stamps-docs") forKey:@"title"];
            [dict setObject:@"stamps" forKey:@"deptname"];
            [dict setObject:@"stamps-docs" forKey:@"subdeptname"];
            [dict setObject:@"37" forKey:@"appaction"];
        } else if (i==2) {
            [dict setObject:@"STAMPS" forKey:@"image"];
            [dict setObject:languageForKey(@"stamps-contacts") forKey:@"title"];
            [dict setObject:@"stamps" forKey:@"deptname"];
            [dict setObject:@"stamps-contacts" forKey:@"subdeptname"];
            [dict setObject:@"38" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    
    return finalArray;
    TCEND
}

+ (NSMutableArray *) getKSRTCServices {
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    for (int i = 0; i<3; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"KSRTC" forKey:@"image"];
            [dict setObject:languageForKey(@"ksrtc-book") forKey:@"title"];
            [dict setObject:@"ksrtc" forKey:@"deptname"];
            [dict setObject:@"ksrtc-book" forKey:@"subdeptname"];
            [dict setObject:@"40" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"KSRTC" forKey:@"image"];
            [dict setObject:languageForKey(@"ksrtc-cancel") forKey:@"title"];
            [dict setObject:@"ksrtc" forKey:@"deptname"];
            [dict setObject:@"ksrtc-cancel" forKey:@"subdeptname"];
            [dict setObject:@"41" forKey:@"appaction"];
        } else if (i==2) {
            [dict setObject:@"KSRTC" forKey:@"image"];
            [dict setObject:languageForKey(@"ksrtc-history") forKey:@"title"];
            [dict setObject:@"ksrtc" forKey:@"deptname"];
            [dict setObject:@"ksrtc-history" forKey:@"subdeptname"];
            [dict setObject:@"42" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    
    return finalArray;
    TCEND
}


+ (NSMutableArray *) getREDBUSServices {
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    for (int i = 0; i<3; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"REDBUS" forKey:@"image"];
            [dict setObject:languageForKey(@"redbus-book") forKey:@"title"];
            [dict setObject:@"redbus" forKey:@"deptname"];
            [dict setObject:@"redbus-book" forKey:@"subdeptname"];
            [dict setObject:@"71" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"REDBUS" forKey:@"image"];
            [dict setObject:languageForKey(@"redbus-cancel") forKey:@"title"];
            [dict setObject:@"redbus" forKey:@"deptname"];
            [dict setObject:@"redbus-cancel" forKey:@"subdeptname"];
            [dict setObject:@"72" forKey:@"appaction"];
        } else if (i==2) {
            [dict setObject:@"REDBUS" forKey:@"image"];
            [dict setObject:languageForKey(@"redbus-history") forKey:@"title"];
            [dict setObject:@"redbus" forKey:@"deptname"];
            [dict setObject:@"redbus-history" forKey:@"subdeptname"];
            [dict setObject:@"73" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    
    return finalArray;
    TCEND
}

+ (NSMutableArray *) getIRCTCServices {
    
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    for (int i = 0; i<5; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
//        if (i==0) {
//            [dict setObject:@"IRCTC" forKey:@"image"];
//            [dict setObject:languageForKey(@"irctc-reg") forKey:@"title"];
//            [dict setObject:@"irctc" forKey:@"deptname"];
//            [dict setObject:@"irctc-reg" forKey:@"subdeptname"];
//            [dict setObject:@"43" forKey:@"appaction"];
//        }
        if (i==0) {
            [dict setObject:@"IRCTC" forKey:@"image"];
            [dict setObject:languageForKey(@"irctc-book") forKey:@"title"];
            [dict setObject:@"irctc" forKey:@"deptname"];
            [dict setObject:@"irctc-book" forKey:@"subdeptname"];
            [dict setObject:@"44" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"IRCTC" forKey:@"image"];
            [dict setObject:languageForKey(@"irctc-cancel") forKey:@"title"];
            [dict setObject:@"irctc" forKey:@"deptname"];
            [dict setObject:@"irctc-cancel" forKey:@"subdeptname"];
            [dict setObject:@"45" forKey:@"appaction"];
        } else if (i==2) {
            [dict setObject:@"IRCTC" forKey:@"image"];
            [dict setObject:languageForKey(@"irctc-file-tdr") forKey:@"title"];
            [dict setObject:@"irctc" forKey:@"deptname"];
            [dict setObject:@"irctc-file-tdr" forKey:@"subdeptname"];
            [dict setObject:@"46" forKey:@"appaction"];
        } else if (i==3) {
            [dict setObject:@"IRCTC" forKey:@"image"];
            [dict setObject:languageForKey(@"irctc-tdr-history") forKey:@"title"];
            [dict setObject:@"irctc" forKey:@"deptname"];
            [dict setObject:@"irctc-tdr-history" forKey:@"subdeptname"];
            [dict setObject:@"47" forKey:@"appaction"];
        } else if (i==4) {
            [dict setObject:@"IRCTC" forKey:@"image"];
            [dict setObject:languageForKey(@"irctc-booking-history") forKey:@"title"];
            [dict setObject:@"irctc" forKey:@"deptname"];
            [dict setObject:@"irctc-booking-history" forKey:@"subdeptname"];
            [dict setObject:@"48" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    
    return finalArray;
    TCEND
}


+ (NSMutableArray *) getTaxactionServices {
    
     TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    for (int i = 0; i<8; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"INCOMETAX" forKey:@"image"];
            [dict setObject:languageForKey(@"itr-rectification") forKey:@"title"];
            [dict setObject:@"incometax" forKey:@"deptname"];
            [dict setObject:@"itr-rectification" forKey:@"subdeptname"];
            [dict setObject:@"39" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"INCOMETAX" forKey:@"image"];
            [dict setObject:languageForKey(@"itr-refund") forKey:@"title"];
            [dict setObject:@"incometax" forKey:@"deptname"];
            [dict setObject:@"itr-refund" forKey:@"subdeptname"];
            [dict setObject:@"40" forKey:@"appaction"];
        } else if (i==2) {
            [dict setObject:@"INCOMETAX" forKey:@"image"];
            [dict setObject:languageForKey(@"itr-payment") forKey:@"title"];
            [dict setObject:@"incometax" forKey:@"deptname"];
            [dict setObject:@"itr-payment" forKey:@"subdeptname"];
            [dict setObject:@"41" forKey:@"appaction"];
        } else if (i==3) {
            [dict setObject:@"INCOMETAX" forKey:@"image"];
            [dict setObject:languageForKey(@"itr-itrv") forKey:@"title"];
            [dict setObject:@"incometax" forKey:@"deptname"];
            [dict setObject:@"itr-itrv" forKey:@"subdeptname"];
            [dict setObject:@"42" forKey:@"appaction"];
        } else if (i==4) {
            [dict setObject:@"CLEARTAX" forKey:@"image"];
            [dict setObject:languageForKey(@"cleartax") forKey:@"title"];
            [dict setObject:@"cleartax" forKey:@"deptname"];
            [dict setObject:@"cleartax" forKey:@"subdeptname"];
            [dict setObject:@"43" forKey:@"appaction"];
        } else if (i==5) {
            [dict setObject:@"COMMERCIALTAX" forKey:@"image"];
            [dict setObject:languageForKey(@"ctax-tin") forKey:@"title"];
            [dict setObject:@"commercialtax" forKey:@"deptname"];
            [dict setObject:@"ctax-tin" forKey:@"subdeptname"];
            [dict setObject:@"44" forKey:@"appaction"];
        } else if (i==6) {
            [dict setObject:@"COMMERCIALTAX" forKey:@"image"];
            [dict setObject:languageForKey(@"ctax-cst") forKey:@"title"];
            [dict setObject:@"commercialtax" forKey:@"deptname"];
            [dict setObject:@"ctax-cst" forKey:@"subdeptname"];
            [dict setObject:@"45" forKey:@"appaction"];
        } else if (i==7) {
            [dict setObject:@"COMMERCIALTAX" forKey:@"image"];
            [dict setObject:languageForKey(@"ctax-msugam") forKey:@"title"];
            [dict setObject:@"commercialtax" forKey:@"deptname"];
            [dict setObject:@"ctax-msugam" forKey:@"subdeptname"];
            [dict setObject:@"46" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    
    return finalArray;
    TCEND
}

+ (NSMutableArray *) getSCRBServices {//25 btp-payfine
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    
    for (int i = 0; i<4; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"BTP" forKey:@"image"];
            [dict setObject:languageForKey(@"btp-register") forKey:@"title"];
            [dict setObject:@"btp" forKey:@"deptname"];
            [dict setObject:@"btp-register" forKey:@"subdeptname"];
            [dict setObject:@"26" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"SCRB" forKey:@"image"];
            [dict setObject:languageForKey(@"scrb-pvc") forKey:@"title"];
            [dict setObject:@"scrb" forKey:@"deptname"];
            [dict setObject:@"scrb-pvc" forKey:@"subdeptname"];
            [dict setObject:@"27" forKey:@"appaction"];
        } else if (i==2) {
            [dict setObject:@"SCRB" forKey:@"image"];
            [dict setObject:languageForKey(@"scrb-amp") forKey:@"title"];
            [dict setObject:@"scrb" forKey:@"deptname"];
            [dict setObject:@"scrb-amp" forKey:@"subdeptname"];
            [dict setObject:@"28" forKey:@"appaction"];
        } else if (i==3) {
            [dict setObject:@"SCRB" forKey:@"image"];
            [dict setObject:languageForKey(@"scrb-vsrp") forKey:@"title"];
            [dict setObject:@"scrb" forKey:@"deptname"];
            [dict setObject:@"scrb-vsrp" forKey:@"subdeptname"];
            [dict setObject:@"29" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    
    return finalArray;
    TCEND
}

+ (NSMutableArray *) getPassportServices {
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    
    for (int i = 0; i<3; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"PASSPORT" forKey:@"image"];
            [dict setObject:languageForKey(@"passport-fee") forKey:@"title"];
            [dict setObject:@"passport" forKey:@"deptname"];
            [dict setObject:@"passport-fee" forKey:@"subdeptname"];
            [dict setObject:@"68" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"PASSPORT" forKey:@"image"];
            [dict setObject:languageForKey(@"passport-status") forKey:@"title"];
            [dict setObject:@"passport" forKey:@"deptname"];
            [dict setObject:@"passport-status" forKey:@"subdeptname"];
            [dict setObject:@"69" forKey:@"appaction"];
        } else if (i==2) {
            [dict setObject:@"PASSPORT" forKey:@"image"];
            [dict setObject:languageForKey(@"passport-locate") forKey:@"title"];
            [dict setObject:@"passport" forKey:@"deptname"];
            [dict setObject:@"passport-locate" forKey:@"subdeptname"];
            [dict setObject:@"70" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    
    return finalArray;
    TCEND
}

+ (NSMutableArray *) getMysoreITSServices {
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    
    for (int i = 0; i<3; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"MYSORE-ITS" forKey:@"image"];
            [dict setObject:languageForKey(@"mysore-its-geninfo") forKey:@"title"];
            [dict setObject:@"mysore-its" forKey:@"deptname"];
            [dict setObject:@"mysore-its-geninfo" forKey:@"subdeptname"];
            [dict setObject:@"72" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"MYSORE-ITS" forKey:@"image"];
            [dict setObject:languageForKey(@"mysore-its-pretrip") forKey:@"title"];
            [dict setObject:@"mysore-its" forKey:@"deptname"];
            [dict setObject:@"mysore-its-pretrip" forKey:@"subdeptname"];
            [dict setObject:@"73" forKey:@"appaction"];
        } else if (i==2) {
            [dict setObject:@"MYSORE-ITS" forKey:@"image"];
            [dict setObject:languageForKey(@"mysore-its-real") forKey:@"title"];
            [dict setObject:@"mysore-its" forKey:@"deptname"];
            [dict setObject:@"mysore-its-real" forKey:@"subdeptname"];
            [dict setObject:@"74" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    
    return finalArray;
    TCEND
}

+ (NSMutableArray *) getHDMCPropertyTaxServices {
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    for (int i = 0; i<2; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"HDMC" forKey:@"image"];
            [dict setObject:languageForKey(@"hdmc-reg") forKey:@"title"];
            [dict setObject:@"hdmc" forKey:@"deptname"];
            [dict setObject:@"hdmc-reg" forKey:@"subdeptname"];
            [dict setObject:@"75" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"HDMC" forKey:@"image"];
            [dict setObject:languageForKey(@"hdmc-paytax") forKey:@"title"];
            [dict setObject:@"hdmc" forKey:@"deptname"];
            [dict setObject:@"hdmc-paytax" forKey:@"subdeptname"];
            [dict setObject:@"76" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    return finalArray;
    TCEND
}
+ (NSMutableArray *) getFRROPropertyServices {
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    for (int i = 0; i<3; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"FRRO" forKey:@"image"];
            [dict setObject:languageForKey(@"frro-contact") forKey:@"title"]; //frro-contact
            [dict setObject:@"frro" forKey:@"deptname"];
            [dict setObject:@"frro-contact" forKey:@"subdeptname"];
            [dict setObject:@"77" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"FRRO" forKey:@"image"];
            [dict setObject:languageForKey(@"frro-document") forKey:@"title"]; //frro-document
            [dict setObject:@"frro" forKey:@"deptname"];
            [dict setObject:@"frro-document" forKey:@"subdeptname"];
            [dict setObject:@"78" forKey:@"appaction"];
        }
        else if (i==2) {
            [dict setObject:@"FRRO" forKey:@"image"];
            [dict setObject:languageForKey(@"frro-faq") forKey:@"title"]; //frro-faq
            [dict setObject:@"frro" forKey:@"deptname"];
            [dict setObject:@"frro-faq" forKey:@"subdeptname"];
            [dict setObject:@"79" forKey:@"appaction"];
        }
        else if (i==3) {
            [dict setObject:@"FRRO" forKey:@"image"];
            [dict setObject:languageForKey(@"frro-visa") forKey:@"title"]; //frro-visa
            [dict setObject:@"frro" forKey:@"deptname"];
            [dict setObject:@"frro-visa" forKey:@"subdeptname"];
            [dict setObject:@"80" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    return finalArray;
    TCEND
}

+ (NSMutableArray *) getKSTDCPropertyServices {
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    for (int i = 0; i<3; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"KSTDC" forKey:@"image"];
            [dict setObject:languageForKey(@"kstdc-enquire") forKey:@"title"];
            [dict setObject:@"kstdc" forKey:@"deptname"];
            [dict setObject:@"kstdc-enquire" forKey:@"subdeptname"];
            [dict setObject:@"82" forKey:@"appaction"];
        } else if (i==1) {
            [dict setObject:@"KSTDC" forKey:@"image"];
            [dict setObject:languageForKey(@"kstdc-book") forKey:@"title"];
            [dict setObject:@"kstdc" forKey:@"deptname"];
            [dict setObject:@"kstdc-book" forKey:@"subdeptname"];
            [dict setObject:@"83" forKey:@"appaction"];
        }
        else if (i==2) {
            [dict setObject:@"KSTDC" forKey:@"image"];
            [dict setObject:languageForKey(@"kstdc-cancel") forKey:@"title"];
            [dict setObject:@"kstdc" forKey:@"deptname"];
            [dict setObject:@"kstdc-cancel" forKey:@"subdeptname"];
            [dict setObject:@"84" forKey:@"appaction"];
        }
        else if (i==3) {
            [dict setObject:@"KSTDC" forKey:@"image"];
            [dict setObject:languageForKey(@"kstdc-history") forKey:@"title"];
            [dict setObject:@"kstdc" forKey:@"deptname"];
            [dict setObject:@"kstdc-history" forKey:@"subdeptname"];
            [dict setObject:@"85" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    return finalArray;
    TCEND
}

#pragma mark - Toast Message

+ (void)writeToast:(NSString *)message
{
    TCSTART
    
    UIView * toastView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].windows.lastObject addSubview:toastView];
    [[UIApplication sharedApplication].windows.lastObject bringSubviewToFront:toastView];
    [toastView makeToast:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [toastView removeFromSuperview];
    });
    
    TCEND
}
+ (void) showErrorToastMessage:(id)object {
    if (![Utils isEmptyValue:object]) {
        NSDictionary *dict = object;
        DISPLAY_TOAST([dict valueForKey:@"desc"] ? [dict valueForKey:@"desc"] : UNKNOWN_ERROR_TOAST);
    } else {
        DISPLAY_TOAST(UNKNOWN_ERROR_TOAST);
    }
}

#pragma mark - Check Internet Availability

+(BOOL)isInternetAvailable
{
    TCSTART
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        DISPLAY_TOAST(NO_INTERNET_AVAILABLE_TOAST);
        return NO;
    }
    
    return YES;
    TCEND
}
+(NSString*) checkNetworkCurrentStatusWithType
{
    TCSTART
    NSString *networkStr = @"";
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [networkReachability currentReachabilityStatus];
    switch (internetStatus) {
        case NotReachable: {
            networkStr=@"nonet";
            break;
        }
        case ReachableViaWiFi: {
            networkStr=@"wifi";
            break;
        }
        case ReachableViaWWAN: {
            networkStr=@"wwan";
            break;
        }
    }
    
    return  networkStr;
    TCEND
}

+ (NSMutableArray *) getKSNDMCServices {
    
    TCSTART
    NSMutableArray *finalArray = [NSMutableArray new];
    
    for (int i = 0; i<1; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (i==0) {
            [dict setObject:@"KSNDMC" forKey:@"image"];
            [dict setObject:languageForKey(@"ksndmc-sub") forKey:@"title"];
            [dict setObject:@"ksndmc" forKey:@"deptname"];
            [dict setObject:@"ksndmc-sub" forKey:@"subdeptname"];
            [dict setObject:@"81" forKey:@"appaction"];
        }
        [finalArray insertObject:dict atIndex:i];
    }
    
    return finalArray;
    TCEND
}

@end
