//
//  TWPictureDataTransformer.m
//  Thousand Words
//
//  Created by Robin van 't Slot on 03-10-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import "TWPictureDataTransformer.h"
#import <UIKit/UIKit.h>

@implementation TWPictureDataTransformer

+(Class)transformedValueClass
{
    return [NSData class];
}

+(BOOL)allowsReverseTransformation
{
    return YES;
}

-(id)transformedValue:(id)value
{
    return UIImagePNGRepresentation(value);
}

-(id)reverseTransformedValue:(id)value
{
    UIImage *image = [UIImage imageWithData:value];
    return image;
}

@end
