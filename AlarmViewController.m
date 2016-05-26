//
//  AlarmViewController.m
//  test2
//
//  Created by 冯子强 on 16/3/1.
//  Copyright © 2016年 冯子强. All rights reserved.
//

#import "AlarmViewController.h"
 
static NSString *cellIdentifier = @"patientCell";//as a key to update source
static NSString *sectionsTableIdentifier = @"sectionsTableIdentifier";//as a key to update source

@interface AlarmViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (copy, nonatomic) NSDictionary *names;
@property (copy, nonatomic) NSArray *keys;

@end

@implementation AlarmViewController

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
 return [self.keys count];
}

- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString *key = self.keys[section];
    NSArray *nameSection = self.names[key];
    return [nameSection count];
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
        
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:sectionsTableIdentifier];
        
        NSString *key = self.keys[indexPath.section];
        NSArray *nameSection = self.names[key];
        cell.textLabel.text = nameSection[indexPath.row];
        if(cell == nil) {
            NSLog(@"nil");
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            return cell;
        }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //return self.mkeys[section];
    return self.keys[section];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:sectionsTableIdentifier];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"alarminfo" ofType:@"plist"];
    self.names = [NSDictionary dictionaryWithContentsOfFile:path];
    self.keys = [[self.names allKeys]sortedArrayUsingSelector:@selector(compare:)];
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
