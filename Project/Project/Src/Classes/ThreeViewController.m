//
//  ThreeViewController.m
//  Project
//
//  Created by kain on 16/6/3.
//  Copyright © 2016年 kain. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController (){
    UITableView *myTableView;
}

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"分类";
    
    
    [self initView];
    
}


-(void)initView{

    self.automaticallyAdjustsScrollViewInsets = NO,
    myTableView=[[UITableView alloc] init];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    //改变换行线颜色lyttzx.com
    myTableView.separatorColor = [UIColor blueColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    //设定cell分行线颜色
    [myTableView setSeparatorColor:[UIColor redColor]];
    //编辑tableView
    myTableView.editing=NO;
    
    [self.mainView addSubview:myTableView];
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.mainView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

    myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                sleep(2);
                 [ myTableView.mj_header endRefreshing];
            });
        });
    }];
    
    
    myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                sleep(2);
                [ myTableView.mj_footer endRefreshing];
            });
        });
    }];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回有多少个Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


//改变行的高度

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}
//对应的section有多少个元素，也就是多少行。
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
//组装Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:showUserInfoCellIdentifier];
    }
    
    cell.textLabel.text=@"签名";
    return cell;
}

@end
