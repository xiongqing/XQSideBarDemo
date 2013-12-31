//
//  XQSidebarViewController.h
//  XQSideBarDemo
//
//  Created by HySoft on 13-7-11.
//  Copyright (c) 2013年 HySoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQSideBarSelectedDelegate.h"

@interface XQSidebarViewController : UIViewController<XQSideBarSelectedDelegate,UINavigationControllerDelegate>
{
    UIView *contentView;
    UIView *navBackView;
}

+(id)share;
-(void)contentViewAddTapGestures;
-(void)tapOnContentView:(UITapGestureRecognizer *)tapGestureRecognizer;
-(void)panInContentView:(UIPanGestureRecognizer *)panGestureReconginzer;

-(void)moveAnimationWithDirection:(SideBarShowDirection)direction duration:(float)duration;
-(void)removepanGestureReconginzerWhileNavConPushed:(BOOL)push;

-(void)handSwipFrom:(UISwipeGestureRecognizer*)swipGesture;

@end
