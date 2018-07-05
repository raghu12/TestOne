//
//  FeeCalculatorViewController.m
//  GOK
//
//  Created by admin on 05/07/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#import "FeeCalculatorViewController.h"
#import "IQDropDownTextField.h"

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
    __weak IBOutlet UIView *feeAmountLine;
    __weak IBOutlet UILabel *feeAmountLabel;
    
    NSArray *passportServiceTypesArray;
    __weak IBOutlet NSLayoutConstraint *selectReasonTF;
    __weak IBOutlet NSLayoutConstraint *submitBtnTopConstraint;
}

@end

@implementation FeeCalculatorViewController
- (IBAction)submitButton:(id)sender {
    
    
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@""] && [selectTF1.placeholder isEqualToString:@"Select Age"]){
        NSLog(@"Enter Age");
    }
    if(selectTF2.hidden == NO && [selectTF2.text isEqualToString:@""] && [selectTF2.placeholder isEqualToString:@"Select Scheme type"]){
        NSLog(@"Enter Scheme");
    }
    if(selectTF2.hidden == NO && [selectTF2.text isEqualToString:@"Normal"]){
        
        feeAmountTitleLabel.hidden=NO;
        feeAmountLine.hidden=NO;
        feeAmountLabel.hidden=NO;
        
        feeAmountLabel.text = @"1000.00";
    }
    if(selectTF2.hidden == NO && [selectTF2.text isEqualToString:@"Tatkaal"]){
        
        feeAmountTitleLabel.hidden=NO;
        feeAmountLine.hidden=NO;
        feeAmountLabel.hidden=NO;
        
        feeAmountLabel.text = @"3000.00";
    }
    
    
    if(selectTF2.hidden == NO && [selectTF2.text isEqualToString:@""] && [selectTF2.placeholder isEqualToString:@"Select required validity"]){
        NSLog(@"Enter required validity");
    }
    
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"Between 15-18 Years"] && selectTF2.hidden == NO && [selectTF2.placeholder isEqualToString:@"Select required validity type"]){
         NSLog(@"Enter required validity");
    }
    
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"Between 15-18 Years"] && selectTF3.hidden == NO && [selectTF3.placeholder isEqualToString:@"Select scheme type"]){
        NSLog(@"Enter Scheme type");
    }
    
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"Between 15-18 Years"] && selectTF3.hidden == NO && [selectTF3.text isEqualToString:@"Normal"]){
        
        feeAmountTitleLabel.hidden=NO;
        feeAmountLine.hidden=NO;
        feeAmountLabel.hidden=NO;
        
        feeAmountLabel.text = @"1000.00";
    }
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"Between 15-18 Years"] && selectTF3.hidden == NO && [selectTF3.text isEqualToString:@"Tatkaal"]){
        
        feeAmountTitleLabel.hidden=NO;
        feeAmountLine.hidden=NO;
        feeAmountLabel.hidden=NO;
        
        feeAmountLabel.text = @"3000.00";
    }
    
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"Between 15-18 Years"] && selectTF3.hidden == NO && [selectTF3.placeholder isEqualToString:@"Select Booklet Type"]){
        NSLog(@"Enter Booklet type");
    }
   
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"Between 15-18 Years"] && selectTF4.hidden == NO && [selectTF4.placeholder isEqualToString:@"Select scheme type"]){
        NSLog(@"Enter Scheme type");
    }
    
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"Between 15-18 Years"] && selectTF3.hidden == NO && [selectTF3.text isEqualToString:@"36 Pages"] && selectTF4.hidden == NO && [selectTF4.text isEqualToString:@"Normal"]){
        
        feeAmountTitleLabel.hidden=NO;
        feeAmountLine.hidden=NO;
        feeAmountLabel.hidden=NO;
        
        feeAmountLabel.text = @"1500.00";
    }
    
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"Between 15-18 Years"] && selectTF3.hidden == NO && [selectTF3.text isEqualToString:@"36 Pages"] && selectTF4.hidden == NO && [selectTF4.text isEqualToString:@"Tatkaal"]){
        
        feeAmountTitleLabel.hidden=NO;
        feeAmountLine.hidden=NO;
        feeAmountLabel.hidden=NO;
        
        feeAmountLabel.text = @"3500.00";
    }
    
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"Between 15-18 Years"] && selectTF3.hidden == NO && [selectTF3.text isEqualToString:@"60 Pages"] && selectTF4.hidden == NO && [selectTF4.text isEqualToString:@"Normal"]){
        
        feeAmountTitleLabel.hidden=NO;
        feeAmountLine.hidden=NO;
        feeAmountLabel.hidden=NO;
        
        feeAmountLabel.text = @"2000.00";
    }
    
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"Between 15-18 Years"] && selectTF3.hidden == NO && [selectTF3.text isEqualToString:@"60 Pages"] && selectTF4.hidden == NO && [selectTF4.text isEqualToString:@"Tatkaal"]){
        
        feeAmountTitleLabel.hidden=NO;
        feeAmountLine.hidden=NO;
        feeAmountLabel.hidden=NO;
        
        feeAmountLabel.text = @"4000.00";
    }
    
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"18 Years And Above"] && selectTF2.hidden == NO && [selectTF2.placeholder isEqualToString:@"Select Booklet Type"]){
        NSLog(@"Enter Booklet Type");
    }
   
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"18 Years And Above"] && selectTF3.hidden == NO && [selectTF3.placeholder isEqualToString:@"Select scheme type"]){
        NSLog(@"Enter Scheme Type");
    }
    
   
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"18 Years And Above"] && selectTF2.hidden == NO && [selectTF2.text isEqualToString:@"36 Pages"] && selectTF3.hidden == NO && [selectTF3.text isEqualToString:@"Normal"]){
        
        feeAmountTitleLabel.hidden=NO;
        feeAmountLine.hidden=NO;
        feeAmountLabel.hidden=NO;
        
        feeAmountLabel.text = @"1500.00";
    }
    
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"18 Years And Above"] && selectTF2.hidden == NO && [selectTF2.text isEqualToString:@"36 Pages"] && selectTF3.hidden == NO && [selectTF3.text isEqualToString:@"Tatkaal"]){
        
        feeAmountTitleLabel.hidden=NO;
        feeAmountLine.hidden=NO;
        feeAmountLabel.hidden=NO;
        
        feeAmountLabel.text = @"3500.00";
    }
    
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"18 Years And Above"] && selectTF2.hidden == NO && [selectTF2.text isEqualToString:@"60 Pages"] && selectTF3.hidden == NO && [selectTF3.text isEqualToString:@"Normal"]){
        
        feeAmountTitleLabel.hidden=NO;
        feeAmountLine.hidden=NO;
        feeAmountLabel.hidden=NO;
        
        feeAmountLabel.text = @"2000.00";
    }
    
    if(selectTF1.hidden == NO && [selectTF1.text isEqualToString:@"18 Years And Above"] && selectTF2.hidden == NO && [selectTF2.text isEqualToString:@"60 Pages"] && selectTF3.hidden == NO && [selectTF3.text isEqualToString:@"Tatkaal"]){
        
        feeAmountTitleLabel.hidden=NO;
        feeAmountLine.hidden=NO;
        feeAmountLabel.hidden=NO;
        
        feeAmountLabel.text = @"4000.00";
    }
//    if(![selectTF1 isHidden]){
//        selectTF1.hidden = YES;
//        selectReasonTF.constant=10;
//    }
//    else{
//         //selectTF1.hidden = NO;
//         //selectReasonTF.constant=70;
//    }
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    feeAmountTitleLabel.hidden=YES;
    feeAmountLine.hidden=YES;
    feeAmountLabel.hidden=YES;
    
    selectServiceTypeTF.showDismissToolbar = YES;
    
    selectServiceTypeTF.isOptionalDropDown = NO;
    [selectServiceTypeTF setItemList:[NSArray arrayWithObjects:@"Fresh",@"Reissue",@"PCC", nil]];
    selectServiceTypeTF.text = @"Fresh";
   
    
    selectTF1.showDismissToolbar = YES;
    
    selectTF1.isOptionalDropDown = NO;
    [selectTF1 setItemList:[NSArray arrayWithObjects:@"Less Than 15 Years",@"Between 15-18 Years",@"18 Years And Above", nil]];
    selectTF1.placeholder = @"Select Age";
    selectTF1.text = @"";
    
    selectTF2.showDismissToolbar = YES;
    
    selectTF2.isOptionalDropDown = NO;
    [selectTF2 setItemList:[NSArray arrayWithObjects:@"Normal",@"Tatkaal", nil]];
    
    
    
    
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
    
    if (textField == selectServiceTypeTF) {
    
            if ([selectServiceTypeTF.text isEqualToString:@"Fresh"]) {
              
                selectTF1.placeholder = @"Select Age";
                selectTF1.text = @"";
                
                selectTF2.hidden = YES;
                selectTF3.hidden = YES;
                selectTF4.hidden = YES;
                selectTF5.hidden = YES;
                submitBtnTopConstraint.constant = 80;
                
                
            }
      
            else if ([selectServiceTypeTF.text isEqualToString:@"Reissue"]){
                selectTF2.hidden = NO;
                selectTF3.hidden = NO;
                selectTF4.hidden = NO;
                selectTF5.hidden = NO;
                submitBtnTopConstraint.constant = 310;
            } else {
              
            }
        
    } else if (textField == selectTF1){
        
         if([selectTF1.text isEqualToString:@"Less Than 15 Years"]){
            
            selectTF2.placeholder = @"Select Scheme type";
            selectTF2.text = @"";
            
            selectTF2.hidden = NO;
            
            selectTF3.hidden = YES;
            selectTF4.hidden = YES;
            selectTF5.hidden = YES;
            submitBtnTopConstraint.constant = 140;
        }
        if([selectTF1.text isEqualToString:@"Between 15-18 Years"]){
            
            selectTF2.isOptionalDropDown = NO;
            [selectTF2 setItemList:[NSArray arrayWithObjects:@"5 Years/Till the age of 18 years",@"10 Years", nil]];
            
            selectTF2.placeholder = @"Select required validity";
            selectTF2.text = @"";
            
            selectTF2.hidden = NO;
            
            selectTF3.showDismissToolbar = YES;
            selectTF3.isOptionalDropDown = NO;
             [selectTF3 setItemList:[NSArray arrayWithObjects:@"Normal",@"Tatkaal", nil]];
            selectTF3.placeholder = @"Select scheme type";
            selectTF3.text = @"";
            
            selectTF3.hidden = NO;
            selectTF4.hidden = YES;
            selectTF5.hidden = YES;
            submitBtnTopConstraint.constant = 190;
        }
        if([selectTF1.text isEqualToString:@"18 Years And Above"]){
            
            selectTF2.isOptionalDropDown = NO;
            [selectTF2 setItemList:[NSArray arrayWithObjects:@"36 Pages",@"60 Pages", nil]];
            
            selectTF2.placeholder = @"Select Booklet Type";
            selectTF2.text = @"";
            
            selectTF2.hidden = NO;
            
            selectTF3.showDismissToolbar = YES;
            selectTF3.isOptionalDropDown = NO;
            [selectTF3 setItemList:[NSArray arrayWithObjects:@"Normal",@"Tatkaal", nil]];
            selectTF3.placeholder = @"Select scheme type";
            selectTF3.text = @"";
            
            selectTF3.hidden = NO;
            selectTF4.hidden = YES;
            selectTF5.hidden = YES;
            submitBtnTopConstraint.constant = 190;
        }
       // selectDocLocationDropIcon.highlighted = NO;
       
    }
    else if (textField == selectTF2){
        
        if([selectTF2.text isEqualToString:@"Normal"]){
            
            
            selectTF3.hidden = YES;
            selectTF4.hidden = YES;
            selectTF5.hidden = YES;
            submitBtnTopConstraint.constant = 140;
        }
        else  if([selectTF2.text isEqualToString:@"5 Years/Till the age of 18 years"]){
            
            
            selectTF3.showDismissToolbar = YES;
            selectTF3.isOptionalDropDown = NO;
            [selectTF3 setItemList:[NSArray arrayWithObjects:@"Normal",@"Tatkaal", nil]];
            selectTF3.placeholder = @"Select scheme type";
            selectTF3.text = @"";
            
            selectTF3.hidden = NO;
            
            selectTF4.hidden = YES;
            selectTF5.hidden = YES;
            submitBtnTopConstraint.constant = 190;
        }
        else  if([selectTF2.text isEqualToString:@"10 Years"]){
            
            selectTF3.showDismissToolbar = YES;
            selectTF3.isOptionalDropDown = NO;
            [selectTF3 setItemList:[NSArray arrayWithObjects:@"36 Pages",@"60 Pages", nil]];
            selectTF3.placeholder = @"Select Booklet Type";
            selectTF3.text = @"";
            
            selectTF3.hidden = NO;
            
            
            selectTF4.showDismissToolbar = YES;
            selectTF4.isOptionalDropDown = NO;
            [selectTF4 setItemList:[NSArray arrayWithObjects:@"Normal",@"Tatkaal", nil]];
            selectTF4.placeholder = @"Select scheme type";
            selectTF4.text = @"";
            
            selectTF4.hidden = NO;
            
            selectTF5.hidden = YES;
            submitBtnTopConstraint.constant = 250;
        }
        
        // selectDocLocationDropIcon.highlighted = NO;
        
    }
    
    /*if (textField == selectServiceTypeTF) {
     
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
     }*/
    
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
