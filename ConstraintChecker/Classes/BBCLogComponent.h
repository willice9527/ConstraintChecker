//
//  BBCLogComponent.h
//  Pods
//
//  Created by 刘金林 on 2017/8/30.
//
//

#import <Foundation/Foundation.h>

@interface BBCLogComponent : NSObject

@property (nonatomic, weak) BBCLogComponent *parentComponent;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSUInteger indent;
@property (nonatomic, strong) NSMutableArray <BBCLogComponent *>*subComponents;
@property (nonatomic, assign, getter=isAmbiguousLog) BOOL ambiguousLog;

- (instancetype)initWithStringContent:(NSString *)content;
- (void)addSubLogComponent:(BBCLogComponent *)component;
- (void)shrinkNoneAmbiguousLog;

@end
