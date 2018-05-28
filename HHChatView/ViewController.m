//
//  ViewController.m
//  HHChatView
//
//  Created by Sherlock on 2018/5/25.
//  Copyright © 2018 daHuiGe. All rights reserved.
//

#import "ViewController.h"
#import "HHChatViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 50, 100, 100, 50);
    [btn setTitle:@"ClickMe" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoChat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)gotoChat{
    
    HHChatViewController *ctr = [[HHChatViewController alloc]init];

    [self.navigationController pushViewController:ctr animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
