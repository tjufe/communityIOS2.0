//
//  EstimateListViewController.m
//  communityiOS
//
//  Created by 何茂馨 on 15/9/9.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "EstimateListViewController.h"
#import "EstimateTableViewCell.h"
#import "EstimateInfo.h"

#import "Estimatelist.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"

@interface EstimateListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *EstTableView;
@property(strong ,nonatomic)NSMutableArray * EstimateArray;
@property(strong ,nonatomic)NSMutableArray * EstimateList;
@property(strong ,nonatomic)EstimateInfo * EstimateInfo;

@property(strong ,nonatomic)EstimateTableViewCell * EstimateCell;
@property(weak,nonatomic)NSNumber *page;
@property(weak,nonatomic)NSNumber *rows;
@property(weak,nonatomic)NSString *shop_id;

@end
float cell_height=0;
NSInteger page1 ;//页数
NSInteger rows1 ;//分页请求行数
BOOL FirstLoad ;


@implementation EstimateListViewController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.EstimateArray count];
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.EstimateCell = [self.EstTableView dequeueReusableCellWithIdentifier:@"estimate_cell"];
    self.EstimateCell = [tableView dequeueReusableCellWithIdentifier:@"estimate_cell"];
    
    if(! self.EstimateCell){
         self.EstimateCell =[[[NSBundle mainBundle] loadNibNamed:@"EstimateTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    EstimateInfo *estimate_info = [self.EstimateArray objectAtIndex:indexPath.row];
    
    [self.EstimateCell MakeCustHead:estimate_info.user_head ];
    [self.EstimateCell MakeCustName:estimate_info.user_name];
    [self.EstimateCell MakeEstimateTime:estimate_info.estimate_date];
    [self.EstimateCell MakeEstimateContent:estimate_info.content];
//    [self.EstimateCell MakeBuyDate:estimate_info.buy_date];
    switch (estimate_info.score) {
        case 1:
            self.EstimateCell.EstimateStar2.hidden = YES;
            self.EstimateCell.EstimateStar3.hidden = YES;
            self.EstimateCell.EstimateStar4.hidden = YES;
            self.EstimateCell.EstimateStar5.hidden = YES;
            break;
        case 2:
            self.EstimateCell.EstimateStar3.hidden = YES;
            self.EstimateCell.EstimateStar4.hidden = YES;
            self.EstimateCell.EstimateStar5.hidden = YES;
            break;
        case 3:
            self.EstimateCell.EstimateStar4.hidden = YES;
            self.EstimateCell.EstimateStar5.hidden = YES;
            break;
        case 4:
            self.EstimateCell.EstimateStar5.hidden = YES;
            break;
        case 5:
            break;
        default:
            break;
    }
    
    //改变cell的高度需要reload该cell
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.EstimateCell.EstimateContent.text sizeWithFont:self.EstimateCell.EstimateContent.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    cell_height = labelSize.height+150;
    
    return self.EstimateCell;
    

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cell_height;

}

-(void)shopID:(NSString *)shop_id{

    self.shop_id =shop_id;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.EstimateList = [[NSMutableArray alloc]init];
    self.EstimateArray = [[NSMutableArray alloc]init];
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

-(void)setupRefresh{
    //waring自动刷新
    //   [self.pltable headerBeginRefreshing];
    //上拉加载更多
    [self.EstTableView addFooterWithTarget:self action:@selector(footerReresh20)];
}

-(void)footerReresh20{
    
    page1++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //          [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [self loadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.EstTableView footerEndRefreshing];
    });
    
}

-(void)loadData{
    
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.page = [NSNumber numberWithInteger:page1];
    self.rows = [NSNumber numberWithInteger:rows1];
    [Estimatelist LoadEstimateListWithShopID:self.shop_id page:self.page rows:self.rows Success:^(id object) {
        self.EstimateList = (NSMutableArray *)object;
        
        if(self.EstimateList!=nil){
            
            for (int i=0; i<[self.EstimateList count]; i++) {
                self.EstimateInfo = [self.EstimateList objectAtIndex:i];
                if(FirstLoad){//第一次加载
                    [self.EstimateArray addObject:self.EstimateInfo];
                    
                    
                }else{ //上拉刷新
                    if(![self.EstimateArray containsObject:self.EstimateInfo]){//去重
                        [self.EstimateArray addObject:self.EstimateInfo];
                    }
                }
            }
            FirstLoad = false;
            [self.EstTableView reloadData];
        }else{
            if(FirstLoad){
                //    self.table.hidden = YES;
                [self.EstTableView reloadData];
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
