//
//  BBCLogComponent.m
//  Pods
//
//  Created by 刘金林 on 2017/8/30.
//
//

#import "BBCLogComponent.h"

@implementation BBCLogComponent

- (instancetype)initWithStringContent:(NSString *)content {
  self = [super init];
  if (self) {
    _content = [content copy];
    _subComponents = [NSMutableArray array];
    _ambiguousLog = [content containsString:@"AMBIGUOUS LAYOUT"];
    NSRange indentRange = [content rangeOfString:@"|   " options:NSBackwardsSearch];
    if (indentRange.location != NSNotFound) {
      _indent = indentRange.location + indentRange.length;
    }
  }
  return self;
}

- (void)addSubLogComponent:(BBCLogComponent *)component {
  if (component.indent <= 0) {
    return;
  }
  BBCLogComponent *parentComponent = [self superComponentForIndent:component.indent fromComponent:self];
  [parentComponent.subComponents addObject:component];
  component.parentComponent = parentComponent;
  [component markAllParentAmbiguousIfNeeded];
}

- (BBCLogComponent *)superComponentForIndent:(NSUInteger)indent fromComponent:(BBCLogComponent *)fromComponent {
  NSAssert(indent > fromComponent.indent, @"indent assert failed");
  if (fromComponent.subComponents.lastObject) {
    if (fromComponent.subComponents.lastObject.indent < indent) {
      return [self superComponentForIndent:indent fromComponent:fromComponent.subComponents.lastObject];
    } else {
      return fromComponent;
    }
  } else {
    return fromComponent;
  }
}

- (void)markAllParentAmbiguousIfNeeded {
  if (!self.isAmbiguousLog) {
    return;
  }
  BBCLogComponent *parentCom = self.parentComponent;
  while (parentCom) {
    parentCom.ambiguousLog = YES;
    parentCom = parentCom.parentComponent;
  }
}

- (void)shrinkNoneAmbiguousLog {
  [self shrinkFromComponent:self];
}

- (void)shrinkFromComponent:(BBCLogComponent *)com {
  if (com.subComponents.count <= 0) {
    return;
  }
  for (NSInteger i = com.subComponents.count - 1; i >= 0; i--) {
    if (!com.subComponents[i].isAmbiguousLog) {
      [com.subComponents removeObjectAtIndex:i];
    } else {
      [self shrinkFromComponent:com.subComponents[i]];
    }
  }
}

- (NSString *)description {
  NSMutableString *des = [NSMutableString string];
  [self des:des fromComponent:self];
  return des;
}

- (void)des:(NSMutableString *)des fromComponent:(BBCLogComponent *)com {
  [des appendFormat:@"%@%@", @"\n", com.content];
  if (com.subComponents.count <= 0) {
    return;
  }
  for (BBCLogComponent *subCom in com.subComponents) {
    [self des:des fromComponent:subCom];
  }
}

@end
