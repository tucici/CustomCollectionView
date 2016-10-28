//
//  ViewController.m
//  CustomCollectionView
//
//  Created by mac1 on 16/10/19.
//  Copyright © 2016年 Tucici. All rights reserved.
//

#import "ViewController.h"
#import "AViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(100.0, 100.0, 50.0, 40.0)];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitle:@"click" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view.
}
-(void)click:(UIButton *)sender{
    AViewController *av= [[AViewController alloc]init];
    [self presentViewController:av animated:NO completion:nil];
    
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
