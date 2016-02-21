//
//  GSEditUserProfileViewController.m
//  GasStation
//
//  Created by vedon on 2/15/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSEditUserProfileViewController.h"
#import "GSUserAvatarTableViewCell.h"
#import "GSEditUserNameTableViewCell.h"
#import "BlocksKit+UIKit.h"
#import "GSActionSheet.h"


static NSString *userAvatarCellIdentifier = @"userAvatarCellIdentifier";
static NSString *editUserNameCellIdentifier = @"editUserNameCellIdentifier";

@interface GSEditUserProfileViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *contentTable;
@end

@implementation GSEditUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"GSUserAvatarTableViewCell" bundle:nil];
    [self.contentTable registerNib:cellNib forCellReuseIdentifier:userAvatarCellIdentifier];
    
    cellNib = [UINib nibWithNibName:@"GSEditUserNameTableViewCell" bundle:nil];
    [self.contentTable registerNib:cellNib forCellReuseIdentifier:editUserNameCellIdentifier];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 73;
            break;
            
        default:
            return 50;
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:userAvatarCellIdentifier];
            GSUserAvatarTableViewCell *tempCell = (GSUserAvatarTableViewCell *)cell;
            tempCell.avatarImageView.backgroundColor = [UIColor redColor];
            tempCell.avatarImageView.image = nil;
            break;
        }
        default:
            cell = [tableView dequeueReusableCellWithIdentifier:editUserNameCellIdentifier];
            GSEditUserNameTableViewCell *tempCell = (GSEditUserNameTableViewCell *)cell;
            tempCell.contentTitle.text = @"昵称";
            tempCell.content.text = @"小猫";
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            //头像
//            [GSActionSheet showActionWithTitles:@[@"拍照",@"相册",@"取消"] didClickAtIndex:^(NSInteger index) {
//                
//                NSLog(@"%d",index);
//                
//            }];
            break;
        case 1:
            //昵称
            break;
        case 2:
            //性别
            break;
        default:
            break;
    }
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
