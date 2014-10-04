//
//  TWAlbumTableViewController.h
//  Thousand Words
//
//  Created by Robin van 't Slot on 02-10-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWAlbumTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *albums;

- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
