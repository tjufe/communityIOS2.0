//
//  DetailInformationViewController.m
//  communityiOS
//
//  Created by tjufe on 15/9/22.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "DetailInformationViewController.h"
#import "myInfoList.h"
#import "myInformation.h"
#import "PosterTableViewCell.h"
#import "PostTextTableViewCell.h"
#import "PostImageTableViewCell.h"
@interface DetailInformationViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)myInformation *my_info;
@property(strong,nonatomic)PostTextTableViewCell *postTextCell;
@property(strong,nonatomic)PostImageTableViewCell *postImageCell;

@end

float cellheight1 = 0;

@implementation DetailInformationViewController



-(void)getInfo:(myInformation *)my_info{
    self.my_info =my_info;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 100;
    }else if(indexPath.row == 1){
        return cellheight1;
    }else{
    
        return 150;
    
    }
    


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.my_info.image isEqualToString:@""]||self.my_info.image==nil) {
        return 2;
    }else{
        return 3;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        PosterTableViewCell *PTCell = [tableView dequeueReusableCellWithIdentifier:nil];
        PTCell = [[[NSBundle mainBundle]loadNibNamed:@"PosterTableViewCell" owner:nil options:nil]objectAtIndex:0];
        [PTCell setMember_name:self.my_info.member_name];
        [PTCell setMember_head:self.my_info.member_head];
        [PTCell setSend_date:self.my_info.send_time];
        PTCell.posterAuth.hidden=YES;
        return PTCell;
    }else if (indexPath.row==1){
        self.postTextCell = [tableView dequeueReusableCellWithIdentifier:nil];
        self.postTextCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!self.postTextCell) {
            self.postTextCell= [[[NSBundle mainBundle]loadNibNamed:@"PostTextTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.postTextCell.selectionStyle = UITableViewCellSelectionStyleNone;
            //                cellheight = self.postTextCell.postText.frame.size.height;
            
        }
        [self.postTextCell.postText setText:self.my_info.content];
        //改变cell的高度需要reload该cell
        CGSize size = CGSizeMake(300, 1000);
        CGSize labelSize = [self.postTextCell.postText.text sizeWithFont:self.postTextCell.postText.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
        cellheight1 = labelSize.height+10;
        return self.postTextCell;
        
    }else{
        self.postImageCell = [tableView dequeueReusableCellWithIdentifier:nil];
        if (!self.postImageCell) {
            self.postImageCell= [[[NSBundle mainBundle]loadNibNamed:@"PostImageTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.postImageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [self.postImageCell setMain_image:self.my_info.image];
        return self.postImageCell;
    
    
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.InformationTitle setText:self.my_info.title];
    [self.GroupName setText:self.my_info.group_name];
    
    self.DetailInformationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消下划线
    self.navigationItem.title = @"详情";
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
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
