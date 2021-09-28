//
//  NSMutableAttributedString+Exception.m
//  KCSafeTool
//
//  Created by FanQiLe on 2021/9/27.
//

#import "NSMutableAttributedString+Exception.h"
#import "NSObject+Swizzling.h"

@implementation NSMutableAttributedString (Exception)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("NSConcreteMutableAttributedString") swizzleMethod:@selector(replaceCharactersInRange:withString:) swizzledSelector:@selector(alert_replaceCharactersInRange:withString:)];
            [objc_getClass("NSConcreteMutableAttributedString") swizzleMethod:@selector(initWithString:) swizzledSelector:@selector(alert_replaceInitWithString:)];

        }
    });
}

- (void)alert_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    if ((range.location + range.length) > self.length) {
        return;
    }
    if (!aString) {
        return;
    }
    return [self alert_replaceCharactersInRange:range withString:aString];
}

-(instancetype)alert_replaceInitWithString:(NSString*)aString{
    if (!aString) {
        return nil;
    }
    return [self alert_replaceInitWithString:aString];
}

@end
