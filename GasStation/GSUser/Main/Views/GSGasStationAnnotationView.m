//
//  GSGasStationAnnotationView.m
//  GasStation
//
//  Created by vedon on 3/3/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSGasStationAnnotationView.h"

@interface GSGasStationAnnotationView ()
@property (nonatomic,strong) UIImageView *annotationImageView;
@property (nonatomic,strong) GSGasStationAnnotationData *annotationData;
@end

@implementation GSGasStationAnnotationView

- (instancetype)initWithAnnotationData:(GSGasStationAnnotationData *)data
{
    assert(data);
    self = [super initWithAnnotation:data.annotation reuseIdentifier:data.reuseIdentifier];
    if (self)
    {
        [self configureWithData:data];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)configureWithData:(GSGasStationAnnotationData *)data
{
    assert(data);
    self.annotationData = data;
    self.annotation = data.annotation;

    self.frame = CGRectMake(0, 0, data.annotationSize.width, data.annotationSize.height);
    [self addSubview:self.annotationImageView];
    
    self.annotationImageView.image = [self imageForAnnotationView];
    
}

- (UIImage *)imageForAnnotationView
{
    NSString *imageName = nil;
    if ([self.annotationData isCooperation])
    {
        imageName = @"icon_home_cooperation";
    }
    else
    {
        imageName = @"icon_home_ordinary";
    }
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}


#pragma mark - Getter & Setter

- (UIImageView *)annotationImageView
{
    if (!_annotationImageView)
    {
        _annotationImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _annotationImageView.backgroundColor = [UIColor clearColor];
        _annotationImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _annotationImageView;
}

@end
