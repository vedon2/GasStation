//
//  GSStaionDetailViewController.m
//  GasStation
//
//  Created by vedon on 2/12/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSStaionDetailViewController.h"

#import "GSStationDetailDesTableViewCell.h"
#import "GSGasPriceTableViewCell.h"
#import "GSSubstractCouponTableViewCell.h"
#import "GSGiftCouponTableViewCell.h"
#import "GSStationShortCommentsTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "GSCommentsListViewController.h"
#import "BlocksKit+UIKit.h"

@interface GSStaionDetailViewController ()<UITableViewDelegate,UITableViewDataSource,GSStationShortCommentsTableViewCellDelegate>
@property (nonatomic,strong) NSMutableDictionary *cellsHeight;
@property (weak, nonatomic) IBOutlet UITableView *contentTable;
@end

@implementation GSStaionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCells];
    self.contentTable.fd_debugLogEnabled = YES;
    
    self.contentTable.backgroundColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"分享" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        //TODO:share
        
    }];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture & Action

#pragma mark - Private

- (void)registerCells
{
    self.cellsHeight = [[NSMutableDictionary alloc] init];
    
    UINib *cellNib = [UINib nibWithNibName:@"GSStationDetailDesTableViewCell" bundle:nil];
    [self.contentTable registerNib:cellNib forCellReuseIdentifier:[GSStationDetailDesTableViewCell cellIdentifier]];
    
    cellNib = [UINib nibWithNibName:@"GSGasPriceTableViewCell" bundle:nil];
    [self.contentTable registerNib:cellNib forCellReuseIdentifier:[GSGasPriceTableViewCell cellIdentifier]];
    
    cellNib = [UINib nibWithNibName:@"GSSubstractCouponTableViewCell" bundle:nil];
    [self.contentTable registerNib:cellNib forCellReuseIdentifier:[GSSubstractCouponTableViewCell cellIdentifier]];
    
    cellNib = [UINib nibWithNibName:@"GSGiftCouponTableViewCell" bundle:nil];
    [self.contentTable registerNib:cellNib forCellReuseIdentifier:[GSGiftCouponTableViewCell cellIdentifier]];
    
    cellNib = [UINib nibWithNibName:@"GSStationShortCommentsTableViewCell" bundle:nil];
    [self.contentTable registerNib:cellNib forCellReuseIdentifier:[GSStationShortCommentsTableViewCell cellIdentifier]];
}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    switch (indexPath.section)
    {
        case 0:
            cellIdentifier = [GSStationDetailDesTableViewCell cellIdentifier];
            break;
        case 1:
            cellIdentifier = [GSGasPriceTableViewCell cellIdentifier];
            break;
        case 2:
            cellIdentifier = [GSSubstractCouponTableViewCell cellIdentifier];
            break;
        case 3:
            cellIdentifier = [GSStationShortCommentsTableViewCell cellIdentifier];
            break;
        default:
            break;
    }
    return cellIdentifier;
}

- (void)pushCommentsListViewController
{
    GSCommentsListViewController *vc = [[GSCommentsListViewController alloc] initWithNibName:@"GSCommentsListViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    vc = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 1;
    switch (section)
    {
        case 2:
            rows = 1;
            break;
            
        default:
            break;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
   
    switch (indexPath.section)
    {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[GSStationDetailDesTableViewCell cellIdentifier]];
            break;
        }
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[GSGasPriceTableViewCell cellIdentifier]];
            break;
        }
        case 2:
        {
            //TODO: 更具类型，返回不一样的cell
            cell = [tableView dequeueReusableCellWithIdentifier:[GSSubstractCouponTableViewCell cellIdentifier]];
            break;
        }
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:[GSStationShortCommentsTableViewCell cellIdentifier]];
            GSStationShortCommentsTableViewCell *tempCell = (GSStationShortCommentsTableViewCell *)cell;
            tempCell.delegate = self;
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [self cellIdentifierForIndexPath:indexPath];
    assert(cellIdentifier);

    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        
        //TODO: 数据源
        if ([cell conformsToProtocol:@protocol(GSSearchResultCellProtocol)])
        {
            [cell configureWithData:@""];
        }
        else
        {
            assert(0);
        }
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

#pragma mark - GSStationShortCommentsTableViewCellDelegate

- (void)didTapMoreCommentCell
{
    [self pushCommentsListViewController];
}

#pragma mark - Getter & Setter
@end
