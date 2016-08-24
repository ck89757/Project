//
//  ViewController.m
//  Project
//
//  Created by kain on 16/6/2.
//  Copyright © 2016年 kain. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIViewController+KNSemiModal.h"
@interface OneViewController (){
 
}

@end

@implementation OneViewController



- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar viewWithTag:101].hidden=YES;
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar viewWithTag:101].hidden=NO;
    self.tabBarController.tabBar.hidden = NO;
    [super viewWillAppear:animated];
    
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"首页";
    
//    UIViewController* ctrol=[UIApplication sharedApplication].keyWindow.rootViewController;
   UIView * _bageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
    _bageView.backgroundColor = [UIColor blackColor];
    _bageView.alpha = 0.4;
    _bageView.tag=101;
    [[self appRootViewController].view addSubview:_bageView];
      [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
             sleep(2);
            [hud hideAnimated:YES];
        });
    });
    
    
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    [imageView setImageWithURL:[NSURL URLWithString:@"http://static.oschina.net/uploads/img/201203/24233432_EmSY.png"]];
    [self.mainView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(25, 25, 25, 25));
    }];
    
    [Toast showMessage:@"测试一下"];
    
    
    
    
    UIImageView *logo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Group 6"]];
    [logo setFrame:CGRectMake((320-123)/2, 10, 123, 24)];
    logo.tag=101;
    
    
    
    [self.navigationController.navigationBar addSubview:logo];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 150, 150)];
    [btn setBackgroundColor:[UIColor yellowColor]];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:btn];
    
    
    self.navigationItem.title=@"";//隐藏navigation上的titile
    
    
}

-(void)onClick{
    
    NSLog(@"---------");
//    TwoViewController *two = [[TwoViewController alloc]init];
//    [self.navigationController pushViewController:two animated:YES];
//    
//    [self.navigationController.navigationBar viewWithTag:101].hidden=YES;
//    self.tabBarController.tabBar.hidden = YES;
    
    
    //    self.tabBarController.selectedIndex=2;
    
    [self.navigationController presentSemiViewController:[TwoViewController new] withOptions:@{
                                                                            KNSemiModalOptionKeys.pushParentBack    : @(YES),
                                                                            KNSemiModalOptionKeys.animationDuration : @(0.6),
                                                                            KNSemiModalOptionKeys.shadowOpacity     : @(0.1),
                                                                            }];
//    [self.navigationController presentSemiViewController:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
