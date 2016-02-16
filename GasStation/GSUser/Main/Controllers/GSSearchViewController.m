//
//  GSSearchViewController.m
//  GasStation
//
//  Created by vedon on 2/12/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSSearchViewController.h"
#import "PureLayout.h"
#import "GSSearchRCTableViewCell.h"
#import "GSSearchLocationTableViewCell.h"
#import "GSStaionDetailViewController.h"
#import "GSSearchResultMacro.h"

static NSString *rcCellIdentifier = @"rcCellIdentifier";
static NSString *locationCellIdentifier = @"locationCellIdentifier";

@interface GSSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *contentTable;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic,strong) UIView *maskView;
@end

@implementation GSSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    UINib *rcCell = [UINib nibWithNibName:@"GSSearchRCTableViewCell" bundle:nil];
    [self.contentTable registerNib:rcCell forCellReuseIdentifier:rcCellIdentifier];
    
    UINib *locationCell = [UINib nibWithNibName:@"GSSearchLocationTableViewCell" bundle:nil];
    [self.contentTable registerNib:locationCell forCellReuseIdentifier:locationCellIdentifier];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture & Action

- (void)didTapMaskView
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.contentTable addSubview:self.maskView];
    self.maskView.frame = self.contentTable.bounds;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.maskView removeFromSuperview];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.section)
    {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:rcCellIdentifier];
            GSSearchRCTableViewCell *rcCell = (GSSearchRCTableViewCell *)cell;
            rcCell.contentMainTitle.text = @"加油站";
            rcCell.contentSubTitle.text = @"免费加油";
            rcCell.distanct.text = @"12km";
            break;
        }
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:locationCellIdentifier];
            cell.textLabel.text = @"123";
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
    return kSearchResultCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kSearchResultSectionPadding;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GSStaionDetailViewController *vc = [[GSStaionDetailViewController alloc] initWithNibName:@"GSStaionDetailViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
    nav = nil;
    vc = nil;
}

#pragma mark - Getter && Setter

- (UIView *)maskView
{
    if (!_maskView)
    {
        _maskView = [[UIView alloc] initForAutoLayout];
        _maskView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMaskView)];
        [_maskView addGestureRecognizer:tapGesture];
        tapGesture = nil;

    }
    return _maskView;
}

@end
