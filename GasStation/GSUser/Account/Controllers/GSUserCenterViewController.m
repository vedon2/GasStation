//
//  GSUserCenterViewController.m
//  GasStation
//
//  Created by vedon on 2/15/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kCollectionItemsNumber 4

#import "GSUserCenterViewController.h"
#import "GSUserCenterCollectionViewCell.h"
#import "BlocksKit+UIKit.h"
#import "GSChangePasswordViewController.h"
#import "GSCardsContainerViewController.h"
#import "GSAbouViewController.h"
#import "GSFeedbackViewController.h"
#import "CRNavigationController.h"
#import "GSColor.h"
#import "GSUserCenterCollectionItemInfo.h"

static NSString *cellIdentifier = @"Cell";

@interface GSUserCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarBgImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSMutableArray *collectionItems;
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
    self.collectionView.backgroundColor = [GSColor userCenterBackgroundColor];
    
    self.collectionItems = [NSMutableArray array];
    NSArray *itemsImageNames = @[@"icon_my_card",@"icon_key",@"icon_my_feedback",@"icon_my_we"];
    NSArray *itemsTitles = @[@"我的油卡",@"修改密码",@"反馈投诉",@"关于我们"];
    for (int i =0; i<kCollectionItemsNumber; i++)
    {
        GSUserCenterCollectionItemInfo *info = [[GSUserCenterCollectionItemInfo alloc] init];
        info.imageName = [itemsImageNames objectAtIndex:i];
        info.title = [itemsTitles objectAtIndex:i];
        
        [self.collectionItems addObject:info];
    }
    
//    self.userAvatarImageView.image = [UIImage imageNamed:@"icon_key"];
//    self.userAvatarImageView.contentMode = UIViewContentModeScaleAspectFit;
//    UIImageView *tempImageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    tempImageview.contentMode = UIViewContentModeScaleAspectFit;
//    tempImageview.image = [UIImage imageNamed:@"backgroundStar"];
//    [self.userAvatarBgImageView addSubview:tempImageview];
}

- (void)dealloc
{
    NSLog(@"Dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kCollectionItemsNumber;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GSUserCenterCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    GSUserCenterCollectionItemInfo *info = [self.collectionItems objectAtIndex:indexPath.item];
    UIImage *image = [UIImage imageNamed:info.imageName];
    cell.cellImage.image = image;
    cell.cellTitle.text = info.title;
    
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
    UIViewController *vc = nil;
    switch (indexPath.item) {
        case 0:
        {
            vc = [[GSCardsContainerViewController alloc] initWithNibName:@"GSCardsContainerViewController" bundle:nil];
#ifdef kUserDragableAnimation
            vc.modalPresentationStyle = UIModalPresentationCustom;
            self.defaultPrensentAnimation = [GSPrensentViewControllerTransition defaultTransitionWithViewController:vc];
            vc.transitioningDelegate = self.defaultPrensentAnimation;
            [self presentViewController:vc animated:YES completion:nil];
            
            vc = nil;
#endif
        }
            break;
        case 1:
        {
            vc = [[GSChangePasswordViewController alloc] initWithNibName:@"GSChangePasswordViewController" bundle:nil];
        }
            break;
        case 2:
        {
            vc = [[GSFeedbackViewController alloc] initWithNibName:@"GSFeedbackViewController" bundle:nil];
            
        }
            break;
        case 3:
        {
            vc = [[GSAbouViewController alloc] initWithNibName:@"GSAbouViewController" bundle:nil];
        }
            break;
        default:
            break;
    }
    
    CRNavigationController *nav = [[CRNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    nav = nil;
    vc = nil;
    
}


@end
