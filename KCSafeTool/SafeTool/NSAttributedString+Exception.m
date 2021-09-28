//
//  NSAttributedString+Exception.m
//  KCSafeTool
//
//  Created by FanQiLe on 2021/9/27.
//

#import "NSAttributedString+Exception.h"
#import "NSObject+Swizzling.h"

@implementation NSAttributedString (Exception)


+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("NSConcreteAttributedString") swizzleMethod:@selector(initWithString:) swizzledSelector:@selector(alert_replaceInitWithString:)];
            
        }
    });
}

-(instancetype)alert_replaceInitWithString:(NSString*)aString{
    if (!aString) {
        return nil;
    }
    return [self alert_replaceInitWithString:aString];
}

@end
