//
//  TwoViewController.m
//  Project
//
//  Created by kain on 16/6/3.
//  Copyright © 2016年 kain. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"商品详情";
    [self.view setBackgroundColor:RGB(232, 222, 332)];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 150, 150)];
    [btn setBackgroundColor:[UIColor yellowColor]];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:btn];
    
    
    //http://httpbin.org/get?show_env=1
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"1" forKey:@"show_env"];

    [HttpKit GET:@"http://httpbin.org/get" param:@{@"show_env":@"1"} header:nil success:^(id responseObject){
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
    
    
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
