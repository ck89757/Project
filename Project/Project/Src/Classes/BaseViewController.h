//
//  BaseViewController.h
//  Project
//
//  Created by kain on 16/6/3.
//  Copyright © 2016年 kain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(nonatomic,strong)UIView *mainView;//主View(不需要网self.view中添加，mainView自己写的好控制)

-(void)leftBarButtonItem:(NSString *)title;
@end
