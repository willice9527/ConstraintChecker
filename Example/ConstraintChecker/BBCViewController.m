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
  UILabel *label = [UILabel new];
  label.textColor = [UIColor blueColor];
  label.font = [UIFont systemFontOfSize:14];
  label.text = @"label";
  label.backgroundColor = [UIColor yellowColor];
  label.translatesAutoresizingMaskIntoConstraints = NO;
  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  btn.backgroundColor = [UIColor yellowColor];
  [btn setTitle:@"button" forState:UIControlStateNormal];
  btn.titleLabel.font = [UIFont systemFontOfSize:14];
  [btn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
  btn.translatesAutoresizingMaskIntoConstraints = NO;
  
  UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:@[label, btn]];
  stack.translatesAutoresizingMaskIntoConstraints = NO;
  stack.axis = UILayoutConstraintAxisHorizontal;
  stack.distribution = UIStackViewDistributionEqualSpacing;
  stack.alignment = UIStackViewAlignmentFill;
  stack.spacing = 10.f;
  [self.view addSubview:stack];
}

@end
