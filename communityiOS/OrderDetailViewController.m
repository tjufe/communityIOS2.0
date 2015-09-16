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
@property (strong,nonatomic) NSString *shop_id;
@property (strong,nonatomic) NSString *shop_phone;
@property (strong,nonatomic) NSString *order_state;
@property (strong,nonatomic) NSString *pay_type;
@property (strong,nonatomic) NSNumber *order_sendfee;
@property (strong,nonatomic)NSNumber *order_money;



@property (strong,nonatomic) NSMutableArray *comm_pic;//存放商品图片
@property (strong,nonatomic) NSString *comm_name;
@property (strong,nonatomic) NSString *comm_unit;
@property (strong,nonatomic) NSNumber *comm_price;
@property (strong,nonatomic) NSString *comm_id;
@property (strong,nonatomic) NSNumber *comm_buy_amount;
@property (strong,nonatomic) NSMutableArray *shop_order_money;//主订单金额
@property (strong,nonatomic) NSString *mainorder_id;


@property (assign,nonatomic) double sum_order_money;



@end

@implementation OrderDetailViewController

int result;
int res;

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
            [self.ODPicCell setImg_comm2_url:[self.comm_pic objectAtIndex:2]];
            self.ODPicCell.img_comm1.hidden = NO;
            self.ODPicCell.img_comm2.hidden = NO;
            self.ODPicCell.img_comm3.hidden = NO;
            self.ODPicCell.label_over.hidden = YES;
            self.ODPicCell.label_comm_amount.text = [NSString stringWithFormat:@"%d",3];

        }else{
            [self.ODPicCell setImg_comm1_url:[self.comm_pic objectAtIndex:0]];
            [self.ODPicCell setImg_comm2_url:[self.comm_pic objectAtIndex:1]];
            [self.ODPicCell setImg_comm2_url:[self.comm_pic objectAtIndex:2]];
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
    return 150;


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
-(int)addMainOrder{
    
    
    [OrderInfo AddNewMainOrderInfowithShopID:self.shop_id CustID:self.cust_id CustName:self.cust_name CustPhone:self.cust_phone ShopPhone:@"11222" OrderMoney:self.order_money OrderSendfee:self.order_sendfee OrderState:self.order_state OrderAddress:self.cust_address PayType:self.pay_type Success:^(id object) {
        
        self.mainorder_id = (NSString *)object;
        if(self.mainorder_id){
          result=1;
        }else{
          result = 0;
        }
        
    } failurs:^(NSError *error) {
//        [UIAlertView showAlertViewWithTitle:@"提示" message:@"订单提交失败" cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:^(int buttonIndex) {
//                    if(buttonIndex==0){
//                       //
//                    }else{
//                        //取消
//                    }
//                } onCancel:^{
//                    
//                }];
         result = 0;

    }];
    return result;
}

#pragma mark-----上传订单子项------
-(int)addDetailOrder{
    
    [DetailOrderInfo AddDetailNewOrderInfowithMainorderID:self.mainorder_id CommID:self.comm_id CommUnit:self.comm_unit CommPrice:self.comm_price CommName:self.comm_name BuyAmount:self.comm_buy_amount ShopID:self.shop_id Success:^(id object) {
        
        newPostItem *item = (newPostItem *)object;
        if([item.msg containsString:@"成功"]){
            res = 1;
        }else{
            res = 0;
        }
        
    } failurs:^(NSError *error) {
        res=0;
        
    }];
    
    return res;
}


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
    self.sum_order_money = 0;
    
    for(int i=0;i<[_order_comm count];i++){
        double sum_money = 0;
        NSMutableArray *temp=[_order_comm objectAtIndex:i];
        for(int j=0;j<[temp count];j++){
            ShoppingCartCommodity *s = [temp objectAtIndex:j];
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
    self.order_state = @"已下单";
    self.pay_type = @"货到付款";
    self.order_sendfee = [NSNumber numberWithInt:0];
    
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

#pragma mark----提交订单-----
- (IBAction)SubmitOrderOnclick:(id)sender {
//    [UIAlertView showAlertViewWithTitle:@"提交订单" message:@"确定要提交订单吗？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] onDismiss:^(int buttonIndex) {
//        if(buttonIndex==0){
//            //
//        }else{
//            //取消
//        }
//    } onCancel:^{
//        
//    }];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    
    for(int i=0;i<[_order_comm count];i++){
        
        NSMutableArray *temp =[[NSMutableArray alloc]init];

        temp = [_order_comm objectAtIndex:i];
        ShoppingCartCommodity *s = [temp objectAtIndex:0];
        self.shop_id = s.shop_id;
        self.shop_phone = s.shop_phone;
        self.order_money = [self.shop_order_money objectAtIndex:i];
        int result2 =[self addMainOrder];//上传主订单
        
        if(result2){
            for(int j=0;j<[temp count];j++){
                s = [temp objectAtIndex:j];
                //上传新订单子项
                self.comm_id = s.commodity_id;
                self.comm_unit = s.comm_unit;
                self.comm_price =[NSNumber numberWithDouble:s.comm_price];
                self.comm_name = s.comm_name;
                self.comm_buy_amount = [NSNumber numberWithInt:s.buy_amount];
                int rest = [self addDetailOrder];
                [resultArray addObject:[NSNumber numberWithInt:rest]];
            }
        }
        
        
    }
    if([resultArray containsObject:[NSNumber numberWithInt:0]]){
        [UIAlertView showAlertViewWithTitle:@"提示" message:@"订单提交失败" cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:^(int buttonIndex) {
                    if(buttonIndex==0){
                        //
                    }else{
                        //
                    }
                } onCancel:^{
                    
                }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"订单提交成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        //前往订单列表页
        OrderListViewController *OLVC = [OrderListViewController createFromStoryboardName:@"OrderList" withIdentifier:@"order_list"];
        [self.navigationController pushViewController:OLVC animated:YES];


    }
    
}
@end
