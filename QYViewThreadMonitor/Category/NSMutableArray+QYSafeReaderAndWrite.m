//
//  NSMutableArray+QYSafeReaderAndWrite.m
//  QYViewThreadMonitor
//
//  Created by liuming on 2017/1/11.
//  Copyright © 2017年 burning. All rights reserved.
//

#import "NSMutableArray+QYSafeReaderAndWrite.h"
#import "QYSwizzleHelper.h"
@implementation NSMutableArray (QYSafeReaderAndWrite)

+(void)load{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [QYSwizzleHelper swizzleMethods:[self class] originalSelector:@selector(addObject:) swizzledSelector:@selector(qy_addObject:)];
        [QYSwizzleHelper swizzleMethods:[self class] originalSelector:@selector(objectAtIndex:) swizzledSelector:@selector(qy_objectAtIndex:)];
    });
}

- (void)qy_addObject:(id)anObject
{
    NSAssert(anObject != nil, @"addObject can not nil");
    
    if ([NSThread isMainThread]) {
        
        [self qy_addObject:anObject];
    } else {
        @synchronized (self) {
            [self qy_addObject:anObject];
        }
    }
    
}

- (id)qy_objectAtIndex:(NSUInteger)index
{
    if ([NSThread isMainThread]) {
        
        return [self qy_objectAtIndex:index];
        
    } else{
    
        @synchronized (self) {
            
            return [self qy_objectAtIndex:index];
        }
    }
    return nil;
}
@end
