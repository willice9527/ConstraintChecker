//
//  BBCConstraintsCheck.m
//  Pods
//
//  Created by 刘金林 on 2017/8/30.
//
//

#import "BBCConstraintsCheck.h"
#import <objc/runtime.h>
#import <UIView+BBCHashKey.h>
#import <BBCCResult.h>
#import <BBCLogComponent.h>

static void(ConstraintCheckCallback)(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info);
static NSMutableDictionary <NSString *,BBCCResult *>*BBCErrorContainer = nil;
static UIButton *BBCErrorIndicator = nil;
static NSMutableArray <BBCCResult *>*BBCDisplayedErrorViews = nil;

static inline BOOL BBCIsBlankString(NSString *oriString) {
  if (!oriString ||
      ![oriString isKindOfClass:[NSString class]] ||
      oriString.length <= 0 ||
      [oriString isEqualToString:@""]) {
    return YES;
  }
  NSCharacterSet *whiteCharSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
  return [[oriString stringByTrimmingCharactersInSet:whiteCharSet] isEqualToString:@""];
}

@implementation BBCConstraintsCheck

#ifdef DEBUG

+ (void)load {
  if ([self class] == [BBCConstraintsCheck class]) {
    BBCErrorContainer = [NSMutableDictionary new];
    BBCDisplayedErrorViews = [NSMutableArray new];
    CFRunLoopActivity activities = kCFRunLoopBeforeWaiting | kCFRunLoopExit;
    CFIndex highOrder = 0xffffff;
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                            activities,
                                                            YES,
                                                            highOrder,
                                                            &ConstraintCheckCallback,
                                                            NULL);
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
  }
}

+ (void)checkConstaints {
  //check key window only
  UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
  [self shrinkInvalidResults];
  [self checkSubOf:keywindow];
  [self showErrorIndicatorIfNeeded];
}

+ (void)checkSubOf:(UIView *)topView {
  if (topView.subviews.count <= 0) {
    [self checkIfNeededTo:topView];
    return;
  }
  [topView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [self checkIfNeededTo:obj];
    [self checkSubOf:obj];
  }];
}

+ (void)checkIfNeededTo:(UIView *)view {
  if ([NSStringFromClass([view class]) hasPrefix:@"_"]) {//private class of apple
    return;
  }
  if (view.alpha <= 0.01 ||
      view.hidden) {
    return;
  }
  if ([view.layer animationKeys].count) {
    return;
  }
  if (![view hasAmbiguousLayout]) {
    return;
  }
  BBCCResult *result = BBCErrorContainer[view.bbc_hashKey];
  if (result) {
    result.toggledFrame = view.frame;
  } else {
    result = [BBCCResult resultWithView:view];
    result.oriFrame = view.frame;
    BBCErrorContainer[view.bbc_hashKey] = result;
    [view exerciseAmbiguityInLayout];
    printf("\n🤠🤠🤠 %s hasAmbiguousLayout 😡😡😡\n", [view.description UTF8String]);
  }
}

+ (void)shrinkInvalidResults {
  NSMutableArray <NSString *>* nilViewKeys = [NSMutableArray array];
  [BBCErrorContainer enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, BBCCResult * _Nonnull obj, BOOL * _Nonnull stop) {
    if (!obj.view) {
      [nilViewKeys addObject:key];
    }
  }];
  [BBCErrorContainer removeObjectsForKeys:nilViewKeys];
}

+ (void)showErrorIndicatorIfNeeded {
  [BBCDisplayedErrorViews removeAllObjects];
  [BBCErrorContainer.allValues enumerateObjectsUsingBlock:^(BBCCResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if (obj.view.window) {
      [BBCDisplayedErrorViews addObject:obj];
    }
  }];
  if (BBCDisplayedErrorViews.count) {
    [self showIndicator];
  } else {
    [self removeIndicator];
  }
}

+ (void)showIndicator {
  if (!BBCErrorIndicator) {
    BBCErrorIndicator = [UIButton buttonWithType:UIButtonTypeCustom];
    BBCErrorIndicator.frame = CGRectMake(0, 0, 30, 30);
    [BBCErrorIndicator setTitle:@"i" forState:UIControlStateNormal];
    [BBCErrorIndicator setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    BBCErrorIndicator.backgroundColor = [UIColor orangeColor];
    BBCErrorIndicator.layer.cornerRadius = 15.f;
    BBCErrorIndicator.clipsToBounds = YES;
    [BBCErrorIndicator addTarget:self action:@selector(errorDetailCheckLog) forControlEvents:UIControlEventTouchUpInside];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.85, 0.85, 0.85)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue = @1.f;
    opacityAnimation.fromValue = @0.5;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1.f;
    group.animations = @[ scaleAnimation, opacityAnimation ];
    group.repeatCount = INFINITY;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [BBCErrorIndicator.layer addAnimation:group forKey:@"group"];
  }
  UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
  [keywindow addSubview:BBCErrorIndicator];
  BBCErrorIndicator.center = CGPointMake(keywindow.bounds.size.width / 2.f + 80, 30);
}

+ (void)removeIndicator {
  [BBCErrorIndicator removeFromSuperview];
  BBCErrorIndicator = nil;
}

+ (void)errorDetailCheckLog {
  [BBCDisplayedErrorViews enumerateObjectsUsingBlock:^(BBCCResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    UIView *view = obj.view;
    [view exerciseAmbiguityInLayout];
    view.layer.borderColor = [UIColor redColor].CGColor;
    view.layer.borderWidth = 1.f;
  }];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
  NSString *consoleLog = [BBCDisplayedErrorViews.firstObject.view performSelector:NSSelectorFromString(@"_autolayoutTrace")];
  printf("\n👿👿👿\n %s \n👿👿👿\n", [[self filteredLog:consoleLog] UTF8String]);
#pragma clang diagnostic pop
}

+ (NSString *)filteredLog:(NSString *)oriLog {
  __block BBCLogComponent *rootComponent = nil;
  [oriLog enumerateSubstringsInRange:NSMakeRange(0, oriLog.length) options:NSStringEnumerationByLines usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
    if (!BBCIsBlankString(substring)) {
      if (!rootComponent) {
        rootComponent = [[BBCLogComponent alloc] initWithStringContent:substring];
      } else {
        [rootComponent addSubLogComponent:[[BBCLogComponent alloc] initWithStringContent:substring]];
      }
    }
  }];
  [rootComponent shrinkNoneAmbiguousLog];
  return [rootComponent description];
}

#endif

static void(ConstraintCheckCallback)(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
  NSCAssert([NSThread isMainThread], @"should on main thread");
  if (![NSThread isMainThread]) {
    return;
  }
  [BBCConstraintsCheck checkConstaints];
};

@end
