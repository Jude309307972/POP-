//
//  CircleViewController.m
//  POP学习
//
//  Created by Jude on 16/9/30.
//  Copyright © 2016年 Jude. All rights reserved.
//

#import "CircleViewController.h"
#import "CircleView.h"
#import "UIColor+CustomColors.h"

@interface CircleViewController ()
@property(nonatomic) CircleView *circleView;
@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCircleView];
    [self addSlider];
}

- (void)addCircleView
{
    CGRect frame = CGRectMake(0, 0, 200, 200);
    self.circleView = [[CircleView alloc] initWithFrame:frame];
    self.circleView.strokeColor = [UIColor customBlueColor];
    self.circleView.center = self.view.center;
    [self.view addSubview:self.circleView];
}

- (void)addSlider
{
    UISlider *slider = [UISlider new];
    slider.value = 0.7f;
    slider.tintColor = [UIColor customBlueColor];
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    NSDictionary *views = NSDictionaryOfVariableBindings(slider, _circleView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_circleView]-(40)-[slider]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[slider]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.circleView setStrokeEnd:slider.value animated:NO];

}

- (void)sliderChanged:(UISlider *)slider
{
    [self.circleView setStrokeEnd:slider.value animated:NO ];
}

@end
