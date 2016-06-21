//
//  FTFoldingTableView.h
//  FTFoldingTableView
//
//  Created by liufengting on 16/6/20.
//  Copyright © 2016年 liufengting. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Constants

#define FTFoldingDefaultMargin                  8.0f
#define FTFoldingDefaultIconSize                24.0f
#define FTFoldingDefaultSepertorLineWidth       0.5f

#pragma mark - ENUM FTFoldingSectionState

typedef NS_ENUM(NSUInteger, FTFoldingSectionState) {
    FTFoldingSectionStateFlod,
    FTFoldingSectionStateShow,
};

#pragma mark - ENUM FTFoldingSectionHeaderArrowPosition

typedef NS_ENUM(NSUInteger, FTFoldingSectionHeaderArrowPosition) {
    FTFoldingSectionHeaderArrowPositionLeft,
    FTFoldingSectionHeaderArrowPositionRight,
};


#pragma mark - FTFoldingTableViewDelegate

@class FTFoldingTableView;

@protocol FTFoldingTableViewDelegate <NSObject>

@required

- (FTFoldingSectionHeaderArrowPosition)perferedArrowPositionForFTFoldingTableView:(FTFoldingTableView *)ftTableView;
- (NSInteger )numberOfSectionForFTFoldingTableView:(FTFoldingTableView *)ftTableView;
- (NSInteger )ftFoldingTableView:(FTFoldingTableView *)ftTableView numberOfRowsInSection:(NSInteger )section;
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForHeaderInSection:(NSInteger )section;
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)ftFoldingTableView:(FTFoldingTableView *)ftTableView titleForHeaderInSection:(NSInteger )section;
- (UITableViewCell *)ftFoldingTableView:(FTFoldingTableView *)ftTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void )ftFoldingTableView:(FTFoldingTableView *)ftTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (UIImage *)ftFoldingTableView:(FTFoldingTableView *)ftTableView arrowImageForSection:(NSInteger )section;
- (NSString *)ftFoldingTableView:(FTFoldingTableView *)ftTableView descriptionForHeaderInSection:(NSInteger )section;
- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView backgroundColorForHeaderInSection:(NSInteger )section;
- (UIFont *)ftFoldingTableView:(FTFoldingTableView *)ftTableView fontForTitleInSection:(NSInteger )section;
- (UIFont *)ftFoldingTableView:(FTFoldingTableView *)ftTableView fontForDescriptionInSection:(NSInteger )section;
- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView textColorForTitleInSection:(NSInteger )section;
- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView textColorForDescriptionInSection:(NSInteger )section;

@end

#pragma mark - FTFoldingSectionHeaderDelegate

@protocol FTFoldingSectionHeaderDelegate <NSObject>

- (void)ftFoldingSectionHeaderTappedAtIndex:(NSInteger)index;

@end

#pragma mark - FTFoldingTableView

@interface FTFoldingTableView : UITableView <UITableViewDelegate,UITableViewDataSource,FTFoldingSectionHeaderDelegate>

@property (nonatomic, strong)id<FTFoldingTableViewDelegate> foldingDelegate;

@end

#pragma mark - FTFoldingSectionHeader

@interface FTFoldingSectionHeader : UIView

@property (nonatomic, strong)id<FTFoldingSectionHeaderDelegate> tapDelegate;

-(instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag;

-(void)setupWithBackgroundColor:(UIColor *)backgroundColor
                    titleString:(NSString *)titleString
                     titleColor:(UIColor *)titleColor
                      titleFont:(UIFont *)titleFont
              descriptionString:(NSString *)descriptionString
               descriptionColor:(UIColor *)descriptionColor
                descriptionFont:(UIFont *)descriptionFont
                     arrowImage:(UIImage *)arrowImage
                  arrowPosition:(FTFoldingSectionHeaderArrowPosition)arrowPosition
                   sectionState:(FTFoldingSectionState)sectionState;





@end
