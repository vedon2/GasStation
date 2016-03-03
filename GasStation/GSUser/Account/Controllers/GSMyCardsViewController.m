//
//  GSMyCardsViewController.m
//  GasStation
//
//  Created by vedon on 2/16/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSMyCardsViewController.h"
#import "BlocksKit+UIKit.h"
#import "GSMyCardTableViewCell.h"
#import "GSMyCardDataProtocol.h"
#import "GSMyCardData.h"

static NSString *cellIdentifier = @"cell";

@interface GSMyCardsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *contentTable;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) BOOL isUse;
@end

@implementation GSMyCardsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isAlreadyUser:(BOOL)isUse
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.isUse = isUse;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UINib *nib = [UINib nibWithNibName:@"GSMyCardTableViewCell" bundle:nil];
    [self.contentTable registerNib:nib forCellReuseIdentifier:cellIdentifier];
    
    self.dataSource = [NSMutableArray array];
    for (int i = 0; i<10; i++)
    {
        GSMyCardData *data = [[GSMyCardData alloc] init];
        data.isUse = self.isUse;
        [self.dataSource addObject:data];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
}

- (NSString *)title
{
    return @"我的加油卡";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GSMyCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    GSMyCardData *data = [self.dataSource objectAtIndex:indexPath.row];
    [cell configureWithData:data];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
