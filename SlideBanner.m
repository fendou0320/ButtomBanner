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
        [self creatRecognizer];
        [self singleClick];
    }
    return self;
}

- (void)creatRecognizer{
    
    //实例化手势监听
    UISwipeGestureRecognizer *longPress = [[UISwipeGestureRecognizer alloc] init];//WithTarget:self action:@selector(handleTableviewCellLongPressed:)];
//    UILongPressGestureRecognizer *longPress =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTableviewCellLongPressed:)];
    //代理
    longPress.delegate = self;
    //将长按手势添加到需要实现长按操作的视图里
    [self addGestureRecognizer:longPress];
}


//单击手势
- (void)singleClick{
    //单击手势
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleTap];
}

//单击
- (void)handleSingleTap:(UITapGestureRecognizer *)sender{
    
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
    
    [self setFrame:CGRectMake(nowX, nowY, self.frame.size.width, self.frame.size.height)];
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
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self setFrame:CGRectMake(0, nowY, self.frame.size.width, self.frame.size.height)];
        } completion:^(BOOL finished) {
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self setFrame:CGRectMake(viewWidth-selfWidth, nowY, self.frame.size.width, self.frame.size.height)];
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)nslogWithStr: (NSString *)str{

    NSLog(@"----------------%@-----------------", str);
}


@end
