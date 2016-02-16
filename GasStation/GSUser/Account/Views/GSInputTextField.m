//
//  GSInputTextField.m
//  GasStation
//
//  Created by vedon on 2/14/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kImageViewPadding 5
#define kImageViewSize 30
#define kAccessoryButtonHeight 20
#define kAccessoryButtonWidth 40

#import "GSInputTextField.h"
#import "PureLayout.h"

@interface GSInputTextField ()

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *accessoryBtn;
@property (nonatomic,copy) AccessoryButtonAction accessoryButtonAction;
@end

@implementation GSInputTextField


- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image  placeholderText:(NSString *)placeHolderText accessoryButtonTitle:(NSString *)accessoryButtonTitle accessoryButtonAction:(AccessoryButtonAction)action
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self configureWithImage:image  placeholderText:placeHolderText accessoryButtonTitle:accessoryButtonTitle accessoryButtonAction:action];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeholderText:(NSString *)placeholderText accessoryButtonTitle:(NSString *)accessoryButtonTitle accessoryButtonAction:(AccessoryButtonAction)action
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self configureWithTitle:title placeholderText:placeholderText accessoryButtonTitle:accessoryButtonTitle accessoryButtonAction:action];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeholderText:(NSString *)placeholderText accessoryButton:(UIButton *)accessoryButton
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self configureWithTitle:title placeholderText:placeholderText accessoryButtonTitle:nil accessoryButtonAction:nil];
        _accessoryBtn = accessoryButton;
    }
    return self;
}

- (void)configureWithImage:(UIImage *)image placeholderText:(NSString *)placeHolderText accessoryButtonTitle:(NSString *)accessoryButtonTitle accessoryButtonAction:(AccessoryButtonAction)action
{
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
    
    if (accessoryButtonTitle)
    {
        [self.accessoryBtn setTitle:accessoryButtonTitle forState:UIControlStateNormal];
        [self addSubview:self.accessoryBtn];
    }
    self.accessoryButtonAction = action;
    
    [self layoutContent];
}

- (void)configureWithTitle:(NSString *)title placeholderText:(NSString *)placeholderText accessoryButtonTitle:(NSString *)accessoryButtonTitle accessoryButtonAction:(AccessoryButtonAction)action
{
    if (title)
    {
        self.titleLabel.text = title;
        [self addSubview:self.titleLabel];
    }
    if (placeholderText)
    {
        self.textField.placeholder = placeholderText;
    }
    [self addSubview:self.textField];
    
    if (accessoryButtonTitle)
    {
        [self.accessoryBtn setTitle:accessoryButtonTitle forState:UIControlStateNormal];
        [self addSubview:self.accessoryBtn];
    }
  
    self.accessoryButtonAction = action;
    [self layoutContent];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
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
    [_textField autoPinEdge:ALEdgeRight toEdge:(_accessoryBtn != nil?ALEdgeLeft:ALEdgeRight) ofView:(_accessoryBtn != nil?_accessoryBtn:self) withOffset:-kImageViewPadding];
    
    
    if (_accessoryBtn)
    {
        [_accessoryBtn autoSetDimensionsToSize:CGSizeMake(kAccessoryButtonWidth, MIN(kAccessoryButtonHeight, self.frame.size.height))];
        [_accessoryBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-kImageViewPadding];
        [_accessoryBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_textField];
    }
    self.backgroundColor = [UIColor greenColor];
}

#pragma mark - Public

- (NSString *)text
{
    return self.textField.text;
}

#pragma mark - accessoryButtonAction

- (void)accessoryButtonAction:(id)sender
{
    if (self.accessoryButtonAction)
    {
        self.accessoryButtonAction();
    }
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

- (UIButton *)accessoryBtn
{
    if (!_accessoryBtn)
    {
        _accessoryBtn = [[UIButton alloc] initForAutoLayout];
        _accessoryBtn.backgroundColor = [UIColor lightGrayColor];
        _accessoryBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_accessoryBtn addTarget:self action:@selector(accessoryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accessoryBtn;
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

@end
