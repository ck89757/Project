//
//  BaseNavigationController.m
//  Project
//
//  Created by kain on 16/6/3.
//  Copyright © 2016年 kain. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setTranslucent:YES];//设置navigationbar的半透明
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/155.0 alpha:1]];//设置navigationbar的颜色
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"kain" style:UIBarButtonItemStylePlain target:self action:@selector(clicked)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clicked)];//设置navigationbar右边按钮
    [self.navigationBar setTintColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]];//设置navigationbar上左右按钮字体颜色
    
    //    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];//设置返回按钮颜色
}
-(void)clicked{
    NSLog(@"-------");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
