//
//  StatusTrackerViewController.m
//  GOK
//
//  Created by admin on 05/07/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#import "StatusTrackerViewController.h"
#import "LocateCenterDetailViewController.h"

@interface StatusTrackerViewController ()
{
    __weak IBOutlet IQDropDownTextField *dOfConvictionTF;
        NSDateFormatter *dateFormatter;
     __weak IBOutlet IQDropDownTextField *dateTF;
     __weak IBOutlet IQDropDownTextField *monthTF;
     __weak IBOutlet IQDropDownTextField *yearTF;
    
    __weak IBOutlet UITextField *fileNumberTF;
    
    NSString *dom;
    
    NSArray *statusResponseArray;
}
@end

@implementation StatusTrackerViewController
- (IBAction)onClickofGetStatusSubmitButton:(id)sender {
    
    [self getSourceDestinationArrayFromAPI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
     [self setDateOfBirthMinAndMaxDates];
}

-(void) getSourceDestinationArrayFromAPI {
    
      TCSTART
    
    if (![Utils isEmptyValue:fileNumberTF.text] && ![Utils isEmptyValue:dateTF.text] && ![Utils isEmptyValue:monthTF.text] && ![Utils isEmptyValue:yearTF.text]) {
        
        NSString *fileNumberStr= [fileNumberTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//        NSDictionary *params = @{@"deptname":@"passport", @"channel": @"IOS", @"servicecode": @"1", @"mobileno":[UserDefaults getUserMobile], @"fileno": fileNumberStr, @"dobday":dateTF.text, @"dobmonth":monthTF.text,@"dobyear":yearTF.text};

          NSDictionary *params = @{@"deptname":@"passport", @"channel": @"IOS", @"servicecode": @"1", @"mobileno":@"9480497796", @"fileno": fileNumberStr, @"dobday":dateTF.text, @"dobmonth":monthTF.text,@"dobyear":yearTF.text};
        
        [self commonServiceCall:params completionBlock:^(id response, int code) {
            if (code == 0) {
                if (![Utils isEmptyValue:response]) {
                    statusResponseArray =[response valueForKey:@"item"];
                    if (statusResponseArray.count > 0) {
                        
                        LocateCenterDetailViewController * locateCenterDetailVC = [[LocateCenterDetailViewController alloc]initWithNibName:@"LocateCenterDetailViewController" bundle:nil];
                        locateCenterDetailVC.responseArray = statusResponseArray;
                        
                        [self.navigationController pushViewController:locateCenterDetailVC animated:YES];
                        
//                        sourceTF.itemList = [sourceDestinationArray valueForKey:@"name"];
//                        destinationTF.itemList = [sourceDestinationArray valueForKey:@"name"];
//                        [sourceTF reloadInputViews];
//                        [destinationTF reloadInputViews];
                    }
                } else { [Utils showErrorToastMessage:response]; }
            } else { [Utils showErrorToastMessage:response]; }
        }];
    }

    TCEND
}

-(void) setDateOfBirthMinAndMaxDates {
    TCSTART
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:-AGE_100_YEARS_BACK];
    NSDate *minDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    NSDateComponents *comps1 = [[NSDateComponents alloc] init];
    if ([[[Utils getPrefixCharacterFrom:dOfConvictionTF.text] uppercaseString] isEqualToString:@"L"]) {
        [comps1 setYear:-AGE_20_AND_ABOVE];
    } else {
        [comps1 setYear:-AGE_16_AND_ABOVE];
    }
    NSDate *maxDate = [gregorian dateByAddingComponents:comps1 toDate:currentDate  options:0];
    
    dOfConvictionTF.dropDownMode = IQDropDownModeDatePicker;
    dOfConvictionTF.dropDownDateTimeFormater = dateFormatter;
    dOfConvictionTF.minimumDate = minDate;
    dOfConvictionTF.maximumDate = maxDate;
    TCEND
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    TCSTART
    if (textField == dOfConvictionTF) { //if ((textField == dateTF) || (textField == monthTF) || (textField == yearTF)) {
        
        NSString *dob = textField.text;
        
        NSString *format  = ([textField.text containsString:@"-"]) ? @"dd-MMM-yyyy" : @"MMM dd, yyyy";
        
        dateTF.text = [Utils getdateMonthYear:dob :format :@"dd"];
        monthTF.text = [Utils getdateMonthYear:dob :format :@"MM"];
        yearTF.text = [Utils getdateMonthYear:dob :format :@"yyyy"];
        dom = [NSString stringWithFormat:@"%@-%@-%@", dateTF.text, [Utils getdateMonthYear:textField.text :format :@"MM"], yearTF.text];
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
