//
//  TWPhotoDetailViewController.h
//  Thousand Words
//
//  Created by Robin van 't Slot on 03-10-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface TWPhotoDetailViewController : UIViewController

@property (strong, nonatomic) Photo *photo;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)addFilterButtonPressed:(UIButton *)sender;
- (IBAction)deleteButtonPressed:(UIButton *)sender;

@end
