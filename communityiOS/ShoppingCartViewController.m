//
//  ShoppingCartViewController.m
//  communityiOS
//
//  Created by tjufe on 15/6/17.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCart2TableViewCell.h"
#import "ShoppingCartTableViewCell.h"

@interface ShoppingCartViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *sc_table;

@property (strong,nonatomic) ShoppingCartTableViewCell *sc_table_cell1;
@property (strong,nonatomic) ShoppingCart2TableViewCell *sc_table_cell2;


@end

@implementation ShoppingCartViewController

#pragma mark-----tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0){
        self.sc_table_cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(!self.sc_table_cell1){
            self.sc_table_cell1 = [[[NSBundle mainBundle]loadNibNamed:@"ShoppingCartTableViewCell" owner:nil options:nil]objectAtIndex:0];
            
        }
        return self.sc_table_cell1;
        
    }else{
        self.sc_table_cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if(!self.sc_table_cell2){
            self.sc_table_cell2 = [[[NSBundle mainBundle]loadNibNamed:@"ShoppingCart2TableViewCell" owner:nil options:nil]objectAtIndex:0];
            
        }
        return self.sc_table_cell2;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 50;
    }else{
        return 150;
    }
}

//tableview头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    headView.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1];
    return headView;
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

@end
