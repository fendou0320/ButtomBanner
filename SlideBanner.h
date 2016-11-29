//
//  SlideBanner.h
//  ButtomBanner
//
//  Created by 王江亮 on 16/11/28.
//  Copyright © 2016年 WangJiangliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SlideBanner;
@protocol SlideBannerDelegate <NSObject>
@optional
- (void)slideBanner: (SlideBanner *)view isSlide: (BOOL)siSlide;
@end

@interface SlideBanner : UIView<UIGestureRecognizerDelegate>

@property (nonatomic, weak) id<SlideBannerDelegate> sliderDetegate;


@end
