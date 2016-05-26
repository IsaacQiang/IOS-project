//
//  detailpatientViewController.m
//  test2
//
//  Created by 冯子强 on 16/5/16.
//  Copyright © 2016年 冯子强. All rights reserved.
//

#import "detailpatientViewController.h"
#import "SocketConnect.h"
@interface detailpatientViewController ()
{
      SocketConnect *ss;
}
@property (weak, nonatomic) IBOutlet UILabel *casenum;
@property (weak, nonatomic) IBOutlet UILabel *bednum;
@property (weak, nonatomic) IBOutlet UILabel *patientname;
@property (weak, nonatomic) IBOutlet UILabel *patientsex;
@property (weak, nonatomic) IBOutlet UILabel *patientbirth;
@property (weak, nonatomic) IBOutlet UILabel *patientHigh;
@property (weak, nonatomic) IBOutlet UILabel *patientweight;
@property (weak, nonatomic) IBOutlet UILabel *patientarea;
@property (weak, nonatomic) IBOutlet UILabel *allergyhis;
@property (weak, nonatomic) IBOutlet UILabel *heredityhis;

@property NSArray *listArry;

@end

@implementation detailpatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ss = [SocketConnect sharedInstance];
    NSLog(@"%@",ss.msg);
    
    _listArry = [ss.msg componentsSeparatedByString:@"|"];
    
    NSLog(@"%@",_listArry);
    
    _casenum.text = _listArry[1];
    _bednum.text = _listArry[2];
    _patientname.text = _listArry[3];
    _patientsex.text = _listArry[4];
    _patientHigh.text = _listArry[5];
    _patientweight.text = _listArry[6];
    _patientarea.text = _listArry[7];
    _patientbirth.text = _listArry[8];
    _allergyhis.text = _listArry[9];
    _heredityhis.text = _listArry[10];
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
