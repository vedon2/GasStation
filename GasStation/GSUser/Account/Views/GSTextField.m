//
//  GSTextField.m
//  GasStation
//
//  Created by vedon on 2/20/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kImageViewLeftPadding 0
#define kImageViewRightPadding 15
#define kImageViewSize 25
#define kAccessoryButtonHeight 20
#define kAccessoryButtonWidth 40
#define kSeperateLinePadding 5

#import "GSTextField.h"
#import "PureLayout.h"
#import "GSColor.h"

@interface GSTextField ()
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *accessoryView;
@property (nonatomic,strong) UIView *seperateLine;
@end

@implementation GSTextField

- (instancetype)initWithDelegate:(id<GSTextFieldProtocol>)delegate
{
    self = [super initForAutoLayout];
    if (self)
    {
        self.delegate = delegate;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image placeHolderText:(NSString *)placeHolderText
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self configureWithImage:image title:nil placeHolderText:placeHolderText];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolderText:(NSString *)placeHolderText
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self configureWithImage:nil title:title placeHolderText:placeHolderText];
    }
    return self;
}

- (void)configureWithDelegate:(id<GSTextFieldProtocol>)delegate
{
    self.delegate = delegate;
    if (self.accessoryView)
    {
        [self addSubview:self.accessoryView];
    }
    [self configureWithImage:nil title:nil placeHolderText:nil];
}

- (void)configureWithImage:(UIImage *)image title:(NSString *)title placeHolderText:(NSString *)placeHolderText
{
    if (self.delegate)
    {
        image = [self.delegate textFieldTitleImage:self];
        placeHolderText = [self.delegate textFieldPlaceHolderText:self];
        title = [self.delegate textFieldIndicatorText:self];
    }
    
    if (image)
    {
        self.imageView.image = image;
        [self addSubview:self.imageView];
    }
    if (placeHolderText)
    {
        self.textField.placeholder = placeHolderText;
        
    }
    [self addSubview:self.textField];
    if (title)
    {
        self.titleLabel.text = title;
        [self addSubview:self.titleLabel];
    }
    [self addSubview:self.seperateLine];
    [self layoutContent];
}


- (void)layoutContent
{
    UIView *textFieldLeftPaddingView = nil;
    if (_imageView)
    {
        textFieldLeftPaddingView = _imageView;
        [_imageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:kImageViewLeftPadding];
        [_imageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
        [_imageView autoSetDimensionsToSize:CGSizeMake(kImageViewSize, kImageViewSize)];
    }
    if (_titleLabel)
    {
        textFieldLeftPaddingView = _titleLabel;
        [_titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:kImageViewLeftPadding];
        [_titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
        
        CGSize size = [_titleLabel sizeThatFits:self.frame.size];
        [_titleLabel autoSetDimensionsToSize:size];
    }
    if (textFieldLeftPaddingView == nil)
    {
        textFieldLeftPaddingView = self;
    }
    [_textField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [_textField autoPinEdge:ALEdgeLeft toEdge:([textFieldLeftPaddingView isEqual:self]?ALEdgeLeft:ALEdgeRight) ofView:textFieldLeftPaddingView withOffset:kImageViewRightPadding];
    [_textField autoPinEdge:ALEdgeRight toEdge:(_accessoryView != nil?ALEdgeLeft:ALEdgeRight) ofView:(_accessoryView != nil?_accessoryView:self) withOffset:(_accessoryView != nil?-kImageViewRightPadding:0)];
    
    if (_accessoryView)
    {
        CGSize size = [self.delegate textFieldAccessorySize:self];
        [_accessoryView autoSetDimensionsToSize:size];
        [_accessoryView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self];
        [_accessoryView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_textField];
    }
    
    UIEdgeInsets inset = [self.delegate textFieldSeperateInsets:self];
    
    [self.seperateLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.textField withOffset:inset.top];
    [self.seperateLine autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:inset.left];
    [self.seperateLine autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-inset.right];
    [self.seperateLine autoSetDimension:ALDimensionHeight toSize:1.0];
}

#pragma mark - Private

- (UIButton *)defaultAccessoryView
{
    UIButton *_accessoryBtn = [[UIButton alloc] initForAutoLayout];
    _accessoryBtn.backgroundColor = [UIColor lightGrayColor];
    _accessoryBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_accessoryBtn addTarget:self action:@selector(accessoryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return _accessoryBtn;
}

#pragma mark - Action

- (void)accessoryButtonAction:(id)sender
{
    
}

#pragma mark - Getter & Setter

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initForAutoLayout];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont systemFontOfSize:14];
        if ([self.colorDelegate respondsToSelector:@selector(textFieldTextColor:)])
        {
            _textField.textColor = [self.colorDelegate textFieldTextColor:self];
        }
    }
    return _textField;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initForAutoLayout];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.backgroundColor = [UIColor clearColor];
        if ([self.colorDelegate respondsToSelector:@selector(textFieldIndicatorTextColor:)])
        {
            _titleLabel.textColor = [self.colorDelegate textFieldIndicatorTextColor:self];
        }
    }
    return _titleLabel;
}

- (UIView *)accessoryView
{
    if (!_accessoryView)
    {
        if ([self.delegate respondsToSelector:@selector(textFieldAccessoryView:)])
        {
            _accessoryView = [self.delegate textFieldAccessoryView:self];
            _accessoryView.translatesAutoresizingMaskIntoConstraints = NO;
        }
    }
    return _accessoryView;
}

- (UIView *)seperateLine
{
    if (!_seperateLine)
    {
        _seperateLine = [[UIView alloc] initForAutoLayout];
        if ([self.colorDelegate respondsToSelector:@selector(textFieldSeperateLineColor:)])
        {
            _seperateLine.backgroundColor = [self.colorDelegate textFieldSeperateLineColor:self];
        }
        else
        {
            _seperateLine.backgroundColor = [GSColor registerTextColor];
        }
        
    }
    return _seperateLine;
}

@end
