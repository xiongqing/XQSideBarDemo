//
//  XQLeftSideBarViewController.h
//  XQSideBarDemo
//
//  Created by HySoft on 13-7-11.
//  Copyright (c) 2013年 HySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XQSideBarSelectedDelegate;

@interface XQLeftSideBarViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView  *_tableView;
    NSMutableArray *_dataList;
    int _selectIndex;
}

@property (nonatomic,assign) id<XQSideBarSelectedDelegate> delegate;

-(UINavigationController *)subConWithIndex:(int)index;

@end
