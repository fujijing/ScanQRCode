//
//  ScanQRViewController.h
//  ScanQRCode
//
//  Created by 黄静静 on 15-7-11.
//  Copyright (c) 2015年 黄静静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ScanQRViewController : UIViewController<AVCaptureAudioDataOutputSampleBufferDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;

@end
