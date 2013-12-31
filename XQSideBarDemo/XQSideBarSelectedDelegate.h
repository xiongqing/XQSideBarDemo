//
//  XQSideBarSelectedDelegate.h
//  XQSideBarDemo
//
//  Created by HySoft on 13-7-11.
//  Copyright (c) 2013年 HySoft. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum _SideBarShowDirection
{
    SideBarShowDirectionNone = 0,
    SideBarShowDirectionLeft = 1,
//    SideBarShowDirectionRight = 2
}SideBarShowDirection;

@protocol XQSideBarSelectedDelegate <NSObject>

-(void)leftSideBarSelectWithController:(UIViewController*)controller;
-(void)showSideBarControllerWithDirection:(SideBarShowDirection)direction;

@end
