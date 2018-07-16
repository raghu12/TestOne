//
//  PropertyTaxPaymentDetailViewController.m
//  GOK
//
//  Created by admin on 11/07/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#import "PropertyTaxPaymentDetailViewController.h"

@interface PropertyTaxPaymentDetailViewController ()
{
   // NSArray *detailResponseArray;
    NSArray *paymentDetailsAllKeysArr;
    //UIElements
    __weak IBOutlet UITextField *curptAmountTF;
    __weak IBOutlet UITextField *totalAmountTF;
    __weak IBOutlet UITableView *tableViewPTPayment;
    __weak IBOutlet UIButton *calculateButton;
    __weak IBOutlet UIButton *payButton;
}
@end

@implementation PropertyTaxPaymentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    TCSTART
    
    
    curptAmountTF.placeholder = languageForKey(@"entercurptamount");
    [calculateButton setTitle:languageForKey(@"calculate") forState:UIControlStateNormal];
    totalAmountTF.placeholder = languageForKey(@"amount");
    [payButton setTitle:languageForKey(@"pay") forState:UIControlStateNormal];
    
    paymentDetailsAllKeysArr = @[languageForKey(@"hublidharwadptaxpayment"),languageForKey(@"propertytaxamount"),languageForKey(@"pidno"), languageForKey(@"streetid"),languageForKey(@"swm"),languageForKey(@"urbantransportcess"),languageForKey(@"wardname"), languageForKey(@"serialno")];
    
        [tableViewPTPayment registerNib:[UINib nibWithNibName:NSStringFromClass([ECDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ECDetailTableViewCell class])];
    tableViewPTPayment.tableFooterView = [UIView new];
    tableViewPTPayment.separatorInset = TABLE_VIEW_SEPARATOR_INSET;

    
    TCEND
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    TCSTART
    if(![Utils isEmptyValue:_responseDict])
    {
        if ([[_responseDict valueForKey:@"item"] isKindOfClass:[NSDictionary class]]) {
            _ptPaymentDetailArr = @[[_responseDict valueForKey:@"item"]];
        } else {
            _ptPaymentDetailArr = [_responseDict valueForKey:@"item"];
        }
        
        [tableViewPTPayment setDelegate:self];
        [tableViewPTPayment setDataSource:self];
        [tableViewPTPayment reloadData];
        
    }
    TCEND
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [paymentDetailsAllKeysArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ECDetailTableViewCell * cell = (ECDetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ECDetailTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[ECDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ECDetailTableViewCell class])];;
    }

    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    NSString *hintText = paymentDetailsAllKeysArr[indexPath.row];
    
    UIColor *attrTextColor = DARK_GRAY_COLOR;
    // START_MAIN_THREAD
    if(indexPath.row==0){
        cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 0) ? APP_THEME_BLUE_COLOR : DARK_GRAY_COLOR) withColon:@"" withAtrributedString:@"" attributedColor:attrTextColor];
    }else if(indexPath.row==1){
        cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 1) ? DARK_GRAY_COLOR : DARK_GRAY_COLOR) withColon:@":" withAtrributedString: (([_ptPaymentDetailArr[0] objectForKey:@"curptamount"] != nil) ? [_ptPaymentDetailArr[0] valueForKey:@"curptamount"] :@"") attributedColor:attrTextColor];
    }
    else if(indexPath.row==2){
        cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 1) ? DARK_GRAY_COLOR : DARK_GRAY_COLOR) withColon:@":" withAtrributedString: (([_ptPaymentDetailArr[0] objectForKey:@"pid"] != nil) ? [_ptPaymentDetailArr[0] valueForKey:@"pid"] :@"") attributedColor:attrTextColor];
    }
    else if (indexPath.row==3){
        cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 1) ? DARK_GRAY_COLOR : DARK_GRAY_COLOR) withColon:@":" withAtrributedString: (([_ptPaymentDetailArr[0] objectForKey:@"streetid"] != nil) ? [_ptPaymentDetailArr[0] valueForKey:@"streetid"] :@"") attributedColor:attrTextColor];
    }
    else if (indexPath.row ==4){
        cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 1) ? DARK_GRAY_COLOR : DARK_GRAY_COLOR) withColon:@":" withAtrributedString: (([_ptPaymentDetailArr[0] objectForKey:@"curswm"] != nil) ? [_ptPaymentDetailArr[0] valueForKey:@"curswm"] :@"") attributedColor:attrTextColor];
    }
    else if(indexPath.row ==5){
            cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 1) ? DARK_GRAY_COLOR : DARK_GRAY_COLOR) withColon:@":" withAtrributedString: (([_ptPaymentDetailArr[0] objectForKey:@"utcess"] != nil) ? [_ptPaymentDetailArr[0] valueForKey:@"utcess"] :@"") attributedColor:attrTextColor];
    
    }
    else if (indexPath.row ==6){

            cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 1) ? DARK_GRAY_COLOR : DARK_GRAY_COLOR) withColon:@":" withAtrributedString: (([_ptPaymentDetailArr[0] objectForKey:@"wardname"] != nil) ? [_ptPaymentDetailArr[0] valueForKey:@"wardname"] :@"") attributedColor:attrTextColor];
        
    }
    else if (indexPath.row ==7){
            cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 1) ? DARK_GRAY_COLOR : DARK_GRAY_COLOR) withColon:@":" withAtrributedString: (([_ptPaymentDetailArr[0] objectForKey:@"slno"] != nil) ? [_ptPaymentDetailArr[0] valueForKey:@"slno"] :@"") attributedColor:attrTextColor];
    }

    
    //END_THREAD
    
    return cell;
    
}
-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

#pragma mark -  Button Actions
- (IBAction)calculateButton:(id)sender { //onClickOfCalculateButton
    if(![Utils isEmptyValue:curptAmountTF.text]){
        
        NSString *ptAmountStr = [_ptPaymentDetailArr[0] valueForKey:@"curptamount"];
        NSInteger ptAmountInt =  [ptAmountStr integerValue];
        
        
        NSInteger curptAmountInt =  [curptAmountTF.text integerValue];
        
        NSInteger totalAMount = ptAmountInt + curptAmountInt;
        totalAmountTF.text = [NSString stringWithFormat:@"%@ : %ld",languageForKey(@"amount"),(long)totalAMount];
    }else{
        [Utils showErrorToastMessage:@{@"desc":languageForKey(@"entercurptamount")}];
    }
}

- (IBAction)payButton:(id)sender {
    TCSTART
    if([Utils isEmptyValue:totalAmountTF.text]){
        [Utils showErrorToastMessage:@{@"desc":languageForKey(@"payableamountshouldnotbeempty")}];
    }
    TCEND
}

#pragma mark - UITextField
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString {
    
    if (textField == curptAmountTF) {
        TCSTART
        NSCharacterSet *cs  = [[NSCharacterSet characterSetWithCharactersInString:ONLY_DIGITS] invertedSet];
        NSString *filtered = [[replacementString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        if ([replacementString isEqualToString:filtered]) {
            NSString *resultText = [textField.text stringByReplacingCharactersInRange:range withString:replacementString];
            return resultText.length <= 12;
        } else {
            return NO;
        }
        TCEND
    }
}


@end
