//
//  GSUserCenterViewController.m
//  GasStation
//
//  Created by vedon on 2/15/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUserCenterViewController.h"
#import "GSUserCenterCollectionViewCell.h"
#import "BlocksKit+UIKit.h"
#import "GSChangePasswordViewController.h"
#import "GSMyCardsViewController.h"
#import "GSAbouViewController.h"
#import "GSFeedbackViewController.h"

static NSString *cellIdentifier = @"Cell";

@interface GSUserCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (assign,nonatomic) CGFloat collectionCellPadding;

@end

@implementation GSUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    NSInteger width = floor(self.view.frame.size.width/3);
    self.collectionCellPadding =  self.view.frame.size.width - 3 * width;
    layout.itemSize =CGSizeMake(width, width);
    self.collectionView.collectionViewLayout = layout;
    UINib *collectivewCellNib = [UINib nibWithNibName:@"GSUserCenterCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:collectivewCellNib forCellWithReuseIdentifier:cellIdentifier];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"返回" style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)dealloc
{
    NSLog(@"Dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.collectionCellPadding/3;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.collectionCellPadding/3;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.item) {
        case 0:
        {
             GSMyCardsViewController *vc = [[GSMyCardsViewController alloc] initWithNibName:@"GSMyCardsViewController" bundle:nil];
#ifdef kUserDragableAnimation
            vc.modalPresentationStyle = UIModalPresentationCustom;
            self.defaultPrensentAnimation = [GSPrensentViewControllerTransition defaultTransitionWithViewController:vc];
            vc.transitioningDelegate = self.defaultPrensentAnimation;
            [self presentViewController:vc animated:YES completion:nil];
#else
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            nav = nil;
#endif
        
            vc = nil;
        }
            break;
        case 1:
        {
            GSChangePasswordViewController *vc = [[GSChangePasswordViewController alloc] initWithNibName:@"GSChangePasswordViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            vc = nil;
        }
            break;
        case 2:
        {
            GSFeedbackViewController *vc = [[GSFeedbackViewController alloc] initWithNibName:@"GSFeedbackViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            vc = nil;
        }
            break;
        case 3:
        {
            GSAbouViewController *vc = [[GSAbouViewController alloc] initWithNibName:@"GSAbouViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            vc = nil;
        }
            break;
        default:
            break;
    }
}


@end
