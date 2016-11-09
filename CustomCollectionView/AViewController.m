//
//  ViewController.m
//  CustomCollectionView
//
//  Created by mac1 on 16/10/19.
//  Copyright © 2016年 Tucici. All rights reserved.
//

#import "AViewController.h"
#import "Mylayout.h"
#define MaxPath [NSIndexPath indexPathWithIndex:1000]     /*初始化时，默认的前一次点击cell的path*/
@interface AViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    UILabel *_selectedLabel;
    UICollectionView *_collect;
    NSIndexPath *previousPath;          /*前一次点击cell的path*/
    
}

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    previousPath = MaxPath;            /*前一次点击cell的path 默认为最大*/
    
    [self initializeButton];
    
    [self initializeCollect];
    
    [self initializeLabel];
    
    // Do any additional setup after loading the view.
}
-(void)initializeButton{
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(10.0, 20.0, 50.0, 40.0)];
    [back setBackgroundColor:[UIColor yellowColor]];
    [back setTitle:@"back" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}
-(void)initializeCollect{
    //创建一个layout布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        Mylayout * layout = [[Mylayout alloc]init];
    
    //设置布局方向为垂直流布局
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置每隔item的大小为100*100
    layout.itemSize = CGSizeMake(50, 50);
    //通过一个布局策略layout，创建collectionview
    _collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0.0, 70.0, self.view.frame.size.width, self.view.frame.size.height - 70.0) collectionViewLayout:layout];
    [_collect setBackgroundColor: [UIColor whiteColor]];
    _collect.delegate = self;
    _collect.dataSource = self;
    //注册item类型，这里使用系统的类型,collectionview和tableview不同，collectionview在完成代理，必须注册cell，而tableview可以再代理方法里，临时通过创建来做。
    [_collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:_collect];
}
-(void)initializeLabel{
    _selectedLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, 0.0, 0.0)];
    [_selectedLabel setTextColor:[UIColor lightGrayColor]];
    [_selectedLabel setText:@"didselected number"];
    [_selectedLabel sizeToFit];
    [_selectedLabel setCenter:CGPointMake(self.view.center.x, self.view.frame.size.height - CGRectGetMidY(_selectedLabel.frame))];
    [self.view addSubview:_selectedLabel];
}
-(void)back:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 3;
    return 1;
    
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    if (section == 0) {
    //        return 10;
    //    }else if (section == 1){
    //        return 13;
    //    }else if (section == 2){
    //        return 16;
    //    }
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 25;
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    //    if (indexPath.section == 0) {
    //        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 5.0)];
    //        [view setBackgroundColor:[UIColor redColor]];
    //        [cell addSubview:view];
    //    }else if (indexPath.section == 1){
    //        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 5.0)];
    //        [view setBackgroundColor:[UIColor redColor]];
    //        [cell addSubview:view];
    //    }else if (indexPath.section == 2){
    //        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 5.0)];
    //        [view setBackgroundColor:[UIColor redColor]];
    //        [cell addSubview:view];
    //    }
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.transform = CGAffineTransformMakeScale(1.1, 1.1);
    
    /*选中的Item 滚动到中间*/
    //    [_collect selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
    [_collect scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    
    [_selectedLabel setText:[NSString stringWithFormat:@"didSelectItem: ---> %ld",(long)indexPath.row]];
    [_selectedLabel sizeToFit];
    
    if (previousPath != MaxPath && previousPath!=indexPath) {
        UICollectionViewCell *cell2 = [collectionView cellForItemAtIndexPath:previousPath];
        cell2.transform = CGAffineTransformIdentity;
    }
    /*前后两次点击，item互换*/
    //    if (previousPath != MaxPath) {
    //        [_collect  moveItemAtIndexPath:previousPath toIndexPath:indexPath];
    //    }
    previousPath = indexPath;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
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
