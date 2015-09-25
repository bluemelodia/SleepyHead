//
//  DetailViewController.h
//  melanie-hsu
//
//  Created by Melanie Hsu on 7/8/14.
//  Copyright (c) 2014 Melanie Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
