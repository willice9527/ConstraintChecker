//
//  BBCViewController.m
//  ConstraintChecker
//
//  Created by willice9527 on 08/30/2017.
//  Copyright (c) 2017 willice9527. All rights reserved.
//

#import "BBCViewController.h"

@interface BBCViewController ()

@end

@implementation BBCViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self addDemoUI];
}

- (void)addDemoUI {
  UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
  btn1.backgroundColor = [UIColor yellowColor];
  [btn1 setTitle:@"button1" forState:UIControlStateNormal];
  btn1.titleLabel.font = [UIFont systemFontOfSize:14];
  [btn1 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
  btn1.translatesAutoresizingMaskIntoConstraints = NO;
  
  UILabel *label = [UILabel new];
  label.textColor = [UIColor blueColor];
  label.font = [UIFont systemFontOfSize:14];
  label.text = @"label";
  label.backgroundColor = [UIColor yellowColor];
  label.translatesAutoresizingMaskIntoConstraints = NO;
  
  [self.view addSubview:btn1];
  [self.view addSubview:label];
  
  NSLayoutConstraint *w1Cons = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:80];
  [btn1 addConstraint:w1Cons];
  NSLayoutConstraint *lConstraint = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.f constant:20];
  NSLayoutConstraint *tConstraint = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.f constant:110];
  NSLayoutConstraint *rConstraint = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeLeft multiplier:1.f constant:-10];
  NSLayoutConstraint *bbConstraint = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeBaseline relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeBaseline multiplier:1.f constant:0];
  [self.view addConstraints:@[lConstraint, tConstraint, rConstraint, bbConstraint]];
  
  
  NSLayoutConstraint *w2Cons = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:60];
  [label addConstraint:w2Cons];
  
  NSLayoutConstraint *rConstraint1 = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.f constant:30];
  [self.view addConstraints:@[rConstraint1]];
}

@end
