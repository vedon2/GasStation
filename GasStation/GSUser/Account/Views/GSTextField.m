//
//  GSTextField.m
//  GasStation
//
//  Created by vedon on 2/20/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kImageViewPadding 5
#define kImageViewSize 30
#define kAccessoryButtonHeight 20
#define kAccessoryButtonWidth 40

#import "GSTextField.h"
#import "PureLayout.h"

@interface GSTextField ()
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *accessoryView;
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
    [self layoutContent];
}


- (void)layoutContent
{
    UIView *textFieldLeftPaddingView = nil;
    if (_imageView)
    {
        textFieldLeftPaddingView = _imageView;
        [_imageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:kImageViewPadding];
        [_imageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
        [_imageView autoSetDimensionsToSize:CGSizeMake(kImageViewSize, kImageViewSize)];
    }
    if (_titleLabel)
    {
        textFieldLeftPaddingView = _titleLabel;
        [_titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:kImageViewPadding];
        [_titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
        
        CGSize size = [_titleLabel sizeThatFits:self.frame.size];
        [_titleLabel autoSetDimensionsToSize:size];
    }
    if (textFieldLeftPaddingView == nil)
    {
        textFieldLeftPaddingView = self;
    }
    [_textField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [_textField autoPinEdge:ALEdgeLeft toEdge:([textFieldLeftPaddingView isEqual:self]?ALEdgeLeft:ALEdgeRight) ofView:textFieldLeftPaddingView withOffset:kImageViewPadding];
    [_textField autoPinEdge:ALEdgeRight toEdge:(_accessoryView != nil?ALEdgeLeft:ALEdgeRight) ofView:(_accessoryView != nil?_accessoryView:self) withOffset:-kImageViewPadding];
    
    
    if (_accessoryView)
    {
        CGSize size = [self.delegate textFieldAccessorySize:self];
        [_accessoryView autoSetDimensionsToSize:size];
        [_accessoryView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-kImageViewPadding];
        [_accessoryView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_textField];
    }
    
    self.backgroundColor = [UIColor greenColor];
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
        _textField.backgroundColor = [UIColor redColor];
    }
    return _textField;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initForAutoLayout];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.backgroundColor = [UIColor yellowColor];
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.backgroundColor = [UIColor purpleColor];
    }
    return _titleLabel;
}

- (UIView *)accessoryView
{
    if (!_accessoryView)
    {
        if ([self.delegate respondsToSelector:@selector(accessoryView)])
        {
            _accessoryView = [self.delegate textFieldAccessoryView:self];
            _accessoryView.translatesAutoresizingMaskIntoConstraints = NO;
        }
    }
    return _accessoryView;
}

@end
