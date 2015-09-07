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

@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) OrderDetailAddressTableViewCell *ODAddCell;
@property (strong,nonatomic) OrderDetailPicTableViewCell *ODPicCell;
@property (strong,nonatomic) OrderDetailZhifuTableViewCell *ODZhifuCell;


@end

@implementation OrderDetailViewController



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 ) {
        self.ODAddCell = [tableView dequeueReusableCellWithIdentifier:nil];
        
        if (!self.ODAddCell) {
            self.ODAddCell= [[[NSBundle mainBundle]loadNibNamed:@"OrderDetailAddressTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.ODAddCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
               return self.ODAddCell;
    }else if(indexPath.row == 1){
        self.ODPicCell = [tableView dequeueReusableCellWithIdentifier:nil];
        
        if (!self.ODPicCell) {
            self.ODPicCell= [[[NSBundle mainBundle]loadNibNamed:@"OrderDetailPicTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.ODPicCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return self.ODPicCell;
    
    }else{
        self.ODZhifuCell = [tableView dequeueReusableCellWithIdentifier:nil];
        
        if (!self.ODZhifuCell) {
            self.ODZhifuCell= [[[NSBundle mainBundle]loadNibNamed:@"OrderDetailZhifuTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.ODZhifuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return self.ODZhifuCell;
        
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;


}

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)SubmitOrderOnclick:(id)sender {
    [UIAlertView showAlertViewWithTitle:@"提交订单" message:@"确定要提交订单吗？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] onDismiss:^(int buttonIndex) {
        if(buttonIndex==0){
            //去往购物车
        }else{
            //取消
        }
    } onCancel:^{
        
    }];
    
    
}
@end
