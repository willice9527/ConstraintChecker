//
//  BBCCResult.m
//  Pods
//
//  Created by 刘金林 on 2017/8/30.
//
//

#import "BBCCResult.h"

@implementation BBCCResult

+ (instancetype)resultWithView:(UIView *)view {
  BBCCResult *result = [BBCCResult new];
  result.view = view;
  return result;
}

- (BOOL)isEqual:(id)object {
  if (![object isKindOfClass:[self class]]) {
    return NO;
  }
  return [self.view isEqual:[object view]];
}

- (NSUInteger)hash {
  return [self.view hash];
}

- (NSString *)description {
  NSMutableString *des = [NSMutableString string];
  [des appendFormat:@"%@%p", [self.view class], self.view];
  [des appendString:NSStringFromCGRect(self.oriFrame)];
  [des appendFormat:@"|%@", NSStringFromCGRect(self.toggledFrame)];
  return des;
}

@end
