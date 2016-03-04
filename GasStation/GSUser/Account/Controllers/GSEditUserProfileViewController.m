//
//  GSEditUserProfileViewController.m
//  GasStation
//
//  Created by vedon on 2/15/16.
//  Copyright © 2016 vedon. All rights reserved.
//
#define kChangeGenderTag 1000
#define kTakePhotoTag 1001

#import "GSEditUserProfileViewController.h"
#import "GSUserAvatarTableViewCell.h"
#import "GSEditUserNameTableViewCell.h"
#import "BlocksKit+UIKit.h"
#import "GSActionSheet.h"
#import "EPImagePickerHelper.h"
#import "GSRenameViewController.h"
#import "GSColor.h"
#import "GSUserManager.h"

static NSString *userAvatarCellIdentifier = @"userAvatarCellIdentifier";
static NSString *editUserNameCellIdentifier = @"editUserNameCellIdentifier";

@interface GSEditUserProfileViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *contentTable;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong,nonatomic) NSArray *dataSource;

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
    
    self.dataSource = @[@"昵称",@"性别"];
    self.contentTable.scrollEnabled = NO;

    UIView *tableViewFooterView = [[UIView alloc] initWithFrame:self.view.bounds];
    tableViewFooterView.backgroundColor = [GSColor userCenterBackgroundColor];
    self.contentTable.tableFooterView = tableViewFooterView;
    self.contentTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.logoutButton.layer.cornerRadius = 2.0;
    self.logoutButton.layer.masksToBounds = YES;
    self.logoutButton.backgroundColor = [GSColor mainColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title
{
    return @"个人信息";
}

#pragma mark - Action

- (IBAction)logoutAction:(id)sender
{
    [[GSUserManager shareManager] logout];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
            
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:editUserNameCellIdentifier];
            GSEditUserNameTableViewCell *tempCell = (GSEditUserNameTableViewCell *)cell;
            tempCell.contentTitle.text = @"昵称";
            tempCell.content.text = @"小猫";
            break;
        }
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:editUserNameCellIdentifier];
            GSEditUserNameTableViewCell *tempCell = (GSEditUserNameTableViewCell *)cell;
            tempCell.contentTitle.text = @"性别";
            tempCell.content.text = @"男";
            break;
        }
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_go"]];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row)
    {
        case 0:
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
            [actionSheet showInView:self.view];
            actionSheet.tag = kTakePhotoTag;
            actionSheet = nil;
        }
            break;
        case 1:
            //昵称
        {
            GSRenameViewController *vc = [[GSRenameViewController alloc] initWithNickname:@"123"];
            [self.navigationController pushViewController:vc animated:YES];
            vc = nil;
        }
            break;
        case 2:
            //性别
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
            [actionSheet showInView:self.view];
            actionSheet.tag = kChangeGenderTag;
            actionSheet = nil;
        }
            break;
        default:
            break;
    }
}

#pragma mark - ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"取消"]) {
        return;
    }
    
    if (actionSheet.tag == kTakePhotoTag)
    {
        ImagePickerType type = StillImage;
        if ([buttonTitle isEqualToString:@"拍照"]) {
            type = Camera;
        } else {
            type = StillImage;
        }
        [[EPImagePickerHelper sharedInstance] showImagePickerWithController:self andType:type finishPickingBlock:^(UIImage *image, NSError *error) {
            if (error) {
                assert(error);
                
            }
            else
            {
                if (nil != image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                    });
                }
                
            }
        } cancelBlock:nil];
    }
    else if (actionSheet.tag == kChangeGenderTag)
    {
        
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
