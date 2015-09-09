//
//  OrderListViewController.m
//  communityiOS
//
//  Created by 何茂馨 on 15/8/24.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListTableViewCell.h"

@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)NSMutableDictionary *orderListArray;
@property(strong,nonatomic) OrderListTableViewCell *OLcell;

@end

@implementation OrderListViewController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.orderListArray count];

}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.OLcell = [tableView dequeueReusableCellWithIdentifier:@"order_cell"];
//    if (self.orderListArray!=nil) {
//        <#statements#>
//    }
//    
//
//}

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

@end
