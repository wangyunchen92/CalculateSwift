//
//  MainViewController.m
//  ZrtTool
//
//  Created by BillyWang on 15/10/14.
//  Copyright © 2015年 zrt. All rights reserved.
//

#import "MainTabViewController.h"
#import "CalculateSwift-Swift.h"






@interface MainTabViewController()<UITabBarControllerDelegate>

@end

@implementation MainTabViewController

#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    [self constructNotLoginViewControllers];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.selectedViewController endAppearanceTransition];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UINavigationController *nav = (UINavigationController *)viewController;
    
    if ([tabBarController.viewControllers containsObject:nav]) {
//        UIViewController *vc = [nav.viewControllers objectAtIndex:0];
//        
//        if ([vc respondsToSelector:@selector(refreshDefaultData)]) {
//            [vc performSelector:@selector(refreshDefaultData)];
//        }
    }
    
    return YES;
}

#pragma mark - 手势密码验证

- (void)createViewControllers
{
//    FamilyViewController *hvc    = [[FamilyViewController alloc] init];
    
    
    MainViewController *mainView = [[MainViewController alloc] init];
    UINavigationController *mNav    = [[UINavigationController alloc] initWithRootViewController:mainView];
    
    UIViewController *phoneView = [[UIViewController alloc] init];
        UINavigationController *pNav    = [[UINavigationController alloc] initWithRootViewController:phoneView];
    
    RelationshipViewController *hvc      = [[RelationshipViewController alloc] init];
//    OCRReadIDCardViewController *fvc = [[OCRReadIDCardViewController alloc] init];
//    UIViewController *evc = [[UIViewController alloc] init];

    UINavigationController *hNav    = [[UINavigationController alloc] initWithRootViewController:hvc];
    
    UIViewController *mvc = [[UIViewController alloc] init];
    UINavigationController *miNav    = [[UINavigationController alloc] initWithRootViewController:mvc];
//    DSNavViewController *eNav    = [[DSNavViewController alloc] initWithRootViewController:evc];
//    DSNavViewController *fNav    = [[DSNavViewController alloc] initWithRootViewController:fvc];
    
    [self setTabBarItem:mNav
                  title:@"计算器"
            selectImage:@"ban"
          unselectImage:@"ban"
                    tag:1];
    
    [self setTabBarItem:pNav
                  title:@"关系"
            selectImage:@"ban"
          unselectImage:@"ban"
                    tag:2];
    
//    [self setTabBarItem:hNav
//                  title:@"万年历"
//            selectImage:@"wanSel"
//          unselectImage:@"wan"
//                    tag:2];
//
//    [self setTabBarItem:miNav
//                  title:@"我的"
//            selectImage:@"woSel"
//          unselectImage:@"wo"
//                    tag:3];
    
//    [self setTabBarItem:mNav
//                  title:@"我的测算"
//            selectImage:@"我的测算选中"
//          unselectImage:@"我的测算未选中"
//                    tag:4];
    
    self.viewControllers = @[mNav,hNav];
}

- (void)constructNotLoginViewControllers
{
    [self createViewControllers];
    
    self.selectedIndex = 0;
//    self.tabBar.backgroundImage = [UIImage imageWithColor:RGB(237, 217, 219)];
    self.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
}

- (void)setTabBarItem:(UINavigationController *) navController
                title:(NSString *)title
          selectImage:(NSString *)selectImage
        unselectImage:(NSString *)unselectImage
                  tag:(NSUInteger)tag
{
    UIImage * normalSelectImage = [IMAGE_NAME(selectImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * normalImage = [IMAGE_NAME(unselectImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navController.tabBarItem.title = title;
    
    NSDictionary *normalDic = [NSDictionary dictionaryWithObjectsAndKeys:
                               UIColorFromRGB(0x333333),
                               NSForegroundColorAttributeName, nil];
    [navController.tabBarItem setTitleTextAttributes:normalDic forState:UIControlStateSelected];
    
    navController.tabBarItem.image = normalImage;
    navController.tabBarItem.selectedImage = normalSelectImage;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

}
@end
