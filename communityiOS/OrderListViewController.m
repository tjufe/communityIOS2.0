//
//  OrderListViewController.m
//  communityiOS
//
//  Created by 何茂馨 on 15/8/24.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListTableViewCell.h"
#import "OrderList.h"
#import "OrderInfo.h"
#import "DetailOrderInfo.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "UIAlertView+Blocks.h"
#import "RatingBar.h"
#import "StatusTool.h"
#import "EstimateListViewController.h"
#import "UIViewController+Create.h"

@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)NSMutableArray *orderListArray;
@property(strong,nonatomic)NSMutableArray *orderList;
@property(strong,nonatomic)NSMutableArray *DetailOrderList;
@property(strong,nonatomic) OrderListTableViewCell *OLcell;
@property(strong,nonatomic)OrderInfo *OrderInfo;
@property(weak,nonatomic)NSNumber *page;
@property(weak,nonatomic)NSNumber *rows;
@property(weak,nonatomic)NSString *shop_id;
@property (strong,nonatomic)UIView *maskView;
@property (strong,nonatomic)UIView *assessView;
@property (strong,nonatomic)RatingBar *ratingBar;

@property (strong,nonatomic)NSString *evaluateStr;

@property (strong,nonatomic)UITextField *messageField;
@end

NSInteger page1 ;//页数
NSInteger rows1 ;//分页请求行数
int mend_score1 = 0;
BOOL FirstLoad ;

@implementation OrderListViewController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.orderListArray count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.OLcell = [tableView dequeueReusableCellWithIdentifier:@"order_cell"];
    if (!self.OLcell) {
        self.OLcell = [[[NSBundle mainBundle]loadNibNamed:@"OrderListTableViewCell" owner:nil options:nil]objectAtIndex:0];
    }
    self.OrderInfo = [self.orderListArray objectAtIndex:indexPath.row];
    for(NSDictionary *dic in self.OrderInfo.detail_order_list ){
        DetailOrderInfo *detail_order_info = [DetailOrderInfo initWithparametes:dic];
        [self.DetailOrderList addObject:detail_order_info];
    }
    switch ([self.DetailOrderList count]) {
        case 1:{
            self.OLcell.CommPic2.hidden = YES;
            self.OLcell.CommPic3.hidden = YES;
            self.OLcell.CommPicMore.hidden = YES;
            DetailOrderInfo *detail_order_info = [self.DetailOrderList objectAtIndex:0];
            [self.OLcell makeCommPic1:detail_order_info.comm_pic];
        }
            break;
        case 2:{
            self.OLcell.CommPic3.hidden = YES;
            self.OLcell.CommPicMore.hidden = YES;
            DetailOrderInfo *detail_order_info = [self.DetailOrderList objectAtIndex:0];
            [self.OLcell makeCommPic1:detail_order_info.comm_pic];
            DetailOrderInfo *detail_order_info2 = [self.DetailOrderList objectAtIndex:1];
            [self.OLcell makeCommPic1:detail_order_info2.comm_pic];
        }
            break;
        case 3:{
            
            self.OLcell.CommPicMore.hidden = YES;
            DetailOrderInfo *detail_order_info = [self.DetailOrderList objectAtIndex:0];
            [self.OLcell makeCommPic1:detail_order_info.comm_pic];
            DetailOrderInfo *detail_order_info2 = [self.DetailOrderList objectAtIndex:1];
            [self.OLcell makeCommPic1:detail_order_info2.comm_pic];
            DetailOrderInfo *detail_order_info3 = [self.DetailOrderList objectAtIndex:2];
            [self.OLcell makeCommPic1:detail_order_info3.comm_pic];
        }
            break;
            
        default:{
            DetailOrderInfo *detail_order_info = [self.DetailOrderList objectAtIndex:0];
            [self.OLcell makeCommPic1:detail_order_info.comm_pic];
            DetailOrderInfo *detail_order_info2 = [self.DetailOrderList objectAtIndex:1];
            [self.OLcell makeCommPic1:detail_order_info2.comm_pic];
            DetailOrderInfo *detail_order_info3 = [self.DetailOrderList objectAtIndex:2];
            [self.OLcell makeCommPic1:detail_order_info3.comm_pic];
        }
            break;
    }
    [self.OLcell makeShopHead:self.OrderInfo.shop_head];
    [self.OLcell makeShopName:self.OrderInfo.shop_name];
    [self.OLcell makeOrderPrice:[NSString stringWithFormat:@"%.2f",self.OrderInfo.order_money]];
    [self.OLcell makeOrderState:self.OrderInfo.order_state];
    //暂时不加删除功能
    self.OLcell.OrderDeleteBt.hidden = YES;
//    [self.OLcell.OrderDeleteBt addTarget:self action:@selector(DeleteOrder) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.OrderInfo.order_state isEqualToString:@"尚未处理"]) {
        self.OLcell.OrderDeleteBt.hidden = YES;
        self.OLcell.toEstimateBt.hidden = YES;
    }else if([self.OrderInfo.order_state isEqualToString:@"已发送"]){
        [self.OLcell.toEstimateBt setTitle:@"确认收货" forState:UIControlStateNormal];
        [self.OLcell.toEstimateBt addTarget:self action:@selector(EnsureOrder) forControlEvents:UIControlEventTouchUpInside];
        self.OLcell.toEstimateBt.hidden = YES;
    
    }else{
        [self.OLcell.toEstimateBt setTitle:@"去评论" forState:UIControlStateNormal];
        [self.OLcell.toEstimateBt addTarget:self action:@selector(toEstimate:) forControlEvents:UIControlEventTouchUpInside];
        [self.OLcell.toEstimateBt setTag:indexPath.row];
        
        
    }
    
    return self.OLcell;

}

//-(void)DeleteOrder{
//    [UIAlertView showAlertViewWithTitle:@"提示" message:@"您确定要删除该订单吗？" cancelButtonTitle:@"取消" otherButtonTitles:@"确定" onDismiss:^(int buttonIndex) {
//        if(buttonIndex==0){
//            //
//            
//        }else{
//            //
//            
//            self.OrderInfo.order_state = @"已删除";
////            [self]
//        }
//    } onCancel:^{
//        
//    }];
//
//    
//
//
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    


}

-(void)EnsureOrder{
    [StatusTool statusToolEnsureOrderWithOrder_id:self.OrderInfo.order_id Success:^(id object) {
        [self.OLcell.OrderState setText:@"已完成"];
        [self.OLcell.toEstimateBt setTitle:@"去评价" forState:UIControlStateNormal];
        [self.OLTableview reloadData];
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        [self.view addSubview:hud];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"确认成功！";
        [hud showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        }completionBlock:^{
            [hud removeFromSuperview];
        }];
        
    } failurs:^(NSError *error) {
        
    }];


}

-(void)toEstimate:(id)sender{
    //添加蒙版
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.3;
    [self.view addSubview:self.maskView];
    //评价的对话框
    self.assessView =[[UIView alloc]init];
    self.assessView.frame = CGRectMake(self.OLTableview.center.x-150, self.view.frame.size.height, 300, 220);
    self.assessView.alpha = 0;
    self.assessView.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.3 animations:^{
        self.assessView.alpha = 1;
        self.assessView.frame = CGRectMake(self.view.center.x - 150, self.view.center.y - 150, 300, 220);
        [self.assessView.layer setCornerRadius:self.assessView.frame.size.height/20];
    }];
    [self.view addSubview:self.assessView];
    
    //推送
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 100, 30)];
    title.text = @"结束报修";
    title.textColor = [UIColor redColor];
    title.font = [UIFont fontWithName:@"STHeitiTC-Light" size:18];
    [self.assessView addSubview:title];
    //红线1
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 300, 2)];
    [vi setBackgroundColor:[UIColor redColor]];
    [self.assessView  addSubview:vi];
    
    //第一行文字
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 100, 70)];
    tlabel.text = @"给该店铺打分:";
    tlabel.adjustsFontSizeToFitWidth = YES;
    tlabel.textAlignment = NSTextAlignmentLeft;
    tlabel.lineBreakMode = UILineBreakModeWordWrap;
    tlabel.numberOfLines = 0;
    tlabel.textColor = [UIColor grayColor];
    tlabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17];
    [self.assessView addSubview:tlabel];
    
//    //第一行评价语句
//    self.assessLabel = [[UILabel alloc]initWithFrame:CGRectMake(tlabel.frame.origin.x+tlabel.frame.size.width+15, 65, 130, 15)];
//    self.assessLabel.text = @"非常满意";
//    self.assessLabel.textColor = [UIColor grayColor];
//    self.assessLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:14];
//    [self.assessView addSubview:self.assessLabel];
    
    //星星
    self.ratingBar = [[RatingBar alloc] initWithFrame:CGRectMake(tlabel.frame.origin.x+tlabel.frame.size.width-16, tlabel.frame.origin.y+tlabel.frame.size.height+10, 180, 35) WithStarAmount:5];
    self.ratingBar.starNumber = 5;
    [self.assessView addSubview:self.ratingBar];
    
    //红线2
    UIView *vii = [[UIView alloc]initWithFrame:CGRectMake(0, self.ratingBar.frame.origin.y+self.ratingBar.frame.size.height+5, 300, 1)];
    [vii setBackgroundColor:[UIColor lightGrayColor]];
    vii.alpha = 0.7;
    [self.assessView  addSubview:vii];
    
    //第二行文字
    UILabel *flabel = [[UILabel alloc]initWithFrame:CGRectMake(10, vii.frame.origin.y+vii.frame.size.height+13, 100, 35)];
    flabel.text = @"请给我们留言:";
    flabel.textAlignment = UITextAlignmentLeft;
    flabel.numberOfLines = 0;
    flabel.lineBreakMode = UILineBreakModeWordWrap;
    flabel.textColor = [UIColor grayColor];
    flabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17];
    [self.assessView addSubview:flabel];
    //留言文本框
    self.messageField = [[UITextField alloc]init];
    self.messageField.frame = CGRectMake(flabel.frame.origin.x+flabel.frame.size.width, flabel.frame.origin.y, 180, 30);
    self.messageField.delegate = self;
    [self.messageField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    // messageField.backgroundColor = [UIColor lightGrayColor];
    [self.assessView addSubview:self.messageField];
    //留言框黑线
    UIView *textLine = [[UIView alloc]initWithFrame:CGRectMake(flabel.frame.origin.x+flabel.frame.size.width, self.messageField.frame.origin.y+self.messageField.frame.size.height+5, 180, 0.5)];
    [textLine setBackgroundColor:[UIColor blackColor]];
    [self.assessView  addSubview:textLine];
    
    //红线3
    UIView *viii = [[UIView alloc]initWithFrame:CGRectMake(0, flabel.frame.origin.y+flabel.frame.size.height+10, 300, 1)];
    [viii setBackgroundColor:[UIColor lightGrayColor]];
    viii.alpha = 0.7;
    [self.assessView  addSubview:viii];
    
    //按钮
    UIButton *sureBtn = [[UIButton alloc]init];
    sureBtn .frame = CGRectMake(10, viii.frame.origin.y+viii.frame.size.height+5, 135, 30);
    [sureBtn setTitle: @"确定" forState: UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    sureBtn.backgroundColor = [UIColor lightGrayColor];
    sureBtn.alpha = 0.8;
    [sureBtn.layer setMasksToBounds:YES];
    [sureBtn.layer setCornerRadius:5.0];
    [sureBtn addTarget:self action:@selector(assessAndClose:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTag:[sender tag]];
    
    
    [self.assessView addSubview:sureBtn];
    UIButton *cancelBtn = [[UIButton alloc]init];
    cancelBtn.frame = CGRectMake(sureBtn.frame.origin.x+sureBtn.frame.size.width+10, viii.frame.origin.y+viii.frame.size.height+5, 135, 30);
    [cancelBtn setTitle: @"取消" forState: UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor lightGrayColor];
    cancelBtn.alpha = 0.8;
    [cancelBtn.layer setMasksToBounds:YES];
    [cancelBtn.layer setCornerRadius:5.0];
    [cancelBtn addTarget:self action:@selector(justClose) forControlEvents:UIControlEventTouchUpInside];
    [self.assessView addSubview:cancelBtn];

}

-(void)textFieldEditChanged:(UITextField *)textField{
    
    self.evaluateStr = textField.text;
}

-(void)assessAndClose:(id)sender{
    self.OrderInfo = [self.orderListArray objectAtIndex:[sender tag]];
    //发表评论
    [StatusTool statusToolAddNewEstimateWithShop_id:self.OrderInfo.shop_id Content:self.evaluateStr Score:[NSString stringWithFormat:@"%d",mend_score1] User_id:self.OrderInfo.cust_id  Success:^(id object) {
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        [self.view addSubview:hud];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"评论成功！";
        [hud showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        }completionBlock:^{
            [hud removeFromSuperview];
            
            EstimateListViewController *ELVC  =[EstimateListViewController createFromStoryboardName:@"EstimateList" withIdentifier:@"estimate_list"];
            [self.navigationController pushViewController:ELVC animated:YES];
            
        }];
    } failurs:^(NSError *error) {
        
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderList = [[NSMutableArray alloc]init];
    self.orderListArray = [[NSMutableArray alloc]init];
    self.DetailOrderList =[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    
    //注册通知  ，用于用户评价时点击星星
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLabelText:) name:@"ChangeLabelTextNotification" object:nil];
    
    page1 = 1;
    rows1 = 10;
    FirstLoad = true;
    //导航栏
    self.navigationItem.title = @"店铺评价";
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    //设置上拉刷新
    
    [self setupRefresh];
    [self loadData];
}

-(void)footerReresh21{
    
    page1++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //          [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [self loadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.OLTableview footerEndRefreshing];
    });
    
}


-(void)setupRefresh{
    //waring自动刷新
    //   [self.pltable headerBeginRefreshing];
    //上拉加载更多
    [self.OLTableview addFooterWithTarget:self action:@selector(footerReresh21)];
}
-(void)loadData{
    
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.page = [NSNumber numberWithInteger:page1];
    self.rows = [NSNumber numberWithInteger:rows1];
    [OrderList LoadOrderListWithCustID:self.OrderInfo.cust_id page:self.page rows:self.rows Success:^(id object) {
        self.orderList = (NSMutableArray *)object;
        
        if(self.orderList!=nil){
            
            for (int i=0; i<[self.orderList count]; i++) {
                self.OrderInfo = [self.orderList objectAtIndex:i];
                if(FirstLoad){//第一次加载
                    [self.orderListArray addObject:self.OrderInfo];
                    
                    
                }else{ //上拉刷新
                    if(![self.orderListArray containsObject:self.OrderInfo]){//去重
                        [self.orderListArray addObject:self.OrderInfo];
                    }
                }
            }
            FirstLoad = false;
            [self.OLTableview reloadData];
        }else{
            if(FirstLoad){
                //    self.table.hidden = YES;
                [self.OLTableview reloadData];
            }else{//刷新完成，已无更多
                page1--;
                //提示
                MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
                [self.view addSubview:hud];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"没有更多内容了！";
                [hud showAnimated:YES whileExecutingBlock:^{
                    sleep(1);
                }completionBlock:^{
                    [hud removeFromSuperview];
                }];
                
                
            }
        }

    } failurs:^(NSError *error) {
        
    }];
    
    
}

-(void)changeLabelText:(NSNotification *)notification{
    
    id score = notification.object;
    mend_score1 = [score intValue];

    
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
