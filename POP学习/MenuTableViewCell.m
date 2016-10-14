//
//  MenuTableViewCell.m
//  POP学习
//
//  Created by Jude on 16/9/29.
//  Copyright © 2016年 Jude. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "POP.h"
#import "UIColor+CustomColors.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.textColor = [UIColor customGrayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:20];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        POPBasicAnimation *basicAn = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
     //   basicAn.toValue = [NSValue valueWithCGPoint:CGPointMake(.95, .95)];
        basicAn.toValue = [NSValue valueWithCGSize:CGSizeMake(.95, .95)];
        basicAn.duration = 0.1;
        [self.textLabel pop_addAnimation:basicAn forKey:@"basicAn"];
        } else {
        POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        spring.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        spring.velocity = [NSValue valueWithCGPoint:CGPointMake(5, 5)];
        spring.springBounciness = 20;
      //  spring.velocity = @10;
        [self.textLabel pop_addAnimation:spring forKey:@"srping"];
    }
}

@end
