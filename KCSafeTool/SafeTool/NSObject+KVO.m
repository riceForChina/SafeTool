//
//  NSObject+KVO.m
//  KCSafeTool
//
//  Created by FanQiLe on 2021/9/27.
//

#import "NSObject+KVO.h"
#import "NSObject+Swizzling.h"

@implementation NSObject (KVO)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            
            [objc_getClass("NSObject") swizzleMethod:@selector(removeObserver:forKeyPath:) swizzledSelector:@selector(removeDasen:forKeyPath:)];
            [objc_getClass("NSObject") swizzleMethod:@selector(addObserver:forKeyPath:options:context:) swizzledSelector:@selector(addDasen:forKeyPath:options:context:)];
            
        }
        
    });
}

// 交换后的方法
- (void)removeDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    if ([self observerKeyPath:keyPath observer:observer]) {
        [self removeDasen:observer forKeyPath:keyPath];
    }
}


// 交换后的方法
- (void)addDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    
    objc_setAssociatedObject(self, "addObserverFlag", @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (![self observerKeyPath:keyPath observer:observer]) {
        [self addDasen:observer forKeyPath:keyPath options:options context:context];
    }
}


// 进行检索获取Key
- (BOOL)observerKeyPath:(NSString *)key observer:(id )observer
{
    id info = self.observationInfo;
    NSArray *array = [info valueForKey:@"_observances"];
    for (id objc in array) {
        id Properties = [objc valueForKeyPath:@"_property"];
        id newObserver = [objc valueForKeyPath:@"_observer"];
        
        NSString *keyPath = [Properties valueForKeyPath:@"_keyPath"];
        if ([key isEqualToString:keyPath] && [newObserver isEqual:observer]) {
            return YES;
        }
    }
    return NO;
}

@end
