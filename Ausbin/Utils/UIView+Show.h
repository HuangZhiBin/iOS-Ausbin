//
//  UIButton+Block.h
//  BoothTag
//
//  Created by Josh Holtz on 4/22/12.
//  Copyright (c) 2012 Josh Holtz. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIView (Show)

-(void)showProgressHUBForSuccess:(BOOL)isSuccess message:(NSString*) msg;

-(void)showLoadingProgressHUB:(NSString*) msg;

-(void)hideLoadingProgressHUB;
@end
