//
//  AppController.m
//  wuyimeishi
//
//  Created by 物恋网 on 16/7/13.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "AppController.h"
#import "MineViewController.h"
#import "HomeController.h"
#import "CartViewController.h"
@implementation AppController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(0x63, 0x63, 0x63, 1.0),
                                                       
                                                       NSForegroundColorAttributeName,
                                                       
                                                       nil]
     
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(0x63, 0x63, 0x63, 1.0),
                                                       
                                                       NSForegroundColorAttributeName,
                                                       
                                                       nil]
     
                                             forState:UIControlStateSelected];
    self.tabBar.barTintColor = NAVGATIONBARCOLOR;
    self.tabBar.translucent = NO;
    
    HomeController *homeVC = [[HomeController alloc] init];
    homeVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"商城"
                                                     image:[[UIImage imageNamed:@"home_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]
                                             selectedImage:[[UIImage imageNamed:@"home_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
    UINavigationController *navSquare = [[UINavigationController alloc] initWithRootViewController:homeVC];
    navSquare.navigationBar.barTintColor = NAVGATIONBARCOLOR;
   
    CartViewController *cartVC = [[CartViewController alloc] init];
    cartVC.tabBarItem =  [[UITabBarItem alloc]initWithTitle:@"购物车"
                                                      image:[[UIImage imageNamed:@"market_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]
                                              selectedImage:[[UIImage imageNamed:@"market_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
    UINavigationController *navCart = [[UINavigationController alloc] initWithRootViewController:cartVC];
    navCart.navigationBar.barTintColor = NAVGATIONBARCOLOR;
    
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    mineVC.tabBarItem =  [[UITabBarItem alloc]initWithTitle:@"我的"
                                                      image:[[UIImage imageNamed:@"me_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]
                                              selectedImage:[[UIImage imageNamed:@"me_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];    UINavigationController *navMine = [[UINavigationController alloc] initWithRootViewController:mineVC];
    navMine.navigationBar.barTintColor = NAVGATIONBARCOLOR;
    self.viewControllers = @[navSquare,navCart,navMine];
    self.selectedIndex = 0;

}
@end
