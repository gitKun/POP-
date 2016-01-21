//
//  ViewController.m
//  POP的练习1
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "ViewController.h"
#import "ListCell.h"
#import "POP.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Animation List";
    self.dataArr = @[@"Button",@"Image",@"Decay",@"PagerButton",@"CustomTransition"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCellID"];
    [cell setName:_dataArr[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        [self performSegueWithIdentifier:_dataArr[indexPath.row] sender:self];
    }
    @catch (NSException *exception) {
        NSLog(@"没找到 %@ 对应的 segue ",_dataArr[indexPath.row]);
    }
    @finally {
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
