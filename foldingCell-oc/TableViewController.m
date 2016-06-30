//
//  TableViewController.m
//  foldingCell-oc
//
//  Created by chars on 16/6/28.
//  Copyright © 2016年 chars. All rights reserved.
//

#import "TableViewController.h"
#import "FoldingCell.h"

static const CGFloat kCloseCellHeight  = 179;
static const CGFloat kOpenCellHeight = 488;

@interface TableViewController ()
{
    NSMutableArray *heightArray;
}

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FoldingCell class]) bundle:nil] forCellReuseIdentifier:@"foldingcell"];
    heightArray = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [heightArray addObject:[NSNumber numberWithFloat:kCloseCellHeight]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [heightArray[indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoldingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foldingcell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[FoldingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"foldingcell"];
    }
    if ([heightArray[indexPath.row] floatValue] == kCloseCellHeight) {
        [cell selectedAnimation:NO animation:NO completion:nil];
    } else {
        [cell selectedAnimation:YES animation:NO completion:nil];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FoldingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isAnimating]) return;
    
    CGFloat durtion = 0.0;
    if ([heightArray[indexPath.row] floatValue] == kCloseCellHeight) {
        [heightArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:kOpenCellHeight]];
        durtion = 0.3;
        [cell selectedAnimation:YES animation:YES completion:nil];
    } else {
        durtion = [cell returnSumTime];
        [heightArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:kCloseCellHeight]];
        [cell selectedAnimation:NO animation:YES completion:nil];
    }
    [UIView animateWithDuration:durtion + 0.3 animations:^{
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
