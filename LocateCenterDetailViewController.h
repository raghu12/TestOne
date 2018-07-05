//
//  LocateCenterDetailViewController.h
//  GOK
//
//  Created by admin on 05/07/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocateCenterDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    
}
@property(nonatomic,strong) NSArray *trackerStatusDetailsArr;
@property(nonatomic,strong) IBOutlet UITableView *trackerStatusDetailsTableView;

@end
