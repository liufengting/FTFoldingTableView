//
//  ViewController.m
//  FTFoldingTableView
//
//  Created by liufengting on 16/6/20.
//  Copyright © 2016年 liufengting. All rights reserved.
//

#import "ViewController.h"
#import "FTFoldingTableView.h"



static NSString *SectionHeaderViewIdentifier = @"SectionHeaderViewIdentifier";

static NSString *DemoTableViewIdentifier = @"DemoTableViewIdentifier";

@interface ViewController () <FTFoldingTableViewDelegate>

@property (weak, nonatomic) IBOutlet FTFoldingTableView *ft_tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    self.ft_tableView.foldingDelegate = self;
    self.ft_tableView.tableFooterView = [[UIView alloc] init];

}

#pragma mark - FTFoldingTableViewDelegate

- (FTFoldingSectionHeaderArrowDirection)perferedArrowDirectionForFTFoldingTableView:(FTFoldingTableView *)ftTableView
{
    return FTFoldingSectionHeaderArrowDirectionRight;
}
- (NSInteger )numberOfSectionForFTFoldingTableView:(FTFoldingTableView *)ftTableView
{
    return 5;
}
- (NSInteger )ftFoldingTableView:(FTFoldingTableView *)ftTableView numberOfRowsInSection:(NSInteger )section
{
    return 3;
}
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForHeaderInSection:(NSInteger )section
{
    return 60;
}
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSString *)ftFoldingTableView:(FTFoldingTableView *)ftTableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section %ld",section];
}
- (UITableViewCell *)ftFoldingTableView:(FTFoldingTableView *)ftTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.ft_tableView dequeueReusableCellWithIdentifier:DemoTableViewIdentifier forIndexPath:indexPath];
    
    
    return cell;
}
- (void )ftFoldingTableView:(FTFoldingTableView *)ftTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ftTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


@end
