//
//  MasterViewController.h
//  melanie-hsu
//
//  Created by Melanie Hsu on 7/8/14.
//  Copyright (c) 2014 Melanie Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
