//
//  PropertyTaxPaymentDetailViewController.h
//  GOK
//
//  Created by admin on 11/07/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyTaxPaymentDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSString *appaction, *deptname, *serviceTitle, *subdeptname;
@property (strong, nonatomic) NSDictionary *responseDict;
@property (nonatomic,strong) NSArray *ptPaymentDetailArr;
@end
