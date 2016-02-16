//
//  GSPostCommentViewController.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSPostCommentViewController.h"
#import "TQStarRatingView.h"
#import "BlocksKit+UIKit.h"
#import "TQStarRatingView.h"

@interface GSPostCommentViewController ()<StarRatingViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIView *starContainerView;
@property (strong,nonatomic) TQStarRatingView *starRatingView;
@end

@implementation GSPostCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"提交" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        //TODO:share
        
    }];
    [self.starContainerView addSubview:self.starRatingView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title
{
    return @"写评论";
}

#pragma mark - StarRatingViewDelegate

-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    
}

#pragma mark - Getter & Setter 

- (TQStarRatingView *)starRatingView
{
    if (!_starRatingView)
    {
        _starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(0, 0, 200, self.starContainerView.frame.size.height) numberOfStar:5];
        _starRatingView.delegate = self;
    }
    return _starRatingView;
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
