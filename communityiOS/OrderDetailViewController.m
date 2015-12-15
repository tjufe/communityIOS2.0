//
//  OrderDetailViewController.m
//  communityiOS
//
//  Created by 何茂馨 on 15/8/24.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailAddressTableViewCell.h"
#import "OrderDetailPicTableViewCell.h"
#import "OrderDetailZhifuTableViewCell.h"
#import "UIAlertView+Blocks.h"
#import "StatusTool.h"
#import "getUserNameItem.h"
#import "ShoppingCartCommodity.h"
#import "OrderInfo.h"
#import "DetailOrderInfo.h"
#import "addOrderItem.h"
#import "OrderListViewController.h"
#import "UIViewController+Create.h"
#import "newPostItem.h"
#import "String.h"
#import "MBProgressHUD.h"
//wangyao 接入支付宝
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "APIAddress.h"
#import "AppDelegate.h"


@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) OrderDetailAddressTableViewCell *ODAddCell;
@property (strong,nonatomic) OrderDetailPicTableViewCell *ODPicCell;
@property (strong,nonatomic) OrderDetailZhifuTableViewCell *ODZhifuCell;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *label_order_money;

@property (strong,nonatomic) NSString *cust_name;
@property (weak,nonatomic) NSString *cust_id;
@property (weak,nonatomic) NSString *cust_phone;
@property (strong,nonatomic) NSString *cust_address;
@property (weak,nonatomic) NSString *cust_community_id;
@property (strong,nonatomic) NSString *send_time;
@property (strong,nonatomic) NSMutableArray *shop_id;
@property (strong,nonatomic) NSString *shop_phone;
@property (strong,nonatomic) NSString *order_state;
@property (strong,nonatomic) NSString *pay_type;
@property (strong,nonatomic) NSMutableArray *order_sendfee;
@property (strong,nonatomic)NSNumber *order_money;



@property (strong,nonatomic) NSMutableArray *comm_pic;//存放商品图片
@property (strong,nonatomic) NSMutableArray *comm_name;
@property (strong,nonatomic) NSMutableArray *comm_unit;
@property (strong,nonatomic) NSMutableArray *comm_price;
@property (strong,nonatomic) NSMutableArray *comm_id;
@property (strong,nonatomic) NSMutableArray *comm_buy_amount;
@property (strong,nonatomic) NSMutableArray *shop_order_money;//主订单金额
@property (strong,nonatomic) NSMutableArray *commodity_type_array;
@property (strong,nonatomic) NSString *mainorder_id;


@property (assign,nonatomic) double sum_order_money;

//id condLock = [[NSConditionLock alloc] initWithCondition:true];  //初始化

@end

@implementation OrderDetailViewController



int result;
int res;

NSCondition     *_condition;//条件锁


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 ) {
        self.ODAddCell = [tableView dequeueReusableCellWithIdentifier:nil];
        
        if (!self.ODAddCell) {//个人信息
            self.ODAddCell= [[[NSBundle mainBundle]loadNibNamed:@"OrderDetailAddressTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.ODAddCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        self.ODAddCell.label_name.text = self.cust_name;
        self.ODAddCell.label_phone.text = self.cust_phone;
        self.ODAddCell.label_address.text = self.cust_address;
               return self.ODAddCell;
    }else if(indexPath.row == 1){//商品图片信息
        self.ODPicCell = [tableView dequeueReusableCellWithIdentifier:nil];
        
        if (!self.ODPicCell) {
            self.ODPicCell= [[[NSBundle mainBundle]loadNibNamed:@"OrderDetailPicTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.ODPicCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if ([self.comm_pic count]==0) {
            self.ODPicCell.img_comm1.hidden = YES;
            self.ODPicCell.img_comm2.hidden = YES;
            self.ODPicCell.img_comm3.hidden = YES;
            self.ODPicCell.label_over.hidden = YES;
            self.ODPicCell.label_comm_amount.text = [NSString stringWithFormat:@"%d",0];

        }else if([self.comm_pic count]==1){
            [self.ODPicCell setImg_comm1_url:[self.comm_pic objectAtIndex:0]];
            self.ODPicCell.img_comm1.hidden = NO;
            self.ODPicCell.img_comm2.hidden = YES;
            self.ODPicCell.img_comm3.hidden = YES;
            self.ODPicCell.label_over.hidden = YES;
            self.ODPicCell.label_comm_amount.text = [NSString stringWithFormat:@"%d",1];
        }else if ([self.comm_pic count]==2){
            [self.ODPicCell setImg_comm1_url:[self.comm_pic objectAtIndex:0]];
            [self.ODPicCell setImg_comm2_url:[self.comm_pic objectAtIndex:1]];
            self.ODPicCell.img_comm1.hidden = NO;
            self.ODPicCell.img_comm2.hidden = NO;
            self.ODPicCell.img_comm3.hidden = YES;
            self.ODPicCell.label_over.hidden = YES;
            self.ODPicCell.label_comm_amount.text = [NSString stringWithFormat:@"%d",2];
        }else if ([self.comm_pic count]==3){
            [self.ODPicCell setImg_comm1_url:[self.comm_pic objectAtIndex:0]];
            [self.ODPicCell setImg_comm2_url:[self.comm_pic objectAtIndex:1]];
            [self.ODPicCell setImg_comm3_url:[self.comm_pic objectAtIndex:2]];
            self.ODPicCell.img_comm1.hidden = NO;
            self.ODPicCell.img_comm2.hidden = NO;
            self.ODPicCell.img_comm3.hidden = NO;
            self.ODPicCell.label_over.hidden = YES;
            self.ODPicCell.label_comm_amount.text = [NSString stringWithFormat:@"%d",3];

        }else{
            [self.ODPicCell setImg_comm1_url:[self.comm_pic objectAtIndex:0]];
            [self.ODPicCell setImg_comm2_url:[self.comm_pic objectAtIndex:1]];
            [self.ODPicCell setImg_comm3_url:[self.comm_pic objectAtIndex:2]];
            self.ODPicCell.img_comm1.hidden = NO;
            self.ODPicCell.img_comm2.hidden = NO;
            self.ODPicCell.img_comm3.hidden = NO;
            self.ODPicCell.label_over.hidden = NO;
            self.ODPicCell.label_comm_amount.text = [NSString stringWithFormat:@"%lu",(unsigned long)[self.comm_pic count]];

        }
        return self.ODPicCell;
    
    }else{//订单支付信息
        self.ODZhifuCell = [tableView dequeueReusableCellWithIdentifier:nil];
        
        if (!self.ODZhifuCell) {
            self.ODZhifuCell= [[[NSBundle mainBundle]loadNibNamed:@"OrderDetailZhifuTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.ODZhifuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        self.ODZhifuCell.label_send_date.text = self.send_time;
        return self.ODZhifuCell;
        
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 150;
    }else if(indexPath.row == 1){
        return 100;
    }else{
        return 100;
    }


}


//tableview头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    headView.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1];
    return headView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.shop_order_money = [[NSMutableArray alloc]init];
    
    
    // Do any additional setup after loading the view.
    //初始化导航条title
    self.navigationItem.title = @"确认订单";
    //获取当前用户信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.cust_id =[defaults objectForKey:@"UserID"];
    self.cust_phone = [defaults objectForKey:@"PhoneNumber"];
    self.cust_community_id = [defaults objectForKey:@"CommunityID"];
    
    [self getUserInfo];
    [self getOrderCommInfo];
    [self sendDate];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉分割线
    [self.table reloadData];
    

    

}

#pragma mark-----上传订单信息-------
//-(int)addMainOrder:(NSMutableArray *)tempArray:(NSMutableArray *)result_array{
//    
//    NSMutableArray *res_array = [[NSMutableArray alloc]init];
//    
//    [StatusTool statusToolAddNewMainOrderInfowithShopID:@[@"01",@"02"] CustID:self.cust_id CustName:self.cust_name CustPhone:self.cust_phone  OrderMoney:self.order_money OrderSendfee:self.order_sendfee OrderState:self.order_state OrderAddress:self.cust_address PayType:self.pay_type Success:^(id object) {
////        [_condition lock];
//        self.mainorder_id = (NSString *)object;
//        if(self.mainorder_id){
//            
//            for(int j=0;j<[tempArray count];j++){
//               ShoppingCartCommodity *s = [tempArray objectAtIndex:j];
//                //上传新订单子项
//                self.comm_id = s.commodity_id;
//                self.comm_unit = s.comm_unit;
//                self.comm_price =[NSNumber numberWithDouble:s.comm_price];
//                self.comm_name = s.comm_name;
//                self.comm_buy_amount = [NSNumber numberWithInt:s.buy_amount];
//                int res = [self addDetailOrder];
//                [res_array addObject:[NSNumber numberWithInt:res]];
//            }
//
//            
//           if([res_array containsObject:[NSNumber numberWithInt:0]]){
//                result = 0;
//           }else{
//                result=1;
//           }
//        }else{
//            result = 0;
//        }
//        
//
////         [_condition unlock];
//        
//    } failurs:^(NSError *error) {
//        result = 0;
//
////         [_condition unlock];
//
//    }];
////    [_condition wait];
////    [result_array addObject:[NSNumber numberWithInt:result]];
//
//    return result;
//}

#pragma mark-----上传订单子项------
//-(int)addDetailOrder{
//    
//    [DetailOrderInfo AddDetailNewOrderInfowithMainorderID:self.mainorder_id CommID:self.comm_id CommUnit:self.comm_unit CommPrice:self.comm_price CommName:self.comm_name BuyAmount:self.comm_buy_amount ShopID:self.shop_id Success:^(id object) {
//        
//        newPostItem *item = (newPostItem *)object;
//        if([item.msg containsString:@"成功"]){
//            res = 1;
//        }else{
//            res = 0;
//        }
//        
//    } failurs:^(NSError *error) {
//        res=0;
//        
//    }];
//    
//    return res;
//}


#pragma mark-----获取用户真实姓名和地址------
-(void)getUserInfo{
    [StatusTool statusToolGetUserNameWithCommunityID:self.cust_community_id UserID:self.cust_id Success:^(id object) {
        getUserNameItem *item = (getUserNameItem *)object;
        self.cust_name = item.user_name;
        self.cust_address = item.user_address;
       [self.table reloadData];
        
    } failurs:^(NSError *error) {
        //
    }];
}

#pragma mark-----获取商品信息-----
-(void)getOrderCommInfo{
    
    //初始化数组
    self.comm_pic = [[NSMutableArray alloc]init];
    self.shop_order_money = [[NSMutableArray alloc]init];
    self.shop_id = [[NSMutableArray alloc]init];
    self.order_sendfee = [[NSMutableArray alloc]init];
    self.comm_id = [[NSMutableArray alloc]init];
    self.comm_name = [[NSMutableArray alloc]init];
    self.comm_price = [[NSMutableArray alloc]init];
    self.comm_unit = [[NSMutableArray alloc]init];
    self.comm_buy_amount = [[NSMutableArray alloc]init];
    self.commodity_type_array = [[NSMutableArray alloc]init];
    
    self.sum_order_money = 0;
    
    for(int i=0;i<[_order_comm count];i++){
        double sum_money = 0;
        NSMutableArray *temp=[_order_comm objectAtIndex:i];
        ShoppingCartCommodity *s1 = [temp objectAtIndex:0];
        [self.shop_id addObject:s1.shop_id];
        [self.order_sendfee addObject:[NSNumber numberWithInt:0]];
        [self.commodity_type_array addObject:[NSNumber numberWithInt:(int)[temp count]]];
        
        for(int j=0;j<[temp count];j++){
            ShoppingCartCommodity *s = [temp objectAtIndex:j];
            [self.comm_id addObject:s.commodity_id];
            [self.comm_name addObject:s.comm_name];
            [self.comm_price addObject:[NSNumber numberWithDouble:s.comm_price]];
            [self.comm_unit addObject:s.comm_unit];
            [self.comm_buy_amount addObject:[NSNumber numberWithInt:s.buy_amount]];
            
            self.sum_order_money = self.sum_order_money+s.buy_amount*s.comm_price;
            sum_money = sum_money+s.buy_amount*s.comm_price;
            if(s.comm_photo&&![s.comm_photo isEqualToString:@""]){
                [self.comm_pic addObject:s.comm_photo];
            }else{
                [self.comm_pic addObject:@"loading"];
            }
        }
        [self.shop_order_money addObject:[NSNumber numberWithDouble:sum_money]];
    }
    self.label_order_money.text = [NSString stringWithFormat:@"%.2f",self.sum_order_money];
    self.order_state = @"尚未处理";
    self.pay_type = @"支付宝支付";
//    self.order_sendfee = [NSNumber numberWithInt:0];
    
}

#pragma mark----计算送货时间----
-(void)sendDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyy-MM-dd"];
    //解决采用世界时间转换后与实际时间相差8小时的问题
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSDate *cur_date = [[NSDate alloc]init];//获取当前时间
    NSInteger interval = [timeZone secondsFromGMTForDate:cur_date];
    cur_date = [cur_date dateByAddingTimeInterval:interval];
    
    NSString *cur_date_str = [formatter stringFromDate:cur_date];
    NSString *cur_date_str1 = [cur_date_str stringByAppendingString:@" 23:00:00"];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat : @"yyyy-MM-dd HH:mm:ss"];
    NSDate *date2 = [formatter2 dateFromString:cur_date_str1];
    interval = [timeZone secondsFromGMTForDate:date2];
    NSDate *p_date = [date2 dateByAddingTimeInterval:interval];
    
    
    //日期比较
//     NSInteger seconds = [p_date timeIntervalSinceDate:cur_date];//计算时间差秒数
//    long time = (long)seconds;
//    if(time>0){//超过晚上11点下订单，明日送达
//        NSDate *date = [NSDate dateWithTimeInterval:24*60*60 sinceDate:p_date];
//        self.send_time = [formatter stringFromDate:date];
//    }else{
//        self.send_time = cur_date_str;//今日送达
//    }
    self.send_time = cur_date_str;//今日送达
    
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


/*============================================================================*/
/*=======================接入支付宝需要的代码段===================================*/
/*============================================================================*/
NSString *partner = @"2088121360980271";
NSString *seller = @"yly20150501@sina.com";
NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMlMtuJaDMnwpF613+iHgEkaom8Sw42S/KmWsp8Q2DBroOG+sxPk/4sOa3okKIaMFUQgYrj+YiKsS2jZCy43MHfaZXy4QFRr3l9nqQGJFCylRjiUdetiVHeL2uEEBr8LxYaic/je/x3Dv3N+dIKTfVxa8i1WMFdFtnmJxOxB7Oz9AgMBAAECgYBbwZUnbiagMgmqhjqu8nzeVb6u5J2wvcxfvSpkaTgyMg0eeV+FdP+qsgL5pNu4IMhcympVqtauuVySSUTYZx225MJHqfQSY5s3l5hINQDQmOC4DsCUlWmfahjf3K1WK8ujFtc8WkZx12pyVpaFgu7tKYmmhyTRc4AwlLOw6cPVvQJBAPGctR8E1Q1dG3fwqiw2UItacNEYiWbELmR3nAGts0cGVT8rpVefD6c8oKx1gf+ZLAUzKVckl8vRBU1CTq5Z7SMCQQDVSXUUbD9DPWRxSy7paHfUs5k3sRito2xVoq9e1oPT4eadJnu1FCT+UVygv2xnvKo5oYBVo4uB3n6s0jsDca9fAkEA5HzXCCuQs9+eL3IH7GG9D9wKnqL+pZHXcalvfmLfDMbfbSsAZPmGWxhJtm417xrSd2RnrwJrDxNvWR3gvJ9MUwJBALzPanXJ3bcIggJJLB4z/OCunNRQUihko2KrwdOS0uCe+ifkCV8jlhwMqpMi4jRzL74U2ib1wGoXLMyQzu0dlsECQQDreQ3cFuh0tSBA+f4C6r3P2FOGDHJaO3cTuP5tQLHD5bJ2L8y+iqEmgOTc0L9plXBKjBV5z8XOhaNZTpdcqxMR";

#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


/*============================================================================*/
/*============================================================================*/
/*============================================================================*/






#pragma mark----提交订单-----
- (IBAction)SubmitOrderOnclick:(id)sender {
    NSString * order_id = [self generateTradeNO];

    [StatusTool statusToolAddNewOrderInfoWithShopID:self.shop_id CustID:self.cust_id CustName:self.cust_name CustPhone:self.cust_phone OrderMoney:self.shop_order_money OrderSendfee:self.order_sendfee OrderState:self.order_state OrderAddress:self.cust_address PayType:self.pay_type CommID:self.comm_id CommUnit:self.comm_unit CommPrice:self.comm_price CommName:self.comm_name BuyAmount:self.comm_buy_amount CommType:self.commodity_type_array OrderID:order_id Success:^(id object) {
        
//        [UIAlertView showAlertViewWithTitle:@"提示" message:@"订单提交成功" cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:^(int buttonIndex) {
//            
//                        } onCancel:^{
//                            //点取消按钮
//                        [self MotifyShoppingCart];
//            OrderListViewController *OLVC = [OrderListViewController createFromStoryboardName:@"OrderList" withIdentifier:@"order_list"];
//                [self.navigationController pushViewController:OLVC animated:YES];
//                            }];

        /*
         *生成订单信息及签名
         */
        //将商品信息赋予AlixPayOrder的成员变量
        Order *order = [[Order alloc] init];
        order.partner = partner;
        order.seller = seller;
        order.tradeNO = order_id; //订单ID（由商家自行制定）
//        order.productName = self.comm_name[0]; //商品标题
        //测试用
         order.productName = @"mizhixiaopai"; //商品标题
        order.productDescription = @"111"; //商品描述
//        order.amount = [NSString stringWithFormat:@"%@",self.shop_order_money]; //商品价格
//        order.amount = [NSString stringWithFormat:@"%.2f",self.sum_order_money];
        order.amount = @"0.01";

//               NSString *baseurl_string = [API_HOST stringByAppendingString:@"/notify_url.php"];
        NSString *baseurl_string = [API_HOST stringByAppendingString:@"/index.php/Home/Tackle"];
        NSLog(@"^^^^^^^^^baseurl = %@", baseurl_string);
       order.notifyURL = baseurl_string; //回调URL
        // test
//        order.notifyURL = @"http://huaernan.wicp.net/phpAppServer/notify_url.php"; //回调URL

        
        order.service = @"mobile.securitypay.pay";
        order.paymentType = @"1";
        order.inputCharset = @"utf-8";
        order.itBPay = @"30m";//移动支付30分钟时间
        order.showUrl = @"m.alipay.com";
        
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";//CommunityService每个app都有个scheme 用来标记每个app 支付宝回调app信息是会根据这个值回调
        
        //将商品信息拼接成字符串
        NSString *orderSpec = [order description];
        NSLog(@"orderSpec = %@",orderSpec);
        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
        id<DataSigner> signer = CreateRSADataSigner(privateKey);
        NSString *signedString = [signer signString:orderSpec];
        
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            NSLog(@"^^^^^orderstring  =  %@",orderString);
            
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"~~~reslut = %@",resultDic);
            }];
            
        }

        
        
    } failurs:^(NSError *error) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *user_permission = [defaults objectForKey:@"UserPermission"];
        if([user_permission isEqualToString:@""]||[user_permission isEqualToString:@"普通用户"]){
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:hud];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"只有认证用户才能购买商品！";
            [hud showAnimated:YES whileExecutingBlock:^{
                sleep(1);
            }completionBlock:^{
                [hud removeFromSuperview];
            }];
        }else{
            [UIAlertView showAlertViewWithTitle:@"提示" message:@"订单提交失败" cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:^(int buttonIndex) {
                if(buttonIndex==0){
                    //
                }else{
                    //
                }
            } onCancel:^{
                
            }];
        }

        
    }];
    
    
    
//
//    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
//    
//    for(int i=0;i<[_order_comm count];i++){
//        
//
////        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
////        dispatch_async(queue, ^{
//        
//        NSMutableArray *temp = [_order_comm objectAtIndex:i];
//
//        ShoppingCartCommodity *s = [temp objectAtIndex:0];
//        self.shop_id = s.shop_id;
////        self.shop_phone = s.shop_phone;
//        self.order_money = [self.shop_order_money objectAtIndex:i];
////        [_condition lock];
////        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                int result =   [self addMainOrder:temp:resultArray];
//                   [resultArray addObject:[NSNumber numberWithInt:result]];
////               });
////        int result2 =[self addMainOrder:temp];//上传主订单
////        [_condition lock];
////        while (!_isOK) {
////            
////            [_condition wait];
////            
////        }
////        [_condition lock];
//        
// //       [resultArray addObject:[NSNumber numberWithInt:result]];
////        [_condition unlock];
//       
//        
////        if(result2){
////            for(int j=0;j<[temp count];j++){
////                s = [temp objectAtIndex:j];
////                //上传新订单子项
////                self.comm_id = s.commodity_id;
////                self.comm_unit = s.comm_unit;
////                self.comm_price =[NSNumber numberWithDouble:s.comm_price];
////                self.comm_name = s.comm_name;
////                self.comm_buy_amount = [NSNumber numberWithInt:s.buy_amount];
////                int rest = [self addDetailOrder];
////                [resultArray addObject:[NSNumber numberWithInt:rest]];
////            }
////        }
////     });
//        
//    }
//    if([resultArray containsObject:[NSNumber numberWithInt:0]]){
//        [UIAlertView showAlertViewWithTitle:@"提示" message:@"订单提交失败" cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:^(int buttonIndex) {
//                    if(buttonIndex==0){
//                        //
//                    }else{
//                        //
//                    }
//                } onCancel:^{
//                    
//                }];
//    }else{
//        [UIAlertView showAlertViewWithTitle:@"提示" message:@"订单提交成功" cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:^(int buttonIndex) {
//            
//            } onCancel:^{
//                //点取消按钮
//                    [self MotifyShoppingCart];
//                    OrderListViewController *OLVC = [OrderListViewController createFromStoryboardName:@"OrderList" withIdentifier:@"order_list"];
//                    [self.navigationController pushViewController:OLVC animated:YES];
//                }];
//
////        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"订单提交成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
////        [alert show];
    

//    }
    
}


#pragma mark-----修改购物车------
-(void)MotifyShoppingCart{
    //获取路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *file_path = [documentDirectory stringByAppendingPathComponent:
                           ShoppingCartFile];
    //接档，读取文件数据
    NSMutableArray *cart = [[NSMutableArray alloc]init];
    cart = [NSKeyedUnarchiver unarchiveObjectWithFile:file_path];
    
    //删除已购买商品
    for(int i=0;i<[_order_comm count];i++){
        NSMutableArray *order_temp = [[NSMutableArray alloc]init];
        order_temp = [_order_comm objectAtIndex:i];
        ShoppingCartCommodity *s = [ShoppingCartCommodity new];
        for(int j=0;j<[order_temp count];j++){
            s=[order_temp objectAtIndex:j];
            for(int m=0;m<[cart count];m++){
                NSMutableArray *cart_temp = [[NSMutableArray alloc]init];
                cart_temp=[cart objectAtIndex:m];
                for(int n=0;n<[cart_temp count];n++){
                    ShoppingCartCommodity *s1 = [ShoppingCartCommodity new];
                    s1 = [cart_temp objectAtIndex:n];
                if([s1.commodity_id isEqualToString:s.commodity_id]){
                    [cart_temp removeObject:s1];
                    if([cart_temp count]==0){
                        [cart removeObject:cart_temp];
                    }
                    break;
                }
                }
                
            }
        }
    }
    NSMutableArray *cart2 = [NSMutableArray arrayWithArray:cart];
    
    //先删除归档
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager isDeletableFileAtPath:file_path]){
        [fileManager removeItemAtPath:file_path error:nil];
    }
    //再重新添加,保存归档
    bool flag =[NSKeyedArchiver archiveRootObject:cart2 toFile:file_path];
    if(flag){
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已添加到购物车" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
        
    }

    
}




@end
