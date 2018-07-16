//
//  PropertyTaxViewController.m
//  GOK
//
//  Created by admin on 11/07/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#import "PropertyTaxViewController.h"

@interface PropertyTaxViewController (){
    
    __weak IBOutlet UITextField *pidNumberTF;
    __weak IBOutlet UIButton *submitButton;
    __weak IBOutlet UILabel *mainTitleLabel;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *subTitleLabel;
    __weak IBOutlet UILabel *phoneNoLabel;
    __weak IBOutlet UILabel *responseLabel;
    NSArray *responseArray;
}

@end

@implementation PropertyTaxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    TCSTART
    [self updateFontsAndColors];
    [self updateElements];
    TCEND
   
}

-(void) viewDidAppear:(BOOL)animated {
    TCSTART
    [super viewDidAppear:animated];
    TCEND
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  Custom Methods
-(void) updateFontsAndColors {
    
    TCSTART
    START_MAIN_THREAD
    self.view.backgroundColor = WHITE_COLOR;
    [Utils updateTitleLabelGlobally:mainTitleLabel];
    [Utils updateTitleLabelGlobally:titleLabel];
    [Utils updateSubTitleLabelGlobally:subTitleLabel];
    [Utils updateSubTitleLabelGlobally:phoneNoLabel];
    [Utils updateSubmitButton:submitButton withBCColor:APP_THEME_YELLOW_COLOR withTtileColor:BLACK_TEXT_COLOR];
    END_THREAD
    TCEND
    
}
-(void)updateElements {
    TCSTART
    mainTitleLabel.text = languageForKey(@"hublidharwadptaxpayment");
    titleLabel.text = languageForKey(@"register");
    subTitleLabel.text = languageForKey(@"propertytaxpayment");
    pidNumberTF.placeholder = languageForKey(@"picnumber");
    [submitButton setTitle:languageForKey(@"submit") forState:UIControlStateNormal];
    phoneNoLabel.text = [NSString stringWithFormat:@"%@: %@", languageForKey(@"phonenumber"), [UserDefaults getUserMobile]];
    TCEND
}
-(void) getPropertyTaxInfoFromAPI {
    
    TCSTART
    NSString *ptidNumber = [NSString stringWithFormat:@"%@",pidNumberTF.text];
    NSDictionary *params = @{@"deptname":@"hdmc", @"channel": @"IOS", @"mobileno":[UserDefaults getUserMobile],@"servicecode":@"6",@"ptid":ptidNumber};
    
    [self commonServiceCall:params completionBlock:^(id response, int code) {
        if (code == 0) {
            if (![Utils isEmptyValue:response]) {
                if ([[response valueForKey:@"desc"] isKindOfClass:[NSDictionary class]]) {
                    responseArray = @[[response valueForKey:@"desc"]];
                    if (![Utils isEmptyValue:responseArray]) {
                    }
                } else {
                    responseArray = [response valueForKey:@"desc"];
                }
                responseLabel.text = [NSString stringWithFormat:@"%@",responseArray];
            } else { [Utils showErrorToastMessage:response]; }
        } else { [Utils showErrorToastMessage:response]; }
    }];
    
    TCEND
}

#pragma mark -  UITextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString {
    
    if (textField == pidNumberTF) {
        TCSTART
        NSCharacterSet *cs  = [[NSCharacterSet characterSetWithCharactersInString:ALPHA_NUMERIC_SLASH] invertedSet];
        NSString *filtered = [[replacementString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        if ([replacementString isEqualToString:filtered]) {
            NSString *resultText = [textField.text stringByReplacingCharactersInRange:range withString:replacementString];
            return resultText.length <= 20;
        } else {
            return NO;
        }
        TCEND
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    
}
#pragma mark - Button Actions
- (IBAction)submitButton:(id)sender {
    if(![Utils isEmptyValue:pidNumberTF.text]){
        [self getPropertyTaxInfoFromAPI];
    }else{
        [Utils showErrorToastMessage:@{@"desc":languageForKey(@"enterpidno")}];
    }
}




@end
