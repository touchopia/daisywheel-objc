//
//  CameraViewController.m
//  Daisy Wheel
//
//  Created by Phil Wright on 2/4/15.
//  Copyright (c) 2015 Phil Wright. All rights reserved.
//

#import "CameraViewController.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "DBCameraLibraryViewController.h"
#import "DBCameraGridView.h"
#import "CustomCamera.h"

#define kCellIdentifier @"CellIdentifier"

@interface DetailViewController : UIViewController {
    UIImageView *_imageView;
}

@property (nonatomic, strong) UIImage *detailImage;
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self.navigationItem setTitle:@"Detail"];
    
    _imageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:_imageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_imageView setImage:_detailImage];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _detailImage = nil;
    [_imageView setImage:nil];
}

@end

@interface CameraViewController () <DBCameraViewControllerDelegate>

- (IBAction)openCamera:(id)sender;

@end

@implementation CameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self.navigationItem setTitle:@"Camera"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Camera Actions

- (IBAction)openCamera:(id)sender
{
/*
//If you want to customize the camera view, use initWithDelegate:cameraSettingsBlock:
 
    DBCameraContainerViewController *cameraContainer = [[DBCameraContainerViewController alloc] initWithDelegate:self cameraSettingsBlock:^(DBCameraView *cameraView, DBCameraContainerViewController *container) {
        [cameraView.photoLibraryButton setHidden:YES]; //Hide Library button
     
        //Override the camera grid
        DBCameraGridView *cameraGridView = [[DBCameraGridView alloc] initWithFrame:cameraView.previewLayer.frame];
        [cameraGridView setNumberOfColumns:4];
        [cameraGridView setNumberOfRows:4];
        [cameraGridView setAlpha:0];
        [container.cameraViewController setCameraGridView:cameraGridView];
        [container.cameraViewController setUseCameraSegue:NO];
    }];

//Set the Tint Color and the Selected Color
    [cameraContainer setTintColor:[UIColor redColor]];
    [cameraContainer setSelectedTintColor:[UIColor yellowColor]];
*/

    DBCameraContainerViewController *cameraContainer = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    //[cameraContainer setFullScreenMode];
    
    [self presentViewController:cameraContainer animated:YES completion:nil];
}

-(IBAction)openCustomCamera:(id)sender
{
    CustomCamera *camera = [CustomCamera initWithFrame:[[UIScreen mainScreen] bounds]];
    [camera buildInterface];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[DBCameraViewController alloc] initWithDelegate:self cameraView:camera]];
    [nav setNavigationBarHidden:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)openCameraWithoutSegue
{
    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
    [cameraController setUseCameraSegue:NO];
//    [cameraController setLibraryMaxImageSize:1280]; //You can set a value for the maximum output resolution for the image selected from the Library
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [container setCameraViewController:cameraController];
    [container setFullScreenMode];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:container];
    [nav setNavigationBarHidden:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)openCameraWithForceQuad
{
    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
    [cameraController setForceQuadCrop:YES];
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [container setCameraViewController:cameraController];
    [container setFullScreenMode];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:container];
    [nav setNavigationBarHidden:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)openCameraWithoutContainer
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[DBCameraViewController initWithDelegate:self]];
    [nav setNavigationBarHidden:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void) openLibrary
{
    DBCameraLibraryViewController *vc = [[DBCameraLibraryViewController alloc] init];
    [vc setDelegate:self]; //DBCameraLibraryViewController must have a DBCameraViewControllerDelegate object
//    [vc setForceQuadCrop:YES]; //Optional
//    [vc setUseCameraSegue:YES]; //Optional
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [nav setNavigationBarHidden:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - DBCameraViewControllerDelegate

- (void) dismissCamera:(id)cameraViewController
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

- (void)camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    [detail setDetailImage:image];
    [self.navigationController pushViewController:detail animated:NO];
    [cameraViewController restoreFullScreenMode];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end