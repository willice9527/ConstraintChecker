//
//  BBCCResult.h
//  Pods
//
//  Created by 刘金林 on 2017/8/30.
//
//

#import <Foundation/Foundation.h>

@interface BBCCResult : NSObject

@property (nonatomic, weak) UIView *view;
@property (nonatomic, assign) CGRect oriFrame;
@property (nonatomic, assign) CGRect toggledFrame;

+ (instancetype)resultWithView:(UIView *)view;

@end
