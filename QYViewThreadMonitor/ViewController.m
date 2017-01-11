//
//  ViewController.m
//  QYViewThreadMonitor
//
//  Created by liuming on 2017/1/11.
//  Copyright © 2017年 burning. All rights reserved.
//

#import "ViewController.h"
#import "UIView+QYMainThreadMonitor.h"
#import "CALayer+QYMainThreadMonitor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView * v1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    v1.backgroundColor = [UIColor redColor];
    [self.view addSubview:v1];
    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        UIView * v2 = [[UIView alloc] initWithFrame:CGRectMake(20, 140, 100, 100)];
//        v2.backgroundColor = [UIColor blueColor];
//        [self.view addSubview:v2];
//    });
    
    CALayer * layer1 = [[CALayer alloc] init];
    layer1.bounds = CGRectMake(0, 0, 100, 100);
    layer1.position = CGPointMake(100, 100);
    layer1.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:layer1];
    
    CALayer * layer2 = [[CALayer alloc] init];
    layer2.bounds = CGRectMake(0, 0, 100, 100);
    layer2.position = CGPointMake(100, 240);
    layer2.backgroundColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:layer2];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [layer2 setNeedsDisplay];
    });



}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
