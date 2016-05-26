//
//  ViewController.m
//  CycleScrollView
//
//  Created by chenjun on 5/26/16.
//  Copyright © 2016 chenjun. All rights reserved.
//

#import "ViewController.h"
#import "CSCycleScrollView.h"

@interface ViewController ()

@property (strong, nonatomic) CSCycleScrollView *cycleView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cycleView = [[CSCycleScrollView alloc] init];
    self.cycleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.cycleView];
    
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cycleView
                                  attribute:(NSLayoutAttributeLeading)
                                  relatedBy:(NSLayoutRelationEqual)
                                     toItem:self.view
                                  attribute:(NSLayoutAttributeLeading)
                                 multiplier:1
                                   constant:10]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cycleView
                                  attribute:(NSLayoutAttributeTrailing)
                                  relatedBy:(NSLayoutRelationEqual)
                                     toItem:self.view
                                  attribute:(NSLayoutAttributeTrailing)
                                 multiplier:1
                                   constant:-10]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cycleView
                                  attribute:(NSLayoutAttributeTop)
                                  relatedBy:(NSLayoutRelationEqual)
                                     toItem:self.view
                                  attribute:(NSLayoutAttributeTop)
                                 multiplier:1
                                   constant:20]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cycleView
                                  attribute:(NSLayoutAttributeHeight)
                                  relatedBy:(NSLayoutRelationEqual)
                                     toItem:nil
                                  attribute:(NSLayoutAttributeHeight)
                                 multiplier:0
                                   constant:300]];
    
    [self.cycleView updateUIWithData:@[@"1", @"2", @"3"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
