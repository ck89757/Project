//
//  ViewController.m
//  TabBarTest
//
//  Created by kain on 16/6/2.
//  Copyright © 2016年 kain. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "OneViewController.h"
#import "ThreeViewController.h"
#import "MyViewController.h"
@interface BaseTabBarController ()

@end
/*!
 *  @author kain, 16-06-02 17:06:33
 *
 *  @brief   UITabBarController(底部菜单)
 */
@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /*!
     
     - author: kain
     - date: 16-06-02 17:06:55
     UITabBarController的北京色设置
     
     - returns:
     */
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    [bgView setBackgroundColor:[[UIColor alloc] initWithRed:255.0/255.0
                                                      green:255.0/255.0
                                                       blue:255.0/255.0
                                                      alpha:5.0]];
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = NO;
    
    
    
    
    
    
    //b.创建子控制器
    OneViewController *c1=[[OneViewController alloc]init];
    c1.navigationController.navigationBarHidden=NO;
    BaseNavigationController *na1= [[BaseNavigationController alloc]initWithRootViewController:c1];
    [self addChildViewController:na1];
    c1.view.backgroundColor=[UIColor greenColor];
    c1.tabBarItem.title=@"首页";
    [c1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0/255.0 green:186/255.0 blue:156/255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    c1.tabBarItem.image=[UIImage imageNamed:@"home"];
    c1.tabBarItem.selectedImage=[[UIImage imageNamed:@"home_no"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    c1.tabBarItem.badgeValue=@"123";
    
    ThreeViewController *c2=[[ThreeViewController alloc]init];
    c2.view.backgroundColor=[UIColor brownColor];
    c2.title=@"分类";
    c2.tabBarItem.title=@"分类";
    [c2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0/255.0 green:186/255.0 blue:156/255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    c2.tabBarItem.image=[UIImage imageNamed:@"classification"];
    c2.tabBarItem.selectedImage=[[UIImage imageNamed:@"classification_no"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *na2= [[BaseNavigationController alloc]initWithRootViewController:c2];
    
    [self addChildViewController:na2];
    
    
    
    UIViewController *c3=[[UIViewController alloc]init];
    c3.view.backgroundColor=[UIColor grayColor];
    c3.title=@"购物车";
    c3.tabBarItem.title=@"购物车";
    c3.navigationController.navigationBarHidden=NO;
    c3.tabBarItem.image=[UIImage imageNamed:@"cart"];
    c3.tabBarItem.selectedImage=[[UIImage imageNamed:@"cart_no"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"cart"] selectedImage:[[UIImage imageNamed:@"cart_no"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    c3.tabBarItem.tag = 3;
    [c3.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0/255.0 green:186/255.0 blue:156/255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    BaseNavigationController *na3= [[BaseNavigationController alloc]initWithRootViewController:c3];
    
    [self addChildViewController:na3];
    
    
    
    MyViewController *c4=[[MyViewController alloc]init];
    c4.view.backgroundColor=[UIColor cyanColor];
    c4.tabBarItem.title=@"我的";
    c4.title=@"我的";
    c4.tabBarItem.image=[UIImage imageNamed:@"my"];
    [c4.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0/255.0 green:186/255.0 blue:156/255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    c4.tabBarItem.selectedImage=[[UIImage imageNamed:@"my_no"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *na4= [[BaseNavigationController alloc]initWithRootViewController:c4];
    [self addChildViewController:na4];
    
    
    //c.2第二种方式
    self.viewControllers=@[na1,na2,na3,na4];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
