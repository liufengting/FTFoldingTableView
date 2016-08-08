# FTFoldingTableView

[![Twitter](https://img.shields.io/badge/twitter-@liufengting-blue.svg?style=flat)](http://twitter.com/liufengting) 
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/liufengting/FTFoldingTableView/master/LICENSE)
[![Version](https://img.shields.io/cocoapods/v/FTFoldingTableView.svg?style=flat)](http://cocoapods.org/pods/FTFoldingTableView)
[![Platform](https://img.shields.io/cocoapods/p/FTFoldingTableView.svg?style=flat)](http://cocoapods.org/pods/FTFoldingTableView)
[![CocoaPods](https://img.shields.io/cocoapods/dt/FTFoldingTableView.svg?maxAge=2592000)](http://cocoapods.org/pods/FTFoldingTableView)
[![CI Status](http://img.shields.io/travis/liufengting/FTFoldingTableView.svg?style=flat)](https://travis-ci.org/liufengting/FTFoldingTableView)
[![GitHub stars](https://img.shields.io/github/stars/liufengting/FTFoldingTableView.svg)](https://github.com/liufengting/FTFoldingTableView/stargazers)

FTFoldingTableView. Folding cells with simple delegates, and change UI looks in a few lines of code.


# ScreenShots

| Style	| Left	| Right	|
|:-------------|:-------------:|:-------------:|
| fold | <img src="/Screenshots/Screenshots1.PNG" width="320"/> | <img src="/Screenshots/Screenshots3.PNG" width="320"/> |
| show | <img src="/Screenshots/Screenshots2.PNG" width="320"/> | <img src="/Screenshots/Screenshots4.PNG" width="320"/> |

# Usage

## Required Methods

* preferred ArrowPosition

```objective-c
- (FTFoldingSectionHeaderArrowPosition)perferedArrowPositionForFTFoldingTableView:(FTFoldingTableView *)ftTableView
{
    return self.arrowPosition;
}
```
* numberOfSectionForFTFoldingTableView

```objective-c
- (NSInteger )numberOfSectionForFTFoldingTableView:(FTFoldingTableView *)ftTableView
{
    return 5;
}

```
* numberOfRowsInSection

```objective-c
- (NSInteger )ftFoldingTableView:(FTFoldingTableView *)ftTableView numberOfRowsInSection:(NSInteger )section
{
    return 3;
}
```
* heightForHeaderInSection

```objective-c
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForHeaderInSection:(NSInteger )section
{
    return 60;
}
```
* heightForRowAtIndexPath

```objective-c
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
```
* titleForHeaderInSection

```objective-c
- (NSString *)ftFoldingTableView:(FTFoldingTableView *)ftTableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section %ld",section];
}
```
* cellForRowAtIndexPath

```objective-c
- (UITableViewCell *)ftFoldingTableView:(FTFoldingTableView *)ftTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [ft_tableView dequeueReusableCellWithIdentifier:DemoTableViewIdentifier forIndexPath:indexPath];
    
    
    return cell;
}
```
* didSelectRowAtIndexPath

```objective-c
- (void )ftFoldingTableView:(FTFoldingTableView *)ftTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ftTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
```
## Optional Methods

* descriptionForHeaderInSection

```objective-c
- (NSString *)ftFoldingTableView:(FTFoldingTableView *)ftTableView descriptionForHeaderInSection:(NSInteger )section
{
    return @"description";
}
```
* arrowImageForSection

```objective-c
- (UIImage *)ftFoldingTableView:(FTFoldingTableView *)ftTableView arrowImageForSection:(NSInteger )section
{
    return [UIImage imageNamed:@"Arrowhead"];
}
```
* backgroundColorForHeaderInSection

```objective-c
- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView backgroundColorForHeaderInSection:(NSInteger )section
{
    return [UIColor grayColor];
}
```
* fontForTitleInSection

```objective-c
- (UIFont *)ftFoldingTableView:(FTFoldingTableView *)ftTableView fontForTitleInSection:(NSInteger )section
{
    return [UIFont boldSystemFontOfSize:16];
}
```
* fontForDescriptionInSection

```objective-c
- (UIFont *)ftFoldingTableView:(FTFoldingTableView *)ftTableView fontForDescriptionInSection:(NSInteger )section
{
    return [UIFont systemFontOfSize:13];
}
```
* textColorForTitleInSection

```objective-c
- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView textColorForTitleInSection:(NSInteger )section
{
    return [UIColor whiteColor];
}
```
* textColorForDescriptionInSection

```objective-c
- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView textColorForDescriptionInSection:(NSInteger )section
{
    return [UIColor whiteColor];
}
```

# Installation

## Manually

* clone this repo.
* Simply drop the '/FTFoldingTableViewLib' folder into your project.
* Enjoy! 🍺

## Cocoapods

FTFoldingTableView is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'FTFoldingTableView'
```



# Need to know

* I used two days to finish this project, and then uploaded it to Cocoapods, so I didn't have enough time to test it;if you have any questions, please let me know. I'll fill this README in the near future.


