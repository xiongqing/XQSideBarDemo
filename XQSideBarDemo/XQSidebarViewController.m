//
//  XQSidebarViewController.m
//  XQSideBarDemo
//
//  Created by HySoft on 13-7-11.
//  Copyright (c) 2013年 HySoft. All rights reserved.
//

#import "XQSidebarViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "XQLeftSideBarViewController.h"


@interface XQSidebarViewController ()
{
    UIViewController *_currentMainController;
    UITapGestureRecognizer *_tapGestureRecognizer;
    UIPanGestureRecognizer *_panGestureRecogizer;
    UISwipeGestureRecognizer *_swipGestureRecognizer;
    BOOL sideBarShowing;
    CGFloat currentTranslate;
}

@property (nonatomic,retain) XQLeftSideBarViewController *leftSideBarViewController;

@end

@implementation XQSidebarViewController
@synthesize leftSideBarViewController;

static XQSidebarViewController *rootViewCon;
const int ContentOffset = 230;
const int ContentMinOffset = 60;
const float MoveAnimationDuration = 0.3;

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

+(id)share
{
    return rootViewCon;
}

-(void)loadView
{
    [super loadView];
    if(rootViewCon)
    {
        rootViewCon = nil;
    }
    rootViewCon = self;
    
    sideBarShowing = NO;
    currentTranslate = 0;
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [self.view addSubview:contentView];
    [contentView release];
    
    navBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [self.view addSubview:navBackView];
    [navBackView release];
    
    contentView.layer.shadowOffset = CGSizeMake(0, 0);
    contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    contentView.layer.shadowOpacity = 1;
    
    XQLeftSideBarViewController *leftController = [[XQLeftSideBarViewController alloc] init];
    leftController.delegate = self;
    self.leftSideBarViewController = leftController;
    [leftController release];
    
    [self addChildViewController:self.leftSideBarViewController];
    self.leftSideBarViewController.view.frame = navBackView.bounds;
    [navBackView addSubview:self.leftSideBarViewController.view];
    
//    _panGestureRecogizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panInContentView:)];
//    [contentView addGestureRecognizer:_panGestureRecogizer];
//    [_panGestureRecogizer release];
    
    _swipGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handSwipFrom:)];
    [_swipGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [contentView addGestureRecognizer:_swipGestureRecognizer];
    [_swipGestureRecognizer release];
    
    _swipGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handSwipFrom:)];
    [_swipGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [contentView addGestureRecognizer:_swipGestureRecognizer];
    [_swipGestureRecognizer release];
}

-(void)handSwipFrom:(UISwipeGestureRecognizer *)swipGesture
{
    if(swipGesture.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        NSLog(@"向左");
        [self showSideBarControllerWithDirection:SideBarShowDirectionNone];
    }
    if(swipGesture.direction == UISwipeGestureRecognizerDirectionRight)
    {
        NSLog(@"向右");
        [self showSideBarControllerWithDirection:SideBarShowDirectionLeft];
    }
}

-(void)contentViewAddTapGestures
{
    if(_tapGestureRecognizer)
    {
        [contentView removeGestureRecognizer:_tapGestureRecognizer];
        _tapGestureRecognizer = nil;
    }
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnContentView:)];
    [contentView addGestureRecognizer:_tapGestureRecognizer];
}

-(void)tapOnContentView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
}

-(void)panInContentView:(UIPanGestureRecognizer *)panGestureReconginzer
{
//    if(panGestureReconginzer.state == UIGestureRecognizerStateChanged)
//    {
//        CGFloat translation = [panGestureReconginzer translationInView:contentView].x;
////        CGFloat x = translation+currentTranslate;
////        if(x >ContentMinOffset)
////        {
////            contentView.transform = CGAffineTransformMakeTranslation(230, 0);
////        }
////        else
////        {
////            contentView.transform = CGAffineTransformMakeTranslation(0, 0);
////        }
//        contentView.transform = CGAffineTransformMakeTranslation(translation+currentTranslate, 0);
//        UIView *view1;
//        view1 = self.leftSideBarViewController.view;
//        [navBackView bringSubviewToFront:view1];
//    }
//    else if(panGestureReconginzer.state == UIGestureRecognizerStateEnded)
//    {
//        currentTranslate = contentView.transform.tx;
//        if(!sideBarShowing)
//        {
//            if(fabs(currentTranslate)<ContentMinOffset)
//            {
//                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
//            }
//            if(currentTranslate>ContentMinOffset)
//            {
//                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
//            }
//        }
//    }
//    else
//    {
//        if(fabs(currentTranslate)<ContentOffset-ContentMinOffset)
//        {
//            [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
//        }
//        if(currentTranslate>ContentOffset-ContentMinOffset)
//        {
//            [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
//        }
//    }
    
    if (panGestureReconginzer.state == UIGestureRecognizerStateChanged)
    {
        CGFloat translation = [panGestureReconginzer translationInView:contentView].x;
        contentView.transform = CGAffineTransformMakeTranslation(translation+currentTranslate, 0);
        UIView *view ;
        view = self.leftSideBarViewController.view;
        [navBackView bringSubviewToFront:view];
        
	}
    else if (panGestureReconginzer.state == UIGestureRecognizerStateEnded)
    {
		currentTranslate = contentView.transform.tx;
        if (!sideBarShowing) {
            if (currentTranslate<ContentMinOffset)
            {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
            }
             else 
            {
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
            }
        }
        else
        {
            if (currentTranslate<ContentOffset-ContentMinOffset)
            {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
                
            }
            else
            {
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
            }
        }
	}

 }

#pragma mark UINavigationViewControllerDelegate methods
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([navigationController.viewControllers count]>1)
    {
        [self removepanGestureReconginzerWhileNavConPushed:YES];
    }
    else
    {
        [self removepanGestureReconginzerWhileNavConPushed:NO];
    }
}

-(void)removepanGestureReconginzerWhileNavConPushed:(BOOL)push
{
//    if(push)
//    {
//        if(_panGestureRecogizer)
//        {
//            [contentView removeGestureRecognizer:_panGestureRecogizer];
//            _panGestureRecogizer = nil;
//        }
//    }
//    else
//    {
//        if(!_panGestureRecogizer)
//        {
//            _panGestureRecogizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panInContentView:)];
//            [contentView addGestureRecognizer:_panGestureRecogizer];
//        }
//    }
    
    if(push)
    {
        if(_swipGestureRecognizer)
        {
            [contentView removeGestureRecognizer:_swipGestureRecognizer];
            _swipGestureRecognizer = nil;
        }
    }
    else
    {
        if(!_swipGestureRecognizer)
        {
            _swipGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handSwipFrom:)];
            [_swipGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
            [contentView addGestureRecognizer:_swipGestureRecognizer];
            [_swipGestureRecognizer release];
            
            _swipGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handSwipFrom:)];
            [_swipGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
            [contentView addGestureRecognizer:_swipGestureRecognizer];
            [_swipGestureRecognizer release];
        }
    }
}

#pragma mark XQSideBarSelectedDelegate methods
-(void)leftSideBarSelectWithController:(UIViewController *)controller
{NSLog(@"代理执行！");
    if([controller isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController*)controller setDelegate:self];
    }
    if(_currentMainController == nil)
    {
        controller.view.frame = contentView.bounds;
        _currentMainController = controller;
        [self addChildViewController:_currentMainController];
        [contentView addSubview:_currentMainController.view];
        [_currentMainController didMoveToParentViewController:self];
    }
    else if(_currentMainController != controller && controller != nil)
    {
        controller.view.frame = contentView.bounds;
        [_currentMainController willMoveToParentViewController:nil];
        [self addChildViewController:controller];
        self.view.userInteractionEnabled = NO;
        [self transitionFromViewController:_currentMainController
                          toViewController:controller
                                  duration:0
                                   options:UIViewAnimationOptionTransitionNone
                                animations:^{}
                                completion:^(BOOL finished){
                                    self.view.userInteractionEnabled = YES;
                                    [_currentMainController removeFromParentViewController];
                                    [controller didMoveToParentViewController:self];
                                    _currentMainController = controller;
                                }
         ];
    }

    [self showSideBarControllerWithDirection:SideBarShowDirectionNone];
}

-(void)showSideBarControllerWithDirection:(SideBarShowDirection)direction
{
    if(direction != SideBarShowDirectionNone)
    {
        if(direction == SideBarShowDirectionLeft)
        {
            UIView *view1;
            view1 = self.leftSideBarViewController.view;
            [navBackView bringSubviewToFront:view1];
        }
    }
    [self moveAnimationWithDirection:direction duration:MoveAnimationDuration];
}

-(void)moveAnimationWithDirection:(SideBarShowDirection)direction duration:(float)duration
{
    void (^animations)(void) = ^{
		switch (direction) {
            case SideBarShowDirectionNone:
            {
                contentView.transform  = CGAffineTransformMakeTranslation(0, 0);
                [self.view bringSubviewToFront:contentView];
            }
                break;
            case SideBarShowDirectionLeft:
            {
                contentView.transform  = CGAffineTransformMakeTranslation(ContentOffset, 0);
            }
                break;
            default:
                break;
        }
	};
    void (^complete)(BOOL) = ^(BOOL finished) {
        contentView.userInteractionEnabled = YES;
        navBackView.userInteractionEnabled = YES;
        
        if (direction == SideBarShowDirectionNone) {
            
            if (_tapGestureRecognizer) {
                [contentView removeGestureRecognizer:_tapGestureRecognizer];
                _tapGestureRecognizer = nil;
            }
            sideBarShowing = NO;
        }
        else
        {
            [self contentViewAddTapGestures];
            sideBarShowing = YES;
        }
        currentTranslate = contentView.transform.tx;
	};
    contentView.userInteractionEnabled = NO;
    navBackView.userInteractionEnabled = NO;
    [UIView animateWithDuration:duration animations:animations completion:complete];
}

@end
