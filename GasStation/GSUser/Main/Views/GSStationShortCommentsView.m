//
//  GSStationShortCommentsView.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSStationShortCommentsView.h"
#import "PureLayout.h"
#import "GSCommentTableViewCell.h"
#import "GSCommentTypeTableViewCell.h"
#import "GSSearchResultMacro.h"

static NSString *commentCellIdentifier = @"commentCellIdentifier";
static NSString *commentTypeCellIdentifier = @"commentTypeCellIdentifier";
static NSString *moreCommentCellIdentifier = @"moreCommentCellIdentifier";

@interface GSStationShortCommentsView ()<UITableViewDataSource,UITableViewDelegate,GSCommentTypeTableViewCellDeleagte>
@property (nonatomic,strong) UITableView *contentTatble;
@property (nonatomic,strong) NSMutableArray *comments;

@end

@implementation GSStationShortCommentsView

- (instancetype)initWithDelegate:(id<GSStationShortCommentsViewDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initialize];
}

- (void)initialize
{
    [self addSubview:self.contentTatble];
    [self.contentTatble autoPinEdgesToSuperviewEdges];
    self.contentTatble.scrollEnabled = NO;
    
    UINib *commentNib = [UINib nibWithNibName:@"GSCommentTableViewCell" bundle:nil];
    [self.contentTatble registerNib:commentNib forCellReuseIdentifier:commentCellIdentifier];
    UINib *commentTypeNib = [UINib nibWithNibName:@"GSCommentTypeTableViewCell" bundle:nil];
    [self.contentTatble registerNib:commentTypeNib forCellReuseIdentifier:commentTypeCellIdentifier];
}


#pragma mark - Public

- (CGFloat)heightForCommentsView
{
    return 375;
}

- (void)configureWithData:(id)data
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
  
    switch (indexPath.row)
    {
        case 0:
        case 5:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:moreCommentCellIdentifier];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCommentCellIdentifier];
            }
            cell.textLabel.text = @"查看全部评论";
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            break;
        }
        case 2:
        case 3:
        case 4:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:commentCellIdentifier];
            break;
        }
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:commentTypeCellIdentifier];
            GSCommentTypeTableViewCell *tempCell = (GSCommentTypeTableViewCell *)cell;
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
    switch (indexPath.row)
    {
        case 0:
        case 5:
        {
            return kMoreCommentCellHeight;
            break;
        }
        case 2:
        case 3:
        case 4:
        {
            return kCommmentCellHeight;
            break;
        }
        case 1:
        {
            return kCommentTypeCellHeight;
            break;
        }
            
        default:
            return 0;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0 || (indexPath.row == [self tableView:self.contentTatble numberOfRowsInSection:indexPath.section] - 1))
    {
        if ([self.delegate respondsToSelector:@selector(didTapMoreCommentCell)])
        {
            [self.delegate didTapMoreCommentCell];
        }
    }
}

#pragma mark - GSCommentTypeTableViewCellDeleagte

- (void)didTapCommentType:(GSCommentType)type
{
    //TODO: 刷新数据
}

#pragma mark - Getter & Setter

- (UITableView *)contentTatble
{
    if (!_contentTatble)
    {
        _contentTatble = [[UITableView alloc] initForAutoLayout];
        _contentTatble.delegate = self;
        _contentTatble.dataSource = self;
    }
    return _contentTatble;
}

@end
