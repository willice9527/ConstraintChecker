//
//  UIView+BBCHashKey.m
//  Pods
//
//  Created by 刘金林 on 2017/8/30.
//
//

#import "UIView+BBCHashKey.h"

@implementation UIView (BBCHashKey)

- (NSString *)bbc_hashKey {
  return [NSString stringWithFormat:@"%@", @([self hash])];
}

@end
