//
//  WheelImageView.m
//
//
//  Created by Phil Wright on 7/17/14.
//  Copyright (c) 2014 Touchopia, LLC. All rights reserved.
//

#import "WheelImageView.h"

@interface  WheelImageView () {
    UITapGestureRecognizer *tapGesture;
}

-(void)setupView;

@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation WheelImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnWheel:)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
    [self addSubview:self.imageView];
}

- (void)tappedOnWheel:(UIGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self];
    
    if(point.y > self.frame.size.height/2) {
        // MOVE TO NEXT TIP
        self.angle += -0.11;
        self.angularVelocity = -7.0;
        self.shouldHaveFixedAngleReduction = YES;
    } else {
        // MOVE TO PREVIOUS TIP
        self.angle += 0.11;
        self.angularVelocity = 7.0;
        self.shouldHaveFixedAngleReduction = YES;
    }
    
    [self startAnimating];
}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)anImage
{
    if ((self = [self initWithFrame:frame])) {
        [self.imageView setImage:anImage];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (UIImage *)image
{
    return self.imageView.image;
}

-(void)startAnimating
{
    [super startAnimating:nil];
}

- (void)setAngle:(CGFloat)a
{
    [super setAngle:a];
    [[self.imageView layer] setTransform:CATransform3DMakeRotation(self.angle, 0, 0, 1)];
}

@end
