//
//  XQFirstViewController.h
//  XQSideBarDemo
//
//  Created by HySoft on 13-7-11.
//  Copyright (c) 2013年 HySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQFirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UILabel  *_textLabel;
    
    UITableView  *_tableView;
    NSMutableArray *_array1;
    NSMutableArray *_array2;
}

@property (nonatomic,assign) int index;

-(void)leftBarButtonClicked;

@end
