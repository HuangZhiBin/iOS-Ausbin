//
//  UIViewController+Dealloc.m
//  Languages
//
//  Created by lmb on 2017/4/26.
//  Copyright © Dianbo.co. All rights reserved.
//

#import "UIViewController+Dealloc.h"
#import <objc/runtime.h>

@implementation UIViewController (Dealloc)

#if DEBUG

+ (void)load {
    [super load];
    
    SEL originSEL  = NSSelectorFromString(@"dealloc");
    SEL swapSEL = @selector(myDealloc);
    
    Method originMethod = class_getInstanceMethod(self, originSEL);
    Method swapMethod = class_getInstanceMethod(self, swapSEL);
    
    IMP originIMP = method_getImplementation(originMethod);
    IMP swapIMP = method_getImplementation(swapMethod);
    BOOL didAddMethod = class_addMethod(self, originSEL, swapIMP, method_getTypeEncoding(originMethod));
    
    if(didAddMethod) {
        class_replaceMethod(self, swapSEL, originIMP, method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swapMethod);
    }
}

- (void)myDealloc {
    NSLog(@"💋 [Dealloc] %@", NSStringFromClass([self class]));
    [self myDealloc];
}

#endif

@end
