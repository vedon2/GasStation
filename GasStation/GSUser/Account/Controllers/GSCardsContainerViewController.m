//
//  GSCardsContainerViewController.m
//  GasStation
//
//  Created by vedon on 2/21/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSCardsContainerViewController.h"
#import "GSCardsSelectView.h"
#import "PureLayout.h"
#import "GSCardsSelectViewItemInfo.h"
#import "GSColor.h"
#import "BlocksKit+UIKit.h"
#import "GSMyCardsViewController.h"


@interface GSCardsContainerViewController ()<GSCardsSelectViewProtocol>
@property (nonatomic,strong) GSCardsSelectView *cardSelectView;
@property (nonatomic,strong) UIScrollView *contentContainerView;
@end

@implementation GSCardsContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setupContent];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)setupContent
{
    if (self.cardSelectView == nil)
    {
        NSMutableArray *itemsInfo = [NSMutableArray array];
        for (int i = 0; i < 2; i++)
        {
            switch (i) {
                case 0:
                {
                    GSCardsSelectViewItemInfo *itemInfo = [[GSCardsSelectViewItemInfo alloc] initWithTitle:@"未使用" selectedColor:[GSColor mainColor] normalColor:[GSColor registerPhoneTextFieldColor]];
                    [itemsInfo addObject:itemInfo];
                }
                    break;
                case 1:
                {
                    GSCardsSelectViewItemInfo *itemInfo = [[GSCardsSelectViewItemInfo alloc] initWithTitle:@"已使用" selectedColor:[GSColor mainColor] normalColor:[GSColor registerPhoneTextFieldColor]];
                    [itemsInfo addObject:itemInfo];
                }
                    break;
                default:
                    break;
            }
        }
        self.cardSelectView = [[GSCardsSelectView alloc] initWithDelegate:self numberOfButtons:itemsInfo selectedIndex:0];
        [self.view addSubview:self.cardSelectView];
        [self.cardSelectView autoSetDimensionsToSize:CGSizeMake(self.view.frame.size.width, 44)];
        [self.cardSelectView autoPinToTopLayoutGuideOfViewController:self withInset:0];
        [self.cardSelectView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
        [self.cardSelectView setNeedsLayout];
        [self.cardSelectView layoutIfNeeded];
        [self.cardSelectView setBackgroundColor:[UIColor whiteColor]];
        [self.cardSelectView initialize];
        
        [self.view addSubview:self.contentContainerView];
        [self.contentContainerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.cardSelectView];
        [self.contentContainerView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
        [self.contentContainerView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view];
        [self.contentContainerView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
        
        
        [self.contentContainerView setNeedsLayout];
        [self.contentContainerView layoutIfNeeded];
        GSMyCardsViewController *tempVc = nil;
        NSInteger numberOfController = 2;
        for (int i = 0; i <numberOfController; i++)
        {
            GSMyCardsViewController *vc = [[GSMyCardsViewController alloc] initWithNibName:@"GSMyCardsViewController" bundle:nil];
            [self.contentContainerView addSubview:vc.view];
            [vc.view autoPinEdge:ALEdgeLeft toEdge:(tempVc != nil?ALEdgeRight:ALEdgeLeft) ofView:(tempVc != nil?tempVc.view:self.contentContainerView)];
            [vc.view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentContainerView];
            [vc.view autoSetDimensionsToSize:self.contentContainerView.frame.size];
            if (i == numberOfController - 1)
            {
                [vc.view autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentContainerView];
            }
        
            tempVc = vc;
        }
        
    }
    
    
}

#pragma mark - GSCardsSelectViewProtocol

- (void)cardView:(GSCardsSelectView *)cardsView didSelectIndex:(NSUInteger)index
{
    
}


#pragma mark - Getter & Setter 

- (UIScrollView *)contentContainerView
{
    if (!_contentContainerView)
    {
        _contentContainerView = [[UIScrollView alloc] initForAutoLayout];
        _contentContainerView.pagingEnabled = YES;
        _contentContainerView.backgroundColor = [UIColor clearColor];
    
    }
    return _contentContainerView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
