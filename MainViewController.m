//
//  MainViewController.m
//  test2
//
//  Created by 冯子强 on 16/2/23.
//  Copyright © 2016年 冯子强. All rights reserved.
//

#import "MainViewController.h"
#import "SocketConnect.h"
@interface MainViewController (){
    SocketConnect *ss;
}
@property (copy, nonatomic) NSString *tmp;
@end

@implementation MainViewController

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
