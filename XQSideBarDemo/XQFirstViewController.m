//
//  XQFirstViewController.m
//  XQSideBarDemo
//
//  Created by HySoft on 13-7-11.
//  Copyright (c) 2013年 HySoft. All rights reserved.
//

#import "XQFirstViewController.h"
#import "XQSidebarViewController.h"

@interface XQFirstViewController ()

@end

@implementation XQFirstViewController
@synthesize index;

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
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.navigationItem.title = @"导航";
//    
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"左栏" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarButtonClicked)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
//    [leftBarButton release];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    NSMutableArray *array = [NSMutableArray array];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarButtonClicked)];
    [array addObject:item1];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [array addObject:item2];
    
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"导航" style:UIBarButtonItemStylePlain target:self action:nil];
    [array addObject:item3];
    
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [array addObject:item4];
    
    toolBar.items = array;
    [self.view addSubview:toolBar];
    [toolBar release];
    [item1 release];
    [item2 release];
    [item3 release];
    [item4 release];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    _textLabel.backgroundColor = [UIColor clearColor];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.text = [NSString stringWithFormat:@"%d",self.index];
    [self.view addSubview:_textLabel];
    [_textLabel release];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 416) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    _array1 = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6", nil];
    _array2 = [[NSMutableArray alloc] initWithObjects:@"7",@"8",@"9",@"10",@"11",@"12",@"13", nil];
}

-(void)leftBarButtonClicked
{
    if([[XQSidebarViewController share] respondsToSelector:@selector(showSideBarControllerWithDirection:)])
    {
        [[XQSidebarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionLeft];
    }
}

#pragma mark UITableViewDatasource and UITableViewDelegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.index == 1)
    {
        return [_array1 count];
    }
    return [_array2 count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(self.index == 1)
   {
       cell.textLabel.text = [_array1 objectAtIndex:indexPath.row];
   }
   else
   {
       cell.textLabel.text = [_array2 objectAtIndex:indexPath.row];
   }
   return cell;
}

@end
