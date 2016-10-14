//
//  CircleView.m
//  POP学习
//
//  Created by Jude on 16/10/14.
//  Copyright © 2016年 Jude. All rights reserved.
//

#import "CircleView.h"
#import "POP.h"

@interface CircleView()
/**  */
@property (nonatomic, strong) CAShapeLayer *circelLayer;
@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCircleLayer];
    }
    return self;
}

- (void)addCircleLayer
{
    CGFloat lineWidth = 4.f;
    CGFloat radius = CGRectGetWidth(self.bounds)/2 - lineWidth/2;
    self.circelLayer = [CAShapeLayer layer];
    CGRect rect = CGRectMake(lineWidth/2, lineWidth/2, radius * 2, radius * 2);
    self.circelLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath;;
    
    self.circelLayer.strokeColor = self.tintColor.CGColor;
    self.circelLayer.fillColor = nil;
    self.circelLayer.lineWidth = lineWidth;
    self.circelLayer.lineCap = kCALineCapRound;
    self.circelLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:self.circelLayer];
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    self.circelLayer.strokeColor = strokeColor.CGColor;
    _strokeColor = strokeColor;
}

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated
{
    if (animated) {
        [self animateToStrokeEnd:strokeEnd];
        return;
    }
    self.circelLayer.strokeEnd = strokeEnd;
}

- (void)animateToStrokeEnd:(CGFloat)strokeEnd
{
    POPSpringAnimation *stokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    stokeAnimation.toValue = @(strokeEnd);
    stokeAnimation.springBounciness = 12.f;
    stokeAnimation.removedOnCompletion = NO;
    [self.circelLayer pop_addAnimation:stokeAnimation forKey:@""];
}

@end
