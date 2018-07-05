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
    __weak IBOutlet IQDropDownTextField *selectAgeTF;
    __weak IBOutlet IQDropDownTextField *selectRequiredValidityTF;
    __weak IBOutlet IQDropDownTextField *selectBookletTypeTF;
    __weak IBOutlet IQDropDownTextField *selectSchemeTypeTF;
    __weak IBOutlet IQDropDownTextField *selectApplicationTypeTF;
    
    __weak IBOutlet UIButton *submitButton;
    
    
    __weak IBOutlet UILabel *feeAmountTitleLabel;
    __weak IBOutlet UILabel *feeAmountLabel;
    
    NSArray *passportServiceTypesArray;
    __weak IBOutlet NSLayoutConstraint *selectReasonTF;
}
@end

@implementation FeeCalculatorViewController
- (IBAction)submitButton:(id)sender {
    
    if(![selectAgeTF isHidden]){
        selectAgeTF.hidden = YES;
        selectReasonTF.constant=10;
    }
    else{
         selectAgeTF.hidden = NO;
         selectReasonTF.constant=70;
    }
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
