//
//  XQLeftSideBarViewController.m
//  XQSideBarDemo
//
//  Created by HySoft on 13-7-11.
//  Copyright (c) 2013年 HySoft. All rights reserved.
//

#import "XQLeftSideBarViewController.h"
#import "XQSideBarSelectedDelegate.h"
#import "XQFirstViewController.h"

@interface XQLeftSideBarViewController ()

@end

@implementation XQLeftSideBarViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView
{
    [super loadView];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 230, 44)];
    NSMutableArray *array = [NSMutableArray array];
    UIBarButtonItem *barItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [array addObject:barItem1];
    
    UIBarButtonItem *barItem2 = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStylePlain target:self action:nil];
    [array addObject:barItem2];
    
    UIBarButtonItem *barItem3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [array addObject:barItem3];
    
    toolBar.items = array;
    [self.view addSubview:toolBar];
    [toolBar release];
    [barItem1 release];
    [barItem2 release];
    [barItem3 release];
    
    
    _dataList = [[NSMutableArray alloc] initWithObjects:@"1",@"2", nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 230, 460) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    if([self.delegate respondsToSelector:@selector(leftSideBarSelectWithController:)])
    {
        [self.delegate leftSideBarSelectWithController:[self subConWithIndex:0]];
        _selectIndex = 0;
    }
}

#pragma mark UITableViewDatasource and UItableViewDelegate methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.textLabel.text = [_dataList objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(leftSideBarSelectWithController:)])
    {
        if(indexPath.row == _selectIndex)
        {
            [self.delegate leftSideBarSelectWithController:nil];
        }
        else
        {
            [self.delegate leftSideBarSelectWithController:[self subConWithIndex:indexPath.row]];
        }
    }
    _selectIndex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UINavigationController*)subConWithIndex:(int)index
{
    NSLog(@"leftSideBar select!");
    XQFirstViewController *controller = [[XQFirstViewController alloc] init];
    controller.index = index+1;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    nav.navigationBar.hidden = YES;
  //  [controller leftBarButtonClicked];
    return nav;
}

@end
