//
//  CircleView.h
//  POP学习
//
//  Created by Jude on 16/10/14.
//  Copyright © 2016年 Jude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

/**  */
@property (nonatomic, strong) UIColor *strokeColor;

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;

@end
