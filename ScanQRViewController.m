//
//  ScanQRViewController.m
//  ScanQRCode
//
//  Created by 黄静静 on 15-7-11.
//  Copyright (c) 2015年 黄静静. All rights reserved.
//

#import "ScanQRViewController.h"
@interface ScanQRViewController()

@end

@implementation ScanQRViewController

#define PREVIRE_HEIGHT_AND_WEIGHT 280

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 300, 300)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-PREVIRE_HEIGHT_AND_WEIGHT)/2,(self.label.frame.origin.y+self.label.frame.size.height)*1.5, PREVIRE_HEIGHT_AND_WEIGHT, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}

- (void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake((self.view.frame.size.width-PREVIRE_HEIGHT_AND_WEIGHT)/2, (self.label.frame.origin.y+self.label.frame.size.height)*1.5+2*num, PREVIRE_HEIGHT_AND_WEIGHT, 2);
        if (2*num == 280) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake((self.view.frame.size.width-PREVIRE_HEIGHT_AND_WEIGHT)/2, (self.label.frame.origin.y+self.label.frame.size.height)*1.5+2*num, PREVIRE_HEIGHT_AND_WEIGHT, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
}

-(void)viewWillDisappear:(BOOL)animated
{
     [timer invalidate]; //取消定时器
}
- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
 

    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake((self.view.frame.size.width-PREVIRE_HEIGHT_AND_WEIGHT)/2,(self.label.frame.origin.y+self.label.frame.size.height)*1.5,PREVIRE_HEIGHT_AND_WEIGHT,PREVIRE_HEIGHT_AND_WEIGHT);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    
    // Start 启动扫描
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    //停止扫描
    [_session stopRunning];
    [timer invalidate];
    [_line removeFromSuperview];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否链接" message:stringValue delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];

    NSLog(@"%@",stringValue);
    

}



@end
