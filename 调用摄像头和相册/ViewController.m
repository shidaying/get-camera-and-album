//
//  ViewController.m
//  调用摄像头和相册
//
//  Created by hour on 14-4-16.
//  Copyright (c) 2014年 上海思墨信息科技有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"just test");
	// Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 120, 80);
    imageView.backgroundColor = [UIColor greenColor];
    imageView.tag = 101;
    [self.view addSubview:imageView];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 200, 100, 30);
    [button setTitle:@"打开相册" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openPics) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(0, 300, 100, 30);
    [button2 setTitle:@"打开相机" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(openCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

// 打开相机
- (void)openCamera {
    // UIImagePickerControllerCameraDeviceRear 后置摄像头
    // UIImagePickerControllerCameraDeviceFront 前置摄像头
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        NSLog(@"没有摄像头");
        return ;
    }

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//    imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    // 编辑模式
    imagePicker.allowsEditing = YES;
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
}

// 打开相册
- (void)openPics {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
	}


// 选中照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"info = %@", info);
    UIImageView  *imageView = (UIImageView *)[self.view viewWithTag:101];
    // UIImagePickerControllerOriginalImage 原始图片
    // UIImagePickerControllerEditedImage 编辑后图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    imageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

// 取消相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
