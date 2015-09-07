//
//  ViewController4Food.m
//  communityiOS
//
//  Created by 何茂馨 on 15/6/24.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ViewController4Food.h"
#import "CollectionViewCell4Food.h"

@interface ViewController4Food ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView4Food;
@property(strong,nonatomic) NSMutableArray *comm_list;

@end

@implementation ViewController4Food

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.comm_list count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell4Food *cell4food = [[CollectionViewCell4Food alloc]init];
    cell4food = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell4food" forIndexPath:indexPath];
    return cell4food;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.comm_list = [[NSMutableArray alloc]init];
    //wangyao 0624  设定collectionview的布局形式，来设定行间距，item间距，以及item的size大小！
    UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc]init];
    flow_layout.minimumLineSpacing = 1;
    flow_layout.minimumInteritemSpacing = 1;
    
    [flow_layout setItemSize:CGSizeMake(self.view.frame.size.width/2-0.5, 250)];
    
    _collectionView4Food.collectionViewLayout = flow_layout;
    
    
    [_collectionView4Food registerNib:[UINib nibWithNibName:@"CollectionViewCell4Food" bundle:nil]forCellWithReuseIdentifier:@"cell4food" ];
    
    
    
    
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
