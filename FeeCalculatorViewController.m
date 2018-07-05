//
//  FeeCalculatorViewController.m
//  GOK
//
//  Created by admin on 05/07/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#import "FeeCalculatorViewController.h"


@interface FeeCalculatorViewController ()
{
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIView *contentView;
    
    __weak IBOutlet IQDropDownTextField *selectServiceTypeTF;
    __weak IBOutlet IQDropDownTextField *selectTF1;
    __weak IBOutlet UIImageView *selectImg1;
    __weak IBOutlet IQDropDownTextField *selectTF2;
    __weak IBOutlet UIImageView *selectImg2;
    __weak IBOutlet IQDropDownTextField *selectTF3;
    __weak IBOutlet UIImageView *selectImg3;
    __weak IBOutlet IQDropDownTextField *selectTF4;
    __weak IBOutlet UIImageView *selectImg4;
    __weak IBOutlet IQDropDownTextField *selectTF5;
    __weak IBOutlet UIImageView *selectImg5;
    
    __weak IBOutlet UIButton *submitButton;
    
    
    __weak IBOutlet UILabel *feeAmountTitleLabel;
    __weak IBOutlet UILabel *feeAmountLabel;
    
    NSArray *passportServiceTypesArray;
    __weak IBOutlet NSLayoutConstraint *selectReasonTF;
    __weak IBOutlet NSLayoutConstraint *submitBtnTopConstraint;
}

@end

@implementation FeeCalculatorViewController
- (IBAction)submitButton:(id)sender {
    
    if(![selectTF1 isHidden]){
        selectTF1.hidden = YES;
        selectReasonTF.constant=10;
    }
    else{
         selectTF1.hidden = NO;
         selectReasonTF.constant=70;
    }
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    selectServiceTypeTF.isOptionalDropDown = NO;
    [selectServiceTypeTF setItemList:[NSArray arrayWithObjects:@"Fresh",@"Reissue",@"PCC", nil]];
    
    selectServiceTypeTF.text = @"Fresh";
    
    if([selectServiceTypeTF.text isEqualToString: @"Fresh"]){
           selectTF2.hidden = YES;
        selectTF3.hidden = YES;
        selectTF4.hidden = YES;
        selectTF5.hidden = YES;
        submitBtnTopConstraint.constant = 80;
    }
}


#pragma mark -  UITextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

/*
-(void) textFieldDidBeginEditing:(UITextField *)textField {
    TCSTART
    if (textField == selectFeeApplicationDocTF) {
        feeApplcnDocDropIcon.highlighted = YES;
    } else {
        if ([Utils isEmptyValue:selectFeeApplicationDocTF.text]) {
            if ([_subdeptname isEqualToString:@"stamps-contacts"]) {
                if ([selectFeeApplicationDocTF.text isEqualToString:@"Department Contacts"]) {
                    DISPLAY_TOAST(SELECT_DEPT_CONTACT_TOAST);
                    [textField resignFirstResponder];
                }
            } else  if ([_subdeptname isEqualToString:@"stamps-docs"]){
                if ([selectFeeApplicationDocTF.text isEqualToString:@"Property Registration"]) {
                    DISPLAY_TOAST(SELECT_DEPT_DOC_TOAST);
                    [textField resignFirstResponder];
                }
            } else  if ([_subdeptname isEqualToString:@"stamps-fee"]){
                if ([selectFeeApplicationDocTF.text isEqualToString:@"Property Registration Fees"]) {
                    DISPLAY_TOAST(SELECT_DEPT_FEE_TOAST);
                    [textField resignFirstResponder];
                }
            }
        } else {
            selectDocLocationDropIcon.highlighted = YES;
        }
    }
    TCEND
}
*/
-(void) textFieldDidEndEditing:(UITextField *)textField {
    TCSTART
    if (textField == selectServiceTypeTF) {
      //  feeApplcnDocDropIcon.highlighted = NO;
        if (![Utils isEmptyValue:selectServiceTypeTF.text]) {
            if ([selectServiceTypeTF.text isEqualToString:@"Fresh"]) {
              
                selectTF2.hidden = YES;
                selectTF3.hidden = YES;
                selectTF4.hidden = YES;
                selectTF5.hidden = YES;
                submitBtnTopConstraint.constant = 80;
                
            } else if ([selectServiceTypeTF.text isEqualToString:@"Reissue"]){
                selectTF2.hidden = NO;
                selectTF3.hidden = NO;
                selectTF4.hidden = NO;
                selectTF5.hidden = NO;
                submitBtnTopConstraint.constant = 310;
            } else {
              
            }
        }
    } else {
       // selectDocLocationDropIcon.highlighted = NO;
        if (![Utils isEmptyValue:selectServiceTypeTF.text]) {

        }
    }
    TCEND
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
