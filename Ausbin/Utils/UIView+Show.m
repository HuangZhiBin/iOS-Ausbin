//
//  UIButton+Block.m
//  BoothTag
//
//  Created by Josh Holtz on 4/22/12.
//  Copyright (c) 2012 Josh Holtz. All rights reserved.
//

#import "UIView+Show.h"
#import <objc/runtime.h>
#import <MBProgressHUD/MBProgressHUD.h>
@implementation UIView (Show)
#define TAG_HUB 4768399
-(void)showProgressHUBForSuccess:(BOOL)isSuccess message:(NSString*) msg
{
    [self hideLoadingProgressHUB];
    if(isSuccess){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        [hud setTag:TAG_HUB];
        // Set the custom view mode to show any view.
        hud.mode = MBProgressHUDModeCustomView;
        // Set an image view with a checkmark.
        UIImage *image = [[UIImage imageNamed:@"hub_correct"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        hud.customView = [[UIImageView alloc] initWithImage:image];
        // Looks a bit nicer if we make it square.
        hud.square = YES;
        // Optional label text.
        hud.label.text = msg;
        [hud hideAnimated:NO afterDelay:2.f];
    }
    else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        
        // Set the text mode to show only text.
        hud.mode = MBProgressHUDModeText;
        hud.label.text = msg;
        // Move to bottm center.
        hud.offset = CGPointMake(0.f, 0.f);
        
        [hud hideAnimated:NO afterDelay:2.f];
        /*
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        [hud setTag:TAG_HUB];
        // Set the custom view mode to show any view.
        hud.mode = MBProgressHUDModeCustomView;
        // Set an image view with a checkmark.
        UIImage *image = [[UIImage imageNamed:@"hub_wrong"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        hud.customView = [[UIImageView alloc] initWithImage:image];
        // Looks a bit nicer if we make it square.
        hud.square = YES;
        // Optional label text.
        hud.label.text = msg;
        [hud hideAnimated:NO afterDelay:2.f];
         */
    }
}

-(void)showLoadingProgressHUB:(NSString*) msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    [hud setTag:TAG_HUB];
    // Set the label text.
    hud.label.text= msg;
}

-(void)hideLoadingProgressHUB
{
    MBProgressHUD *hud = [self viewWithTag:TAG_HUB];
    if(hud)[hud hideAnimated:NO];
}

@end
