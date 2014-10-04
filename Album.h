//
//  Album.h
//  Thousand Words
//
//  Created by Robin van 't Slot on 03-10-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSSet *photos;
@end

@interface Album (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end
