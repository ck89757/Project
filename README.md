
PrefixHeader.pch定义了常用的宏
例如获取设置rgb颜色，获取屏幕高宽，判断设备类型等


//网络请求可以直接使用以下方式
//其中param可以接受@{@"show_env":@"1"}形式和NSDictionary

[HttpKit GET:@"http://httpbin.org/get" param:@{@"show_env":@"1"} success:^(id responseObject){
    NSLog(@"%@",responseObject);
} failure:^(NSError *error) {

}];


//图片异步请求可以使用AF自带异步请求，不需要再添加SDWebImage了
[imageView setImageWithURL:[NSURL URLWithString:@"http://static.oschina.net/uploads/img/201203/24233432_EmSY.png"]];

//Toast类似于安卓手机的toast提示。

[Toast showMessage:@"测试一下"];