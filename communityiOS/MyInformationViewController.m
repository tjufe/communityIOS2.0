//
//  MyInformationViewController.m
//  communityiOS
//
//  Created by 何茂馨 on 15/9/18.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "MyInformationViewController.h"
#import "MyInformationTableViewCell.h"

@interface MyInformationViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)MyInformationTableViewCell *MICell;

@end

@implementation MyInformationViewController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    self.MICell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!self.MICell){
        self.MICell = [[[NSBundle mainBundle] loadNibNamed:@"MyInformationTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    //赋值
    
    return self.MICell;
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
