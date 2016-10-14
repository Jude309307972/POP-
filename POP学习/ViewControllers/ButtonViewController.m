//
//  ButtonViewController.m
//  POP学习
//
//  Created by Jude on 16/9/29.
//  Copyright © 2016年 Jude. All rights reserved.
//

#import "ButtonViewController.h"
#import "FlatButton.h"
#import "UIColor+CustomColors.h"
#import "POP.h"

@interface ButtonViewController ()
@property (nonatomic) UILabel *errorLabel;
@property (nonatomic) FlatButton *button;
@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addButton];
    [self addLabel];
}

- (void)addButton
{
    self.button = [FlatButton button];
    self.button.backgroundColor = [UIColor customBlueColor];
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.button setTitle:@"Log in" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.button
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.button
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f
                                                           constant:0.f]];
}

- (void)addLabel
{
    self.errorLabel = [UILabel new];
    self.errorLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18];
    self.errorLabel.textColor = [UIColor customRedColor];
    self.errorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.errorLabel.text = @"Just a serious login error.";
    self.errorLabel.textAlignment = NSTextAlignmentCenter;
    [self.errorLabel sizeToFit];
    [self.view insertSubview:self.errorLabel belowSubview:self.button];
    self.errorLabel.layer.opacity = 0.0;
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.errorLabel
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.button
                              attribute:NSLayoutAttributeCenterX
                              multiplier:1
                              constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.errorLabel
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:NSLayoutRelationEqual toItem:self.button
                              attribute:NSLayoutAttributeCenterY
                              multiplier:1
                              constant:self.button.intrinsicContentSize.height]];
    self.errorLabel.layer.opacity = 0.0;

}

- (void)touchUpInside:(FlatButton *)button
{
    [self hideLabel];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
     //   [self.activityIndicatorView stopAnimating];
        [self shakeButton];
        [self showLabel];
    });
}

- (void)hideLabel
{
    POPBasicAnimation *layerScaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)];
    [self.errorLabel.layer pop_addAnimation:layerScaleAnimation forKey:@"layerScaleAnimation"];
    
    POPBasicAnimation *layerPositionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    layerPositionAnimation.toValue = @(self.button.layer.position.y);
    [self.errorLabel.layer pop_addAnimation:layerPositionAnimation forKey:@"layerPositionAnimation"];
}

- (void)showLabel
{
    self.errorLabel.layer.opacity = 1.0;
    POPSpringAnimation *layerScaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.springBounciness = 18;
    layerScaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.errorLabel.layer pop_addAnimation:layerScaleAnimation forKey:@"labelScaleAnimation"];
    
    POPSpringAnimation *layerPositionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    layerPositionAnimation.toValue = @(self.button.layer.position.y + self.button.intrinsicContentSize.height);
    layerPositionAnimation.springBounciness = 12;
    [self.errorLabel.layer pop_addAnimation:layerPositionAnimation forKey:@"layerPositionAnimation"];

    
}

#pragma mark Animations

- (void)shakeButton
{
    POPSpringAnimation *positinAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positinAnimation.velocity = @2000;
    positinAnimation.springBounciness = 20;
    [positinAnimation setCompletionBlock:^(POPAnimation * ani, BOOL finished) {
        self.button.userInteractionEnabled = YES;

    }];
    [self.button.layer pop_addAnimation:positinAnimation forKey:nil];
}

@end
