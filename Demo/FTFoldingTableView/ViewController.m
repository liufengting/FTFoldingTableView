//
//  ViewController.m
//  FTFoldingTableView
//
//  Created by liufengting on 16/6/20.
//  Copyright © 2016 LiuFengting <https://github.com/liufengting>. All rights reserved.
//

#import "ViewController.h"
#import "FTFoldingTableView.h"

static NSString * const SectionHeaderViewIdentifier    = @"SectionHeaderViewIdentifier";
static NSString * const DemoTableViewIdentifier        = @"DemoTableViewIdentifier";

@interface ViewController () <FTFoldingTableViewDelegate>

@property (weak, nonatomic) IBOutlet FTFoldingTableView *ft_tableView;
@property (nonatomic, assign) FTFoldingSectionHeaderArrowPosition arrowPosition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.arrowPosition = FTFoldingSectionHeaderArrowPositionLeft;
    
    self.ft_tableView.foldingDelegate = self;
}

- (IBAction)changeStyle:(UIBarButtonItem *)sender
{
    self.arrowPosition = [NSNumber numberWithBool:(![NSNumber numberWithInteger:self.arrowPosition].boolValue)].integerValue;
    [self.ft_tableView reloadData];

    
//  foldAllSections
//    [self.ft_tableView foldAllSections];
    
//  expandAllSections
//    [self.ft_tableView expandAllSections];

//  test one section
//    NSInteger section = 0;
//    FTFoldingSectionState state = [self.ft_tableView foldingStateForSection:section];
//    if (state == FTFoldingSectionStateFold) {
//        [self.ft_tableView expandSection:section];
//    }else{
//        [self.ft_tableView foldSection:section];
//    }
}

#pragma mark - FTFoldingTableViewDelegate / required

- (FTFoldingSectionHeaderArrowPosition)perferedArrowPositionForFTFoldingTableView:(FTFoldingTableView *)ftTableView
{
    return self.arrowPosition;
}
- (NSInteger)numberOfSectionForFTFoldingTableView:(FTFoldingTableView *)ftTableView
{
    return 5;
}
- (NSInteger)ftFoldingTableView:(FTFoldingTableView *)ftTableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForHeaderInSection:(NSInteger)section
{
    return 60.f;
}
- (CGFloat)ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
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
- (void)ftFoldingTableView:(FTFoldingTableView *)ftTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ftTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - FTFoldingTableViewDelegate / optional delegates, change almost everything using delegate

- (void)ftFoldingTableView:(FTFoldingTableView *)ftTableView willChangeToSectionState:(FTFoldingSectionState)sectionState section:(NSInteger)section
{
    NSLog(@"section: %ld is about to %@", section, sectionState == FTFoldingSectionStateFold ? @"close" : @"open");
}
- (void)ftFoldingTableView:(FTFoldingTableView *)ftTableView didChangeToSectionState:(FTFoldingSectionState)sectionState section:(NSInteger)section
{
    NSLog(@"section: %ld is now %@", section, sectionState == FTFoldingSectionStateFold ? @"closed" : @"opened");
}

- (NSString *)ftFoldingTableView:(FTFoldingTableView *)ftTableView descriptionForHeaderInSection:(NSInteger)section
{
    return @"description";
}

//- (UIImage *)ftFoldingTableView:(FTFoldingTableView *)ftTableView arrowImageForSection:(NSInteger)section
//{
//    return [UIImage imageNamed:@"Arrowhead"];
//}
//- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView backgroundColorForHeaderInSection:(NSInteger)section
//{
//    return [UIColor grayColor];
//}
//- (UIFont *)ftFoldingTableView:(FTFoldingTableView *)ftTableView fontForTitleInSection:(NSInteger)section
//{
//    return [UIFont boldSystemFontOfSize:16];
//}
//- (UIFont *)ftFoldingTableView:(FTFoldingTableView *)ftTableView fontForDescriptionInSection:(NSInteger)section
//{
//    return [UIFont systemFontOfSize:13];
//}
//- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView textColorForTitleInSection:(NSInteger)section
//{
//    return [UIColor whiteColor];
//}
//- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView textColorForDescriptionInSection:(NSInteger)section
//{
//    return [UIColor whiteColor];
//}

@end
