#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BBCConstraintsCheck.h"
#import "BBCCResult.h"
#import "BBCLogComponent.h"
#import "UIView+BBCHashKey.h"

FOUNDATION_EXPORT double ConstraintCheckerVersionNumber;
FOUNDATION_EXPORT const unsigned char ConstraintCheckerVersionString[];

