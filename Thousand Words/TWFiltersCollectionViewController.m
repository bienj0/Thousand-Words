//
//  TWFiltersCollectionViewController.m
//  Thousand Words
//
//  Created by Robin van 't Slot on 04-10-14.
//  Copyright (c) 2014 BrickInc. All rights reserved.
//

#import "TWFiltersCollectionViewController.h"
#import "Photo.h"
#import "TWPhotoCollectionViewCell.h"

@interface TWFiltersCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *filters;
@property (strong, nonatomic) CIContext *context;

@end

@implementation TWFiltersCollectionViewController

- (NSMutableArray *)filters
{
    if (!_filters) {
        _filters = [[NSMutableArray alloc] init];
    }
    return _filters;
}

- (CIContext *)context
{
    if (!_context) _context = [CIContext contextWithOptions:nil];
    return _context;
}

//static NSString * const reuseIdentifier = @"Photo Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[TWPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"Photo Cell"];
    self.filters = [[[self class] photoFilters] mutableCopy];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpers

+(NSArray *)photoFilters
{
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:nil];
    
    CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:nil];
    
    CIFilter *colorClamp = [CIFilter filterWithName:@"CIColorClamp" keysAndValues:@"inputMaxComponents", [CIVector vectorWithX:0.9 Y:0.9 Z:0.9 W:0.9], @"inputMinComponents", [CIVector vectorWithX:0.2 Y:0.2 Z:0.2 W:0.2] , nil];
    CIFilter *instant = [CIFilter filterWithName:@"CIPhotoEffectInstant" keysAndValues:nil];
    
    CIFilter *noir = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues:nil];
    
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignetteEffect" keysAndValues:nil];
    
    CIFilter *colorControls = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputSaturationKey, @0.5, nil];
    CIFilter *transfer = [CIFilter filterWithName:@"CIPhotoEffectTransfer" keysAndValues: nil];
    
    CIFilter *unsharpen = [CIFilter filterWithName:@"CIUnsharpMask" keysAndValues:nil];
    
    CIFilter *monochrome = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues: nil];
    
    NSArray *allFilters = @[sepia, blur, colorClamp, instant, noir, vignette, colorControls, transfer, unsharpen, monochrome];
    
    return allFilters;
}

-(UIImage *)filteredImageFromImage:(UIImage *)image andFilter:(CIFilter *)filter
{
    CIImage *unfilteredImage = [[CIImage alloc] initWithCGImage:image.CGImage];
    [filter setValue:unfilteredImage forKey:kCIInputImageKey];
    
    CIImage *filteredImage = [filter outputImage];
    CGRect extent = [filteredImage extent];
    
    CGImageRef cgImage = [self.context createCGImage:filteredImage fromRect:extent];
    
    UIImage *finalImage = [UIImage imageWithCGImage:cgImage];
    
    return finalImage;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return [self.filters count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Photo Cell";
    TWPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    cell.backgroundColor = [UIColor whiteColor];
    
    dispatch_queue_t filterQueue = dispatch_queue_create("filter queue", NULL);
    dispatch_async(filterQueue, ^{
        UIImage *filterImage = [self filteredImageFromImage:self.photo.image andFilter:self.filters[indexPath.row]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = filterImage;
        });
    });
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TWPhotoCollectionViewCell *selectedCell = (TWPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    self.photo.image = selectedCell.imageView.image;
    
    if(self.photo.image){
        
        NSError *error = nil;
        if (![[self.photo managedObjectContext] save:&error]){
            //handle error
            NSLog(@"%@:", error);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */


@end
