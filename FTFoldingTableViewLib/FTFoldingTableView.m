//
//  FTFoldingTableView.m
//  FTFoldingTableView
//
//  Created by liufengting on 16/6/20.
//  Copyright © 2016 LiuFengting <https://github.com/liufengting>. All rights reserved.
//

#import "FTFoldingTableView.h"

#pragma mark - Constants
/**
 *  Constants
 */
#define FTFoldingDefaultMargin                  8.0f
#define FTFoldingDefaultIconSize                24.0f
#define FTFoldingDefaultSepertorLineWidth       0.3f

#pragma mark - FTFoldingTableView
/**
 *  FTFoldingTableView
 */
@interface FTFoldingTableView ()

@property (nonatomic, strong)NSMutableArray *statusArray;

@end

@implementation FTFoldingTableView

#pragma mark - Initial Methods

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}

#pragma mark - Setup Methods

-(void)setupDelegateAndDataSource
{
    self.delegate = self;
    self.dataSource = self;
    if (self.style == UITableViewStylePlain) {
        self.tableFooterView = [[UIView alloc] init];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onChangeStatusBarOrientationNotification:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

-(NSMutableArray *)statusArray
{
    if (!_statusArray) {
        _statusArray = [NSMutableArray array];
    }
    if (_statusArray.count) {
        if (_statusArray.count > self.numberOfSections) {
            [_statusArray removeObjectsInRange:NSMakeRange(self.numberOfSections - 1, _statusArray.count - self.numberOfSections)];
        }else if (_statusArray.count < self.numberOfSections) {
            for (NSInteger i = self.numberOfSections - _statusArray.count; i < self.numberOfSections; i++) {
                [_statusArray addObject:[NSNumber numberWithInteger:FTFoldingSectionStateFlod]];
            }
        }
    }else{
        for (NSInteger i = 0; i < self.numberOfSections; i++) {
            [_statusArray addObject:[NSNumber numberWithInteger:FTFoldingSectionStateFlod]];
        }
    }
    return _statusArray;
}

-(void)onChangeStatusBarOrientationNotification:(NSNotification *)notification
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

#pragma mark - UI Configration

-(FTFoldingSectionHeaderArrowPosition )perferedArrowPosition
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(perferedArrowPositionForFTFoldingTableView:)]) {
        return [_foldingDelegate perferedArrowPositionForFTFoldingTableView:self];
    }
    return FTFoldingSectionHeaderArrowPositionRight;
}
-(UIColor *)backgroundColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:backgroundColorForHeaderInSection:)]) {
        return [_foldingDelegate ftFoldingTableView:self backgroundColorForHeaderInSection:section];
    }
    return [UIColor colorWithRed:102/255.f green:102/255.f blue:255/255.f alpha:1.f];
}
-(NSString *)titleForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:titleForHeaderInSection:)]) {
        return [_foldingDelegate ftFoldingTableView:self titleForHeaderInSection:section];
    }
    return [NSString string];
}
-(UIFont *)titleFontForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:fontForTitleInSection:)]) {
        return [_foldingDelegate ftFoldingTableView:self fontForTitleInSection:section];
    }
    return [UIFont boldSystemFontOfSize:16];
}
-(UIColor *)titleColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:textColorForTitleInSection:)]) {
        return [_foldingDelegate ftFoldingTableView:self textColorForTitleInSection:section];
    }
    return [UIColor whiteColor];
}
-(NSString *)descriptionForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:descriptionForHeaderInSection:)]) {
        return [_foldingDelegate ftFoldingTableView:self descriptionForHeaderInSection:section];
    }
    return [NSString string];
}
-(UIFont *)descriptionFontForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:fontForDescriptionInSection:)]) {
        return [_foldingDelegate ftFoldingTableView:self fontForDescriptionInSection:section];
    }
    return [UIFont systemFontOfSize:13];
}

-(UIColor *)descriptionColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:textColorForDescriptionInSection:)]) {
        return [_foldingDelegate ftFoldingTableView:self textColorForDescriptionInSection:section];
    }
    return [UIColor whiteColor];
}

-(UIImage *)arrowImageForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:arrowImageForSection:)]) {
        return [_foldingDelegate ftFoldingTableView:self arrowImageForSection:section];
    }
    return [UIImage imageNamed:@"Arrowhead"];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(numberOfSectionForFTFoldingTableView:)]) {
        return [_foldingDelegate numberOfSectionForFTFoldingTableView:self];
    }else{
        return self.numberOfSections;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (((NSNumber *)self.statusArray[section]).integerValue == FTFoldingSectionStateShow) {
        if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:numberOfRowsInSection:)]) {
            return [_foldingDelegate ftFoldingTableView:self numberOfRowsInSection:section];
        }
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:heightForHeaderInSection:)]) {
        return [_foldingDelegate ftFoldingTableView:self heightForHeaderInSection:section];
    }else{
        return self.sectionHeaderHeight;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:heightForRowAtIndexPath:)]) {
        return [_foldingDelegate ftFoldingTableView:self heightForRowAtIndexPath:indexPath];
    }else{
        return self.rowHeight;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.style == UITableViewStylePlain) {
        return 0;
    }else{
        return 0.01;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FTFoldingSectionHeader *sectionHeaderView = [[FTFoldingSectionHeader alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [self tableView:self heightForHeaderInSection:section])
                                                                                      withTag:section];
    
    [sectionHeaderView setupWithBackgroundColor:[self backgroundColorForSection:section]
                                    titleString:[self titleForSection:section]
                                     titleColor:[self titleColorForSection:section]
                                      titleFont:[self titleFontForSection:section]
                              descriptionString:[self descriptionForSection:section]
                               descriptionColor:[self descriptionColorForSection:section]
                                descriptionFont:[self descriptionFontForSection:section]
                                     arrowImage:[self arrowImageForSection:section]
                                  arrowPosition:[self perferedArrowPosition]
                                   sectionState:((NSNumber *)self.statusArray[section]).integerValue];
    
    sectionHeaderView.tapDelegate = self;
    
    return sectionHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:cellForRowAtIndexPath:)]) {
        return [_foldingDelegate ftFoldingTableView:self cellForRowAtIndexPath:indexPath];
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCellIndentifier"];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:didSelectRowAtIndexPath:)]) {
        [_foldingDelegate ftFoldingTableView:self didSelectRowAtIndexPath:indexPath];
    }
}
#pragma mark - FTFoldingSectionHeaderDelegate

-(void)ftFoldingSectionHeaderTappedAtIndex:(NSInteger)index
{
    BOOL currentIsOpen = ((NSNumber *)self.statusArray[index]).boolValue;
    
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(ftFoldingTableView:willChangeToSectionState:section:)]) {
        [_foldingDelegate ftFoldingTableView:self
                    willChangeToSectionState:(currentIsOpen == YES) ? FTFoldingSectionStateFlod : FTFoldingSectionStateShow
                                     section:index];
    }

    [self.statusArray replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:!currentIsOpen]];
    
    NSInteger numberOfRow = [_foldingDelegate ftFoldingTableView:self numberOfRowsInSection:index];
    NSMutableArray *rowArray = [NSMutableArray array];
    if (numberOfRow) {
        for (NSInteger i = 0; i < numberOfRow; i++) {
            [rowArray addObject:[NSIndexPath indexPathForRow:i inSection:index]];
        }
    }
    if (rowArray.count) {
        if (currentIsOpen) {
            [self deleteRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
        }else{
            [self insertRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
        }
    }
}

@end

#pragma mark - FTFoldingSectionHeader
/**
 *  FTFoldingSectionHeader
 */
@interface FTFoldingSectionHeader ()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *descriptionLabel;
@property (nonatomic, strong)UIImageView *arrowImageView;
@property (nonatomic, strong)UIView *sepertorLine;
@property (nonatomic, assign)FTFoldingSectionHeaderArrowPosition arrowPosition;
@property (nonatomic, assign)FTFoldingSectionState sectionState;
@property (nonatomic, strong)UITapGestureRecognizer *tapGesture;

@end

@implementation FTFoldingSectionHeader

-(instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = tag;
        [self setupSubviewsWithArrowPosition:FTFoldingSectionHeaderArrowPositionRight];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupSubviewsWithArrowPosition:FTFoldingSectionHeaderArrowPositionRight];
    
}


-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
-(UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        _descriptionLabel.textAlignment = NSTextAlignmentRight;
    }
    return _descriptionLabel;
}
-(UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _arrowImageView.backgroundColor = [UIColor clearColor];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImageView;
}
-(UIView *)sepertorLine
{
    if (!_sepertorLine) {
        _sepertorLine = [[UIView alloc]initWithFrame:CGRectZero];
        _sepertorLine.backgroundColor = [UIColor whiteColor];
        //        _sepertorLine.lineWidth = FTFoldingDefaultSepertorLineWidth;
    }
    return _sepertorLine;
}

-(UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapped:)];
    }
    return _tapGesture;
}

//-(UIBezierPath *)getSepertorPath
//{
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, self.frame.size.height - FTFoldingDefaultSepertorLineWidth)];
//    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - FTFoldingDefaultSepertorLineWidth)];
//    [path stroke];
//    return path;
//}


-(void)setupWithBackgroundColor:(UIColor *)backgroundColor
                    titleString:(NSString *)titleString
                     titleColor:(UIColor *)titleColor
                      titleFont:(UIFont *)titleFont
              descriptionString:(NSString *)descriptionString
               descriptionColor:(UIColor *)descriptionColor
                descriptionFont:(UIFont *)descriptionFont
                     arrowImage:(UIImage *)arrowImage
                  arrowPosition:(FTFoldingSectionHeaderArrowPosition)arrowPosition
                   sectionState:(FTFoldingSectionState)sectionState
{
    
    [self setBackgroundColor:backgroundColor];
    
    [self setupSubviewsWithArrowPosition:arrowPosition];
    
    self.titleLabel.text = titleString;
    self.titleLabel.textColor = titleColor;
    self.titleLabel.font = titleFont;
    
    self.descriptionLabel.text = descriptionString;
    self.descriptionLabel.textColor = descriptionColor;
    self.descriptionLabel.font = descriptionFont;
    
    self.arrowImageView.image = arrowImage;
    self.arrowPosition = arrowPosition;
    self.sectionState = sectionState;
    
    if (sectionState == FTFoldingSectionStateShow) {
        if (self.arrowPosition == FTFoldingSectionHeaderArrowPositionRight) {
            self.arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        }else{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        }
    } else {
        if (self.arrowPosition == FTFoldingSectionHeaderArrowPositionRight) {
            _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        }else{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
        }
    }
    
}
-(void)setupSubviewsWithArrowPosition:(FTFoldingSectionHeaderArrowPosition)arrowPosition
{
    CGFloat labelWidth = (self.frame.size.width - FTFoldingDefaultMargin*2 - FTFoldingDefaultIconSize)/2;
    CGFloat labelHeight = self.frame.size.height;
    CGRect arrowRect = CGRectMake(0, (self.frame.size.height - FTFoldingDefaultIconSize)/2, FTFoldingDefaultIconSize, FTFoldingDefaultIconSize);
    CGRect titleRect = CGRectMake(FTFoldingDefaultMargin + FTFoldingDefaultIconSize, 0, labelWidth, labelHeight);
    CGRect descriptionRect = CGRectMake(FTFoldingDefaultMargin + FTFoldingDefaultIconSize + labelWidth,  0, labelWidth, labelHeight);
    CGRect lineRect = CGRectMake(0, self.bounds.size.height - FTFoldingDefaultSepertorLineWidth, self.bounds.size.width, FTFoldingDefaultSepertorLineWidth);
    if (arrowPosition == FTFoldingSectionHeaderArrowPositionRight) {
        arrowRect.origin.x = FTFoldingDefaultMargin*2 + labelWidth*2;
        titleRect.origin.x = FTFoldingDefaultMargin;
        descriptionRect.origin.x = FTFoldingDefaultMargin + labelWidth;
    }
    
    [self.titleLabel setFrame:titleRect];
    [self.descriptionLabel setFrame:descriptionRect];
    [self.arrowImageView setFrame:arrowRect];
    [self.sepertorLine setFrame:lineRect];
    
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.arrowImageView];
    [self addGestureRecognizer:self.tapGesture];
    [self addSubview:self.sepertorLine];
    
}

-(void)shouldExpand:(BOOL)shouldExpand
{
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         if (shouldExpand) {
                             if (self.arrowPosition == FTFoldingSectionHeaderArrowPositionRight) {
                                 self.arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
                             }else{
                                 self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
                             }
                         } else {
                             if (self.arrowPosition == FTFoldingSectionHeaderArrowPositionRight) {
                                 _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
                             }else{
                                 self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
                             }
                         }
                     } completion:^(BOOL finished) {
                         if (finished == YES) {
                             self.sepertorLine.hidden = shouldExpand;
                         }
                     }];
}


-(void)onTapped:(UITapGestureRecognizer *)gesture
{
    [self shouldExpand:![NSNumber numberWithInteger:self.sectionState].boolValue];
    if (_tapDelegate && [_tapDelegate respondsToSelector:@selector(ftFoldingSectionHeaderTappedAtIndex:)]) {
        self.sectionState = [NSNumber numberWithBool:(![NSNumber numberWithInteger:self.sectionState].boolValue)].integerValue;
        [_tapDelegate ftFoldingSectionHeaderTappedAtIndex:self.tag];
    }
}

@end

