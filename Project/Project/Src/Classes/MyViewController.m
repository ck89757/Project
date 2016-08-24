//
//  MyViewController.m
//  Project
//
//  Created by kain on 16/6/6.
//  Copyright © 2016年 kain. All rights reserved.
//

#import "MyViewController.h"
#import "Sign.h"
@interface MyViewController (){
    UITableView *myTableView;
}
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的";
      [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    
    self.automaticallyAdjustsScrollViewInsets = NO,
    myTableView=[[UITableView alloc] init];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    //改变换行线颜色lyttzx.com
//    myTableView.separatorColor = [UIColor blueColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    //设定cell分行线颜色
//    [myTableView setSeparatorColor:[UIColor redColor]];
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
//                [myTableView.mj_header endRefreshing];
                [self getData];
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
    return 10;
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
    
    cell.textLabel.text=@"测试";
    return cell;
}




-(void)getData{
    [myTableView.mj_header endRefreshing];
    //登陆参数
    NSMutableDictionary *dicParameters = [[NSMutableDictionary alloc]init];
    [dicParameters setValue:@"18691009168" forKey:@"username"];
    [dicParameters setValue:@"111111" forKey:@"password"];
    [dicParameters setValue:@"42E5A3E0-FE74-43BD-840D-5F15C8EE18B0" forKey:@"device_udid"];
    [dicParameters setValue:@"10" forKey:@"device_type"];
    [dicParameters setValue:@"" forKey:@"device_token"];
    [dicParameters setValue:@"2.0.2.7" forKey:@"version"];
    [dicParameters setValue:@"bestkeep" forKey:@"app_name"];

    
    NSString *time = [Sign getSystemTime];
    //生成sign
    NSString *sign = [Sign sign:dicParameters time:time];
    [dicParameters setValue:time forKey:@"time"];
    [dicParameters setValue:sign forKey:@"sign"];
    
    [HttpKit POST:@"https://passport.test.utouu.com/m1/tickets" param:dicParameters header:nil success:^(id responseObject) {
        
        if (responseObject) {
            NSString *tgt=[[responseObject objectForKey:@"data"] objectForKey:@"tgt"];
            NSLog(@"tgt:%@",tgt);
            //获取ST
            [self getST:tgt andService:@"http://api.test.utouu.com/v1/user/bestkeep-info"];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"----%@",error);
    }];
    
    
}

//获取ST
- (void)getST:(NSString *)tgt andService:(NSString *)service{

    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setValue:service forKey:@"service"];
    
    NSString *url = [NSString stringWithFormat:@"https://passport.test.utouu.com/m1/tickets/%@",tgt];
    
     [HttpKit POST:url param:@{@"service": service} header:nil success:^(id responseObject) {
        NSString *st = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"st :%@",st);
        [self getUserInfo:st];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}






-(void)getUserInfo:(NSString *)st{
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setValue:st forKey:@"st"];
    [HttpKit POST:@"http://api.test.utouu.com/v1/user/bestkeep-info" param:nil header:dic  success:^(id responseObject) {
        
        NSLog(@"UserInfo:%@",responseObject);
    } failure:^(NSError *error) {
        
        NSLog(@"----%@",error);
    }];
}




@end
