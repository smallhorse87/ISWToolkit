//
//  NSDictionary+NullSafe.m
//  youngcity
//
//  Created by zhitian on 2017/8/12.
//  Copyright © 2017年 Zhitian Network Tech. All rights reserved.
//

#import "NSMutableDictionary+NullSafe.h"
#import <objc/runtime.h>
@implementation NSMutableDictionary (NullSafe)

#if DEBUG //开发环境

#elif PRODUCT //测试环境

#else       //生产环境


- (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(safe_setObject:forKey:)];
        
    });
    
}

- (void)safe_setObject:(id)value forKey:(NSString *)key {
    if (value) {
        [self safe_setObject:value forKey:key];
    }else {
        //        NullSafeLogFormatter(@"[NSMutableDictionary setObject: forKey:], Object cannot be nil");
    }
}


#endif


@end
