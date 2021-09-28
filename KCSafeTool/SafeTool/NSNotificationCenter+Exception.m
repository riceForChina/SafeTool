//
//  NSNotificationCenter+Exception.m
//  KCSafeTool
//
//  Created by FanQiLe on 2021/9/28.
//

#import "NSNotificationCenter+Exception.h"
#import "NSObject+Swizzling.h"

@implementation NSNotificationCenter (Exception)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("NSNotificationCenter") swizzleMethod:@selector(addObserver:selector:name:object:) swizzledSelector:@selector(ghl_addObserver:selector:name:object:)];

            [objc_getClass("NSObject") swizzleMethod:NSSelectorFromString(@"dealloc") swizzledSelector:@selector(replaceDealloc)];
        }
    });
}

- (void)replaceDealloc
{
    NSString *addObserver = objc_getAssociatedObject(self, "addObserverFlag");
    if ([addObserver boolValue]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [self replaceDealloc];
}
- (void)ghl_addObserver:(id)observer selector:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject {
    [self ghl_addObserver:observer selector:aSelector name:aName object:anObject];
    
    objc_setAssociatedObject(observer, "addObserverFlag", @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
