//
//  WheelImageView.h
//
//
//  Created by Phil Wright on 7/17/14.
//  Copyright (c) 2014 Touchopia, LLC. All rights reserved.
//

#import "ANSpinWheel.h"

@interface WheelImageView : ANSpinWheel <UIGestureRecognizerDelegate>

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)anImage;

@property UIImage *image;

@end
