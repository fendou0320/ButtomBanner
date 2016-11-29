//
//  ViewController.m
//  ButtomBanner
//
//  Created by 王江亮 on 16/11/28.
//  Copyright © 2016年 WangJiangliang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SlideBanner *banner = [[SlideBanner alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    banner.sliderDetegate = self;
    [self.view addSubview:banner];
    
}


- (void)slideBanner:(SlideBanner *)view isSlide:(BOOL)siSlide{

    NSLog(@"点击了");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
