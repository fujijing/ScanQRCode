//
//  ViewController.m
//  ScanQRCode
//
//  Created by 黄静静 on 15-7-11.
//  Copyright (c) 2015年 黄静静. All rights reserved.
//

#import "ViewController.h"
#import "ScanQRViewController.h"

@interface ViewController ()

@end

@implementation ViewController



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ScanQR"]) {
        if ([segue.destinationViewController isKindOfClass:[ScanQRViewController class]]) {
            ScanQRViewController *tsvc = (ScanQRViewController*)segue.destinationViewController;
//            [self.navigationController pushViewController:tsvc animated:YES];
            tsvc.title = @"ScanQR";
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
