//
//  LocateCenterDetailViewController.m
//  GOK
//
//  Created by admin on 05/07/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#import "LocateCenterDetailViewController.h"
#import "LocateCenterDetailTableViewCell.h"

@interface LocateCenterDetailViewController ()
{
    
}
@end

@implementation LocateCenterDetailViewController
@synthesize trackerStatusDetailsArr,trackerStatusDetailsTableView,responseArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //trackerStatusDetailsArr = [[NSMutableArray alloc]initWithObjects:@"File Number: BN1073545646354",@"Name: SIVARAMA",@"Date of Birth: 28-03-1958", @"Type of Application: Tatkaal",@"Application Received Date: 2011-09-29",@"Status: Passport J9316548 has been dispatched on 30/09/2011 via Speed EK20418349IN", nil];
    
    trackerStatusDetailsArr = @[languageForKey(@"tsd"), languageForKey(@"filenumber"),languageForKey(@"name"),languageForKey(@"dob"),languageForKey(@"typeofapplication"), languageForKey(@"applicationreceiveddate"), languageForKey(@"status")];
    
    
    self.trackerStatusDetailsTableView.rowHeight = UITableViewAutomaticDimension;
    self.trackerStatusDetailsTableView.estimatedRowHeight = 44.0;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [trackerStatusDetailsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TrackerStatusItem";
    
    LocateCenterDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"LocateCenterDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"TrackerStatusItem"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TrackerStatusItem"];
        
    }
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//    }
//
   // cell.detailLabel.text = [trackerStatusDetailsArr objectAtIndex:indexPath.row];
    
    NSString *hintText = trackerStatusDetailsArr[indexPath.row];
 
    UIColor *attrTextColor = ((indexPath.row == 1) ? RED_TEXT_COLOR : ((indexPath.row == 2) ? RED_TEXT_COLOR :  DARK_GRAY_COLOR));
  //  START_MAIN_THREAD
    
    if(indexPath.row==0){
           cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 0) ? APP_THEME_BLUE_COLOR : DARK_GRAY_COLOR) withColon:@"" withAtrributedString:@"" attributedColor:attrTextColor];
    }else if(indexPath.row==1){
    cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 1) ? DARK_GRAY_COLOR : DARK_GRAY_COLOR) withColon:@":" withAtrributedString:[responseArray valueForKey:@"fileno"] attributedColor:attrTextColor];
    }
    else if(indexPath.row==2){
         cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 1) ? DARK_GRAY_COLOR : DARK_GRAY_COLOR) withColon:@":" withAtrributedString:[responseArray valueForKey:@"name"] attributedColor:attrTextColor];
    }
    else if (indexPath.row==3){
         cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 1) ? DARK_GRAY_COLOR : DARK_GRAY_COLOR) withColon:@":" withAtrributedString:[responseArray valueForKey:@"dob"] attributedColor:attrTextColor];
    }
    else if (indexPath.row ==4){
         cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 1) ? DARK_GRAY_COLOR : DARK_GRAY_COLOR) withColon:@":" withAtrributedString:[responseArray valueForKey:@"type"] attributedColor:attrTextColor];
    }
    else if(indexPath.row ==5){
         cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 1) ? DARK_GRAY_COLOR : DARK_GRAY_COLOR) withColon:@":" withAtrributedString:[responseArray valueForKey:@"submissiondate"] attributedColor:attrTextColor];
    }
    else if (indexPath.row ==6){
        cell.detailLabel.attributedText = [Utils withPlainString:hintText plainColor:((indexPath.row == 1) ? DARK_GRAY_COLOR : DARK_GRAY_COLOR) withColon:@":" withAtrributedString:[responseArray valueForKey:@"status"] attributedColor:attrTextColor];
    }
  //  END_THREAD
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    return UITableViewAutomaticDimension;
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
