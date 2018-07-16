//
//  PropertyTaxPaymentViewController.m
//  GOK
//
//  Created by admin on 11/07/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#import "PropertyTaxPaymentViewController.h"

@interface PropertyTaxPaymentViewController (){

    __weak IBOutlet IQDropDownTextField *propertyIDTF;
    __weak IBOutlet UIButton *submitButton;
    __weak IBOutlet UILabel *mainTitleLabel;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *subTitleLabel;
    NSArray *registeredBillsArray;
    NSMutableArray *registeredBillsResponseArray;
    NSArray *responseArray;
}

@end

@implementation PropertyTaxPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    TCSTART
    [self updateFontsAndColors];
    [self updateElements];
    
    registeredBillsResponseArray = [[NSMutableArray alloc]init];

    propertyIDTF.isOptionalDropDown = YES;
    TCEND
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    TCSTART
        [self getRegisteredBillsFromAPI];
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
    [Utils updateTextFieldGlobally:propertyIDTF];
    [Utils updateSubmitButton:submitButton withBCColor:APP_THEME_YELLOW_COLOR withTtileColor:BLACK_TEXT_COLOR];
    END_THREAD
    TCEND
    
}
-(void)updateElements {
    TCSTART
    mainTitleLabel.text = languageForKey(@"hublidharwadptaxpayment");
    titleLabel.text = languageForKey(@"viewbill");
    subTitleLabel.text = languageForKey(@"hublidharwadptaxpayment");
    propertyIDTF.placeholder = languageForKey(@"selectpropertyid");
    [submitButton setTitle:languageForKey(@"submit") forState:UIControlStateNormal];
    TCEND
}


-(void) getRegisteredBillsFromAPI {
    
    TCSTART
    NSDictionary *params = @{@"deptname":@"hdmc", @"channel": @"IOS", @"mobileno":[UserDefaults getUserMobile],@"servicecode":@"8"};
    
    [self commonServiceCall:params completionBlock:^(id response, int code) {
        if (code == 0) {
            if (![Utils isEmptyValue:response]) {
                if ([[response valueForKey:@"item"] isKindOfClass:[NSDictionary class]]) {
                    registeredBillsArray = @[[response valueForKey:@"item"]];
                    if (![Utils isEmptyValue:registeredBillsArray]) {
                    }
                } else {
                    registeredBillsArray = [response valueForKey:@"item"];
                }
                [registeredBillsResponseArray removeAllObjects];
                for(int i=0;i< [registeredBillsArray count];i++){
                    [registeredBillsResponseArray addObject: [[registeredBillsArray objectAtIndex:i] objectForKey:@"pid"]];
                }
                
                [propertyIDTF setItemList: [NSArray arrayWithArray:registeredBillsResponseArray]];
                
            } else { [Utils showErrorToastMessage:response]; }
        } else { [Utils showErrorToastMessage:response]; }
    }];
    
    TCEND
}


-(void) getPropertyTaxDetailsFromAPI {
    
    TCSTART
    NSString *ptidNumber = [NSString stringWithFormat:@"%@",propertyIDTF.text];
    NSDictionary *params = @{@"deptname":@"hdmc", @"channel": @"IOS", @"mobileno":[UserDefaults getUserMobile],@"servicecode":@"9",@"ptid":ptidNumber};
    
    [self commonServiceCall:params completionBlock:^(id response, int code) {
        if (code == 0) {
            if (![Utils isEmptyValue:response]) {
                NSDictionary * obj = response;
                START_THREAD_AFTER(0.6)
                [[NSNotificationCenter defaultCenter] postNotificationName:moveCommonMainVCDetailsView object:obj];
                END_THREAD
                
            } else { [Utils showErrorToastMessage:response]; }
        } else { [Utils showErrorToastMessage:response]; }
    }];
    
    TCEND
}

#pragma mark - Button Actions
- (IBAction)submitButton:(id)sender {
    if(![Utils isEmptyValue:propertyIDTF.text]){
        [self getPropertyTaxDetailsFromAPI];
    }else{
        [Utils showErrorToastMessage:@{@"desc":languageForKey(@"selectpropertyid")}];
    }
}

#pragma mark -  UITextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == propertyIDTF){
        if([Utils isEmptyValue:registeredBillsArray]){
            [Utils showErrorToastMessage:@{@"desc":languageForKey(@"registerandtryagain")}];
            [textField resignFirstResponder];
        }
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    
}



@end
