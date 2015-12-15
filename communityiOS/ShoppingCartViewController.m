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
#import "ShoppingCartCommodity.h"
#import "String.h"
#import "OrderDetailViewController.h"
#import "UIViewController+Create.h"
#import "UIAlertView+Blocks.h"
#import "MBProgressHUD.h"

@interface ShoppingCartViewController () <UITableViewDataSource,UITableViewDelegate,ShoppingCart2TableViewCellDelegate,ShoppingCartTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *sc_table;
@property (weak, nonatomic) IBOutlet UILabel *label_total;
@property (weak, nonatomic) IBOutlet UILabel *label_total_price;
@property (weak, nonatomic) IBOutlet UILabel *label_comm_count;
@property (weak, nonatomic) IBOutlet UIImageView *img_select_all;

@property (weak, nonatomic) IBOutlet UIButton *btn_del;
@property (weak, nonatomic) IBOutlet UIButton *btn_calcu;

@property (strong,nonatomic) ShoppingCartTableViewCell *sc_table_cell1;
@property (strong,nonatomic) ShoppingCart2TableViewCell *sc_table_cell2;
@property (strong,nonatomic) NSString *save_path;//保存用户购物车文件地址
@property (strong,nonatomic) NSMutableArray *shopping;//存放读取的购物车信息
@property (strong,nonatomic) NSMutableArray *cart_shop;
@property (strong,nonatomic) NSMutableArray *cart3;

@end

@implementation ShoppingCartViewController

double total_price;//总金额
int m;
int n;
bool comm_select;//全选状态

bool edit_flag;//编辑状态


#pragma mark----删除购物车商品------
- (IBAction)Btn2deleteComm:(id)sender {
    [UIAlertView showAlertViewWithTitle:@"提示" message:@"删除选择的商品？" cancelButtonTitle:@"删除" otherButtonTitles:@[@"取消"] onDismiss:^(int buttonIndex) {

        } onCancel:^{
        //
 //       if(buttonIndex==0){//删除
            
            NSMutableArray *se_array = [[NSMutableArray alloc]init];
            ShoppingCartCommodity *se_comm = [ShoppingCartCommodity new];
            for(int i=(int)([self.shopping count]-1);i>=0;i--){
                se_array = [self.shopping objectAtIndex:i];
                for(int j=(int)([se_array count]-1);j>=0;j--){
                    se_comm = [se_array objectAtIndex:j];
                    if(se_comm.select_status==1){//选中
                        [se_array removeObject:se_comm];
                    }
                }
                if([se_array count]==0){
                    [self.shopping removeObject:se_array];
                }
            }
            if([self.shopping count]>0){
            m=(int)[self.shopping count]-1;
            [self.sc_table reloadData];
            }else{
                self.sc_table.hidden = YES;
            }
            //检测是否所有商品全选
            [self checkSelect];
            //计算金额
            [self calculateTotalPrice];

            
 //       }
    }];
    
}




#pragma mark-----跳转到提交订单页-----
- (IBAction)Btn2sumbitOrders:(id)sender {
    //跳转到提交订单结算页
   
     NSMutableArray *order =[[NSMutableArray alloc]init];
    for(int i=0;i<[self.shopping count];i++){
        NSMutableArray *order_comm = [[NSMutableArray alloc]init];

        NSMutableArray *temp = [self.shopping objectAtIndex:i];
        for (int j=0; j<[temp count]; j++) {
                        ShoppingCartCommodity *s = [temp objectAtIndex:j];
            if(s.select_status==1){//已选中
                [order_comm addObject:s];
            }
        }
        //wangyao 不选点结算就蹦
        if (order_comm.count!=0) {
            [order addObject:order_comm];
        }
    }
    if (order.count!=0) {
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
            OrderDetailViewController *ODVC = [OrderDetailViewController createFromStoryboardName:@"OrderDetail" withIdentifier:@"order_detail"];
            ODVC.order_comm = order;
            [self.navigationController pushViewController:ODVC animated:YES];
        }
        
    }else{
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        [self.view addSubview:hud];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请选择购买的商品！";
        [hud showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        }completionBlock:^{
            [hud removeFromSuperview];
        }];
    }

}

#pragma mark-----实现协议中选中一个section商品的方法----
-(void)selectCommInSection:(UITableViewCell *)cell{
    NSIndexPath *index = [self.sc_table indexPathForCell:cell];
    NSMutableArray *se_array = [self.shopping objectAtIndex:index.section];
    ShoppingCartTableViewCell *scell1 = (ShoppingCartTableViewCell*)cell;
    for(int i=0;i<[se_array count];i++){
        ShoppingCartCommodity *s=[se_array objectAtIndex:i];
        if(scell1.sel_status==0){
            s.select_status = 1;
        }else{
            s.select_status = 0;
        }
    }
    //刷新一个section
//    m=(int)index.section;
//    NSIndexSet *index_set = [NSIndexSet indexSetWithIndex:index.section];
//    [self.sc_table reloadSections:index_set withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.sc_table reloadData];
    //检测是否所有商品全选
     [self checkSelect];
    //计算金额
    [self calculateTotalPrice];
    
}

#pragma mark-----实现协议中的商品选中的方法-----
-(void)selectComm:(UITableViewCell *)cell{
    NSIndexPath *index = [self.sc_table indexPathForCell:cell];
    NSMutableArray *se_array = [self.shopping objectAtIndex:index.section];
    ShoppingCartCommodity *se_comm = [se_array objectAtIndex:index.row-1];
    ShoppingCart2TableViewCell *scell2 = (ShoppingCart2TableViewCell*)cell;
    if(scell2.comm.select_status==0){
//        scell2.comm.select_status=1;
//        scell2.img_select_comm.image = [UIImage imageNamed:@"delect"];
        se_comm.select_status = 1;
        
    }else{
//        scell2.comm.select_status=0;
//        scell2.img_select_comm.image = [UIImage imageNamed:@"未选择"];
        se_comm.select_status = 0;
    }
    
    
//    NSMutableArray *flag = [[NSMutableArray alloc]init];
//    for(int i=0;i<[se_array count];i++){
//        ShoppingCartCommodity *s = [se_array objectAtIndex:i];
//        if(s.select_status == 1){
//            [flag addObject:@"选中"];
//        }else{
//            [flag addObject:@"未选中"];
//        }
//    }
//    if(![flag containsObject:@"未选中"]){//全选了
//        NSIndexPath *index2 = [NSIndexPath indexPathForRow:0 inSection:index.section];
//        ShoppingCartTableViewCell *scell1 = (ShoppingCartTableViewCell *)[self.sc_table cellForRowAtIndexPath:index2];
//        
//            scell1.sel_status=1;
////            scell1.img_select_shop.image= [UIImage imageNamed:@"delect"];
//
//        //刷新一个section
//        NSIndexSet *index_set = [NSIndexSet indexSetWithIndex:index.section];
//        [self.sc_table reloadSections:index_set withRowAnimation:UITableViewRowAnimationAutomatic];
//    }else if (![flag containsObject:@"选中"]){//全没选
//        NSIndexPath *index2 = [NSIndexPath indexPathForRow:0 inSection:index.section];
//        ShoppingCartTableViewCell *scell1 = (ShoppingCartTableViewCell *)[self.sc_table cellForRowAtIndexPath:index2];
//            scell1.sel_status=0;
// //           scell1.img_select_shop.image= [UIImage imageNamed:@"未选择"];
//        
        //刷新一个section
//        m=(int)index.section;
//        NSIndexSet *index_set = [NSIndexSet indexSetWithIndex:index.section];
//        [self.sc_table reloadSections:index_set withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
//    }else{
       [self.sc_table reloadData];
//    }
    
       //检测是否所有商品全选
       [self checkSelect];
       //计算金额
       [self calculateTotalPrice];
    
}

#pragma mark-----实现协议中改变商品数量的方法------
-(void)changeAmount:(UITableViewCell *)cell Flag:(int)tag{
    NSIndexPath *index = [self.sc_table indexPathForCell:cell];
    NSMutableArray *se_array = [self.shopping objectAtIndex:index.section];
    ShoppingCartCommodity *se_comm = [se_array objectAtIndex:index.row-1];
    if(tag == 0){//减少数量
        se_comm.buy_amount = se_comm.buy_amount-1;
        if(se_comm.buy_amount==0){//数量为0了，从购物车删去
            [se_array removeObject:se_comm];
            if([se_array count]==0){
                [self.shopping removeObject:se_array];
            }
         }
    }else{
        se_comm.buy_amount = se_comm.buy_amount+1;
    }
    //刷新一行
//    NSArray *indexArrary = [NSArray arrayWithObjects:index,nil];
//    [self.sc_table reloadRowsAtIndexPaths:indexArrary withRowAnimation:UITableViewRowAnimationAutomatic];
    if([self.shopping count]>0){
m=(int)[self.shopping count]-1;
        [self.sc_table reloadData];
    }else{
        self.sc_table.hidden = YES;
    }
    //计算金额
    [self calculateTotalPrice];
}


#pragma mark-----计算选中商品总额------
-(void)calculateTotalPrice{
    int count = 0;
    total_price = 0;
    NSMutableArray *comm_array = [[NSMutableArray alloc]init];
    ShoppingCartCommodity *comm = [[ShoppingCartCommodity alloc]init];
    for(int i=0;i<[self.shopping count];i++){
        comm_array = [self.shopping objectAtIndex:i];
        for(int j=0;j<[comm_array count];j++){
            comm = [comm_array objectAtIndex:j];
            if(comm.select_status==1){
                 count=count+1;
                 total_price = total_price+comm.buy_amount*comm.comm_price;
            }
        }
    }
    self.label_comm_count.text = [NSString stringWithFormat:@"%d",count];
    self.label_total.text = [NSString stringWithFormat:@"%.2f",total_price];
    self.label_total_price.text = [NSString stringWithFormat:@"%.2f",total_price];
}

#pragma mark-----tableview delegate-----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"^^^^^%lu",(unsigned long)[self.shopping count]);
    m=(int)[self.shopping count]-1;
    return [self.shopping count];
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(m>=0){
        self.cart_shop = [self.shopping objectAtIndex:m];
        n=(int)[self.cart_shop count]+1;
        m=m-1;
        
    }
    NSLog(@"^^^^^%lu",(unsigned long)[self.cart_shop count]+1);
    return n;
 
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 //   self.cart_shop = [self.shopping objectAtIndex:indexPath.section];
    
    if(indexPath.row==0){
        self.cart_shop = [self.shopping objectAtIndex:indexPath.section];
        self.sc_table_cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(!self.sc_table_cell1){
            self.sc_table_cell1 = [[[NSBundle mainBundle]loadNibNamed:@"ShoppingCartTableViewCell" owner:nil options:nil]objectAtIndex:0];
            
            
        }
        
        NSMutableArray *flag = [[NSMutableArray alloc]init];
           for(int i=0;i<[self.cart_shop count];i++){
                ShoppingCartCommodity *s = [self.cart_shop objectAtIndex:i];
                  if(s.select_status == 1){
                     [flag addObject:@"选中"];
                  }else{
                     [flag addObject:@"未选中"];
                }
            }
           if(![flag containsObject:@"未选中"]){//全选了
               
               [self.sc_table_cell1 setSel_status:1];
               
//            }else if (![flag containsObject:@"选中"]){//全没选
//                self.sc_table_cell1.sel_status = 0;
//                [self.sc_table_cell1 setSel_status:self.sc_table_cell1.sel_status];
            }else{
                [self.sc_table_cell1 setSel_status:0];
                
            }
        
        
        
        ShoppingCartCommodity *s = [self.cart_shop objectAtIndex:indexPath.row];
        self.sc_table_cell1.delegate = self;//委托指定
        self.sc_table_cell1.label_shop_name.text = s.shop_name;
        self.sc_table_cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.sc_table_cell1;
        
    }else{
        self.cart_shop = [self.shopping objectAtIndex:indexPath.section];
        self.sc_table_cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if(!self.sc_table_cell2){
            self.sc_table_cell2 = [[[NSBundle mainBundle]loadNibNamed:@"ShoppingCart2TableViewCell" owner:nil options:nil]objectAtIndex:0];
            
        }
        ShoppingCartCommodity *s = [self.cart_shop objectAtIndex:indexPath.row-1];
        self.sc_table_cell2.delegate = self;//委托指定
        [self.sc_table_cell2 setComm:s];
        
        //图片
        self.sc_table_cell2.img_comm_photo.contentMode=UIViewContentModeScaleAspectFill;
        self.sc_table_cell2.img_comm_photo.layer.masksToBounds = YES;
        [self.sc_table_cell2.img_comm_photo.layer setCornerRadius:self.sc_table_cell2.img_comm_photo.frame.size.height/8];
        [self.sc_table_cell2 setComm_url:s.comm_photo];
        //商品名称
        self.sc_table_cell2.label_comm_name.text = s.comm_name;
        //商品数量
        self.sc_table_cell2.label_comm_amount.text = [NSString stringWithFormat:@"%d",s.buy_amount];
        //商品的价格
        self.sc_table_cell2.label_comm_price.text = [NSString stringWithFormat:@"%.2f",s.comm_price];
        //数量加、减按钮设置tag
        self.sc_table_cell2.btn_delete.tag = 0;
        self.sc_table_cell2.btn_add.tag = 1;
        self.sc_table_cell2.selectionStyle = UITableViewCellSelectionStyleNone;
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

#pragma mark------获取本地用户购物车商品信息
-(void)getShoppingCartCommodity{
    //获取路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    self.save_path = [documentDirectory stringByAppendingPathComponent:
                      ShoppingCartFile];
    //接档，读取文件数据
    NSMutableArray *cart = [NSKeyedUnarchiver unarchiveObjectWithFile:self.save_path];
    self.shopping = [NSMutableArray arrayWithArray:cart];
//    NSArray *cart1 = [NSArray arrayWithArray:cart];
//    if(!cart){
//        NSLog(@"获取购物车信息失败！");
//    }else{
//        //将数组记录按商店id划分
//        NSMutableArray *cart2 = [[NSMutableArray alloc]init];
//        NSMutableArray *temp = [NSMutableArray arrayWithArray:cart];
//        for(int i = 0;i<[temp count];i++){
//            ShoppingCartCommodity *s = [temp objectAtIndex:i];
//            //[cart2 addObject:s];
//            for(int j = 0;j<[cart1 count];j++){
//                ShoppingCartCommodity *s1 = [cart1 objectAtIndex:j];
//                if([s1.shop_id isEqualToString:s.shop_id]){
//                    [cart2 addObject:s1];
//                }
//                
//            }
//            self.cart3 = [NSMutableArray arrayWithArray:cart2];
//            [self.shopping addObject:self.cart3];
//            [temp removeObjectsInArray:cart2];
//            [cart2 removeAllObjects];
//        }
////        NSLog(@"^^^^^%lu",(unsigned long)[self.shopping count]);
////        self.cart_shop = [self.shopping objectAtIndex:0];
////        NSLog(@"****%lu",[self.cart_shop count]);
//        
//    }
    
//    BOOL flag = [NSKeyedArchiver archiveRootObject:@"aaa" toFile:self.save_path];
//    
//    if(flag){
//        //       NSLog(@"归档成功^^^^%@",path);
//        
//        
//    }
    

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:(BOOL)animated];
//     m=0;
     n=0;
    total_price = 0;
    comm_select = false;//初始全选状态为false
    edit_flag = false;//初始编辑状态为false
    self.cart_shop =[[NSMutableArray alloc]init];
    [self getShoppingCartCommodity];
     m = (int)[self.shopping count]-1;
    if(self.shopping&&[self.shopping count]>0){
        [self.sc_table reloadData];
//        m=0;
       
    }else{
        self.sc_table.hidden = YES;
    }
    
    [self checkSelect];
    [self calculateTotalPrice];
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化导航条右侧按钮和title
    self.navigationItem.title = @"购物车";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style: UIBarButtonSystemItemDone target:self action:@selector(Go2Edit)];
    //使下一页的导航栏左边没有文字
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    //添加单击手势
    self.img_select_all.userInteractionEnabled = YES;//与用户交互激活
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAllComm)];
    [self.img_select_all addGestureRecognizer:singleTap];
    
    //编辑按钮圆角
    self.btn_del.layer.masksToBounds = YES;
    [self.btn_del.layer setCornerRadius:self.btn_del.frame.size.height/8];
    
    

    

}

#pragma mark---check 商品是否全选----
-(void)checkSelect{
    NSMutableArray *comm_array = [[NSMutableArray alloc]init];
    ShoppingCartCommodity *comm = [[ShoppingCartCommodity alloc]init];
    NSMutableArray *flag = [[NSMutableArray alloc]init];
    if([self.shopping count]>0){
    for(int i=0;i<[self.shopping count];i++){
        comm_array = [self.shopping objectAtIndex:i];
        for(int j=0;j<[comm_array count];j++){
            comm = [comm_array objectAtIndex:j];
            if(comm.select_status ==1){
                [flag addObject:@"选中"];
            }else{
               [flag addObject:@"未选中"];
            }
        }
    }
    }else{
        [flag addObject:@"未选中"];
    }
    
    if(![flag containsObject:@"未选中"]){
        comm_select = true;
        self.img_select_all.image = [UIImage imageNamed:@"选择"];
    }else{
        comm_select =false;
        self.img_select_all.image = [UIImage imageNamed:@"未选择"];
    }

}




#pragma mark----商品全选----
-(void)selectAllComm{
    
    NSMutableArray *comm_array = [[NSMutableArray alloc]init];
    ShoppingCartCommodity *comm = [[ShoppingCartCommodity alloc]init];
    
    int status;
    
    if(!comm_select){//之前未全选
        comm_select = true;
        status = 1;//全选
        self.img_select_all.image = [UIImage imageNamed:@"选择"];
    }else{
        comm_select =false;
        status = 0;//全不选
        self.img_select_all.image = [UIImage imageNamed:@"未选择"];
    }
    
        for(int i=0;i<[self.shopping count];i++){
            comm_array = [self.shopping objectAtIndex:i];
            for(int j=0;j<[comm_array count];j++){
                comm = [comm_array objectAtIndex:j];
                if(status==1){//全选
                    comm.select_status = 1;//全选

                }else{
                    comm.select_status = 0;//取消全选
                   
                }
            }
        }
    m=(int)[self.shopping count]-1;
    [self.sc_table reloadData];
    [self calculateTotalPrice];
    
}

#pragma mark----跳转编辑页
-(void)Go2Edit{
    
    if(!edit_flag){//切换为编辑状态
        edit_flag = true;
        self.navigationItem.rightBarButtonItem.title = @"完成";
        self.btn_calcu.enabled = NO;
        self.btn_calcu.hidden = YES;
        self.btn_del.hidden = NO;
        self.btn_del.enabled=YES;
        
        
    }else{//切换为完成编辑状态
        edit_flag = false;
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        self.btn_calcu.enabled = YES;
        self.btn_calcu.hidden = NO;
        self.btn_del.hidden = YES;
        self.btn_del.enabled=NO;
    }
    
}

#pragma mark----重新清理购物车商品----
-(void)saveNewShoppingCart{
    
    NSMutableArray *cart = [[NSMutableArray alloc]init];
    NSMutableArray *comm_array = [[NSMutableArray alloc]init];
    ShoppingCartCommodity *comm = [[ShoppingCartCommodity alloc]init];

    
    for(int i=0;i<[self.shopping count];i++){
        comm_array = [self.shopping objectAtIndex:i];
       for(int j=(int)([comm_array count]-1);j>=0;j--){
           ShoppingCartCommodity *comm2 = [ShoppingCartCommodity new];
           comm = [comm_array objectAtIndex:j];
           comm.select_status = 0;
           comm2 = comm;
           [comm_array removeObject:comm];
           [comm_array addObject:comm2];
        }
        [cart addObject:comm_array];//重新清理购物车数据
    }
    //保存归档
//    if(cart&&[cart count]>0){
        [NSKeyedArchiver archiveRootObject:cart toFile:self.save_path];
//    }
    
}

#pragma mark-----删除归档文件
-(void)deleteOldShoppingCart{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager isDeletableFileAtPath:self.save_path]){
        [fileManager removeItemAtPath:self.save_path error:nil];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:(BOOL)animated];
    [self deleteOldShoppingCart];
    [self saveNewShoppingCart];
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
