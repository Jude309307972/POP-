//
//  FlatButton.m
//  POP学习
//
//  Created by Jude on 16/9/29.
//  Copyright © 2016年 Jude. All rights reserved.
//

#import "FlatButton.h"
#import "POP.h"

@implementation FlatButton

+ (instancetype)button
{
    return [self buttonWithType:UIButtonTypeCustom];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Instance methods

- (UIEdgeInsets)titleEdgeInsets
{
    return UIEdgeInsetsMake(4.f,
                            28.f,
                            4.f,
                            28.f);
}

- (CGSize)intrinsicContentSize
{
    CGSize s = [super intrinsicContentSize];
    
    return CGSizeMake(s.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right,
                      s.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom);
    
}

- (void)setup
{
    self.backgroundColor = self.tintColor;
    self.layer.cornerRadius = 4.0f;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium"
                                           size:22];
    [self addTarget:self action:@selector(scaleToSmall) forControlEvents:UIControlEventTouchDown  | UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(scaleAnimation)
   forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(scaleToDefault)
   forControlEvents:UIControlEventTouchDragExit];
}

- (void)scaleToSmall
{
    POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    basic.toValue = [NSValue valueWithCGPoint:CGPointMake(.8, .8)];
    [self pop_addAnimation:basic forKey:@"basic"];
}

- (void)scaleAnimation
{
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    spring.springBounciness = 15;
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(1.f, 1.f)];
    spring.velocity = [NSValue valueWithCGPoint:CGPointMake(10, 10)];
    [self pop_addAnimation:spring forKey:@"basic"];

}

- (void)scaleToDefault
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}

@end
