//
//  TWPhotosCollectionViewController.h
//  Thousand Words
//
//  Created by Robin van 't Slot on 03-10-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface TWPhotosCollectionViewController : UICollectionViewController

@property (strong, nonatomic) Album *album;

- (IBAction)cameraBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
