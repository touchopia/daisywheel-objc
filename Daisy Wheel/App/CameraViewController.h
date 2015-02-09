//
//  CameraViewController.h
//  Daisy Wheel
//
//  Created by Phil Wright on 2/4/15.
//  Copyright (c) 2015 Phil Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSImagePickerViewController.h"

@interface CameraViewController : UIViewController

- (IBAction)openCamera:(id)sender;

@property (nonatomic, weak) IBOutlet UIButton *cameraButton;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end