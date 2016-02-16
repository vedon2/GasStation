//
//  GSCommentsListViewController.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSCommentsListViewController.h"
#import "PureLayout.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "GSCommentTableViewCell.h"
#import "BlocksKit+UIKit.h"
#import "GSPostCommentViewController.h"

@interface GSCommentsListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *contentTable;
@end

@implementation GSCommentsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.contentTable];
    [self.contentTable autoPinEdgesToSuperviewEdges];
    
    UINib *cellNib = [UINib nibWithNibName:@"GSCommentTableViewCell" bundle:nil];
    [self.contentTable registerNib:cellNib forCellReuseIdentifier:[GSCommentTableViewCell cellIdentifier]];
    
    __weak GSCommentsListViewController *weakSelf = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"点评" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        GSPostCommentViewController *vc = [[GSPostCommentViewController alloc] initWithNibName:@"GSPostCommentViewController" bundle:nil];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        vc = nil;
        
        //TODO:share
        
    }];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:[GSCommentTableViewCell cellIdentifier]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [GSCommentTableViewCell cellIdentifier];
    assert(cellIdentifier);
    
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        
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
    
}

#pragma mark - Getter & Setter

- (UITableView *)contentTable
{
    if (!_contentTable)
    {
        _contentTable = [[UITableView alloc] initForAutoLayout];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
    }
    return _contentTable;
}
@end
