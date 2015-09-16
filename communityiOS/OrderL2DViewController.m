//
//  OrderL2DViewController.m
//  communityiOS
//
//  Created by 何茂馨 on 15/9/15.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "OrderL2DViewController.h"

#import "OrderInfo.h"
#import "DetailOrderInfo.h"
#import "OrderDetailAddressTableViewCell.h"
#import "OrderDetailZhifuTableViewCell.h"
#import "OrderL2DTableViewCell.h"

@interface OrderL2DViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)OrderInfo * order_info;
@property (strong,nonatomic)NSMutableArray * DetailListArray;



@end

@implementation OrderL2DViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.DetailListArray.count + 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row ==0) {
        OrderDetailAddressTableViewCell *ODATVCell = [tableView dequeueReusableCellWithIdentifier:nil];
        if(! ODATVCell){
            ODATVCell =[[[NSBundle mainBundle] loadNibNamed:@"OrderDetailAddressTableViewCell" owner:nil options:nil] objectAtIndex:0];
        }

//        DetailOrderInfo *detail_order_info = [self.DetailListArray objectAtIndex:indexPath.row];
        [ODATVCell setL_phone:self.order_info.user_phone];
        [ODATVCell setL_address:self.order_info.address];
        [ODATVCell setL_name:self.order_info.cust_name];
        return ODATVCell;
        
    }else if (indexPath.row==1){
        OrderDetailZhifuTableViewCell *ODZFCell = [tableView dequeueReusableCellWithIdentifier:nil];
        
        if(! ODZFCell){
            ODZFCell =[[[NSBundle mainBundle] loadNibNamed:@"OrderDetailZhifuTableViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        [ODZFCell setL_send_date:self.order_info.order_date];
        return ODZFCell;
    
    
    }else{
        
        DetailOrderInfo *detail_order_info = [self.DetailListArray objectAtIndex:indexPath.row-2];

        OrderL2DTableViewCell *OL2DCell = [tableView dequeueReusableCellWithIdentifier:@"order_L2D"];
        
        if(! OL2DCell){
            OL2DCell =[[[NSBundle mainBundle] loadNibNamed:@"OrderL2DTableViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        [OL2DCell setOrder_date:self.order_info.order_date];
        [OL2DCell setComm_pic_url:detail_order_info.comm_pic];
        [OL2DCell setComm_name:detail_order_info.commodity_name];
        [OL2DCell setComm_price:[NSString stringWithFormat:@"%.2f",detail_order_info.comm_price]];
        [OL2DCell setComm_unit:detail_order_info.comm_unit];
        [OL2DCell setBuy_count:[NSString stringWithFormat:@"%d",detail_order_info.buy_amount]];
        
        return OL2DCell;
        
    
    
    
    }
    

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;
}

-(void)getOrderInfo:(OrderInfo *)order_info{
    
    self.order_info = order_info;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.DetailListArray = [[NSMutableArray alloc]init];
    for(NSDictionary *dic in self.order_info.detail_order_list ){
        DetailOrderInfo *DOI = [DetailOrderInfo initWithparametes:dic];
        [self.DetailListArray addObject:DOI];
    }
    
    // Do any additional setup after loading the view.
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
