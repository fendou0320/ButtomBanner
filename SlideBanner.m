//
//  SlideBanner.m
//  ButtomBanner
//
//  Created by 王江亮 on 16/11/28.
//  Copyright © 2016年 WangJiangliang. All rights reserved.
//

#import "SlideBanner.h"

@implementation SlideBanner{
    
    CGPoint _point;
}


- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.frame.size.width/2;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        self.backgroundColor = [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5];
    }
    return self;
}

//单击方法
- (void)handleSingleTap{
    
    if ([self.sliderDetegate respondsToSelector:@selector(slideBanner:isSlide:)]) {
        [self.sliderDetegate slideBanner:self isSlide:YES];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _point = [touch locationInView:self];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self nslogWithStr:@"正在滑动"];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    CGFloat nowX = point.x - _point.x;
    CGFloat nowY = point.y - _point.y;
    if (nowX < 0) {
        nowX = 0;
    }else if (nowX > (self.superview.frame.size.width - self.frame.size.width)){
        nowX = self.superview.frame.size.width - self.frame.size.width;
    }
    if (nowY < 0) {
        nowY = 0;
    }else if (nowY > (self.superview.frame.size.height - self.frame.size.height)){
        nowY = self.superview.frame.size.height - self.frame.size.height;
    }
    NSLog(@"----%.2f",nowX);
    self.frame = CGRectMake(nowX, nowY, self.frame.size.width, self.frame.size.height);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
{
    [self nslogWithStr:@"滑动结束"];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    [self backSlide:point];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [self nslogWithStr:@"取消"];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    [self backSlide:point];
}

- (void)backSlide: (CGPoint )point{

    BOOL isLeft = point.x > (self.superview.frame.size.width/2)?NO:YES;
    
    CGFloat viewWidth = self.superview.frame.size.width;
    CGFloat selfWidth = self.frame.size.width;
    
    CGFloat nowX = point.x - _point.x;
    CGFloat nowY = point.y - _point.y;
    
    //判断是否位置没变
    if ((nowX == self.frame.origin.x)&&(nowY == self.frame.origin.y)) {
        [self handleSingleTap];
        return;
    }
    
    if (nowX < 0) {
        nowX = 0;
    }else if (nowX > (self.superview.frame.size.width - self.frame.size.width)){
        nowX = self.superview.frame.size.width - self.frame.size.width;
    }
    if (nowY < 0) {
        nowY = 0;
    }else if (nowY > (self.superview.frame.size.height - self.frame.size.height)){
        nowY = self.superview.frame.size.height - self.frame.size.height;
    }
    
    if (isLeft == YES) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self setFrame:CGRectMake(0, nowY, self.frame.size.width, self.frame.size.height)];
        } completion:^(BOOL finished) {
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self setFrame:CGRectMake(viewWidth-selfWidth, nowY, self.frame.size.width, self.frame.size.height)];
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)nslogWithStr: (NSString *)str{

    NSLog(@"----------------%@-----------------", str);
}


@end
