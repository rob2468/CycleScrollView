//
//  CSCycleScrollCell.m
//  CycleScrollView
//
//  Created by chenjun on 5/26/16.
//  Copyright © 2016 chenjun. All rights reserved.
//

#import "CSCycleScrollCell.h"

@implementation CSCycleScrollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor grayColor];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.titleLabel];
        
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.titleLabel
                                      attribute:(NSLayoutAttributeCenterX)
                                      relatedBy:(NSLayoutRelationEqual)
                                         toItem:self
                                      attribute:(NSLayoutAttributeCenterX)
                                     multiplier:1
                                       constant:0]];
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.titleLabel
                                      attribute:(NSLayoutAttributeCenterY)
                                      relatedBy:(NSLayoutRelationEqual)
                                         toItem:self
                                      attribute:(NSLayoutAttributeCenterY)
                                     multiplier:1
                                       constant:0]];
    }
    return self;
}

@end
