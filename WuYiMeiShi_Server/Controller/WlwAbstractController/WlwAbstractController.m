//
//  WlwAbstractController.m
//  wlw-b2c
//
//  Created by 物恋网 on 16/3/31.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwAbstractController.h"

@implementation WlwAbstractController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = VIEWBACKCOLOR;
    if (IS_OS_7_OR_LATER)
    {
        /*如果view里包含scrollview，不设置此属性，会显示位置不正确。*/
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        /*view里子视图如果不偏移64像素，会被覆盖*/
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
//        CGRect rect = self.view.frame;
//        rect.origin.y += 20;
//        self.view.frame = rect;
    }
    NSDictionary *navTitleArr = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17.0f],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTintColor:NAVBARTITLE];
    self.navigationController.navigationBar.titleTextAttributes = navTitleArr;
    [self setLeftNavgationBtn];
}

-(void)setLeftNavgationBtn{
    UIImage *img = [UIImage imageNamed:@"back"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(OnClickLeft) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    /*这里可以加按钮背景*/
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = backBtn;
}

-(void)setNavgationTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGBACOLOR(0x33, 0x33, 0x33, 1.0);;
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    [label setNeedsLayout];
    [label layoutIfNeeded];
    label.frame = CGRectMake(0, 0, label.frame.size.width, 44);
    self.navigationItem.titleView = label;
}

-(void)OnClickLeft
{
    if(self == self.navigationController.viewControllers[0]){
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)argumentForCanvas:(id)argumentData{
    //用于子类继承该方法接收上一级页面传递的参数
}


-(WlwAbstractController *)pushCanvas:(NSString *) canvasName withArgument:(id)argumentData
{
    if (canvasName == nil) {
        return nil;
    }
    WlwAbstractController *baseVC = nil;
    Class object = NSClassFromString(canvasName);
    baseVC = (WlwAbstractController *)[[object alloc] init];
    if (baseVC) {
        if ([baseVC respondsToSelector:@selector(argumentForCanvas:)]) {
            if (argumentData) {
                [baseVC argumentForCanvas:argumentData];
            }
        }
        baseVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:baseVC animated:YES];
    }
    return baseVC;
}

- (WlwAbstractController *)popCanvasWithArgment:(id)argument
{
    WlwAbstractController *canvasController = nil;
    NSUInteger nViewControllerCount = [self.navigationController.viewControllers count];
    if (nViewControllerCount >= 2)
    {
        WlwAbstractController *canvasController = [self.navigationController.viewControllers objectAtIndex:nViewControllerCount - 2];
        if (canvasController)
        {
            if ([canvasController respondsToSelector:@selector(argumentForCanvas:)])
            {
                if (argument)
                {
                    [canvasController argumentForCanvas:argument];
                }
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    return canvasController;
}

- (WlwAbstractController *)popToCanvas:(NSString *) canvasName withArgument:(id)argumentData
{
    WlwAbstractController *canvasController = nil;
    NSUInteger nViewControllerCount = [self.navigationController.viewControllers count];
    int grade = 0;
    for (int i = 0; i < nViewControllerCount; i++) {
        WlwAbstractController *tempVC = [self.navigationController.viewControllers objectAtIndex:i];
        if ([tempVC isKindOfClass:[canvasName class]]) {
            grade = i;
            break;
        }
    }
    NSInteger desCanvaseIndex = nViewControllerCount-1 - grade;
    if (desCanvaseIndex < 0)
    {
        desCanvaseIndex = 0;
    }
    canvasController = [self.navigationController.viewControllers objectAtIndex:desCanvaseIndex];
    if (canvasController)
    {
        if ([canvasController respondsToSelector:@selector(argumentForCanvas:)])
        {
            if (argumentData)
            {
                [canvasController argumentForCanvas:argumentData];
            }
        }
        [self.navigationController popToViewController:(UIViewController *)canvasController animated:YES];
    }
    return canvasController;
}

- (WlwAbstractController *)popToRootCanvasWithArgment:(id)argumentData
{
    WlwAbstractController *canvasController = nil;
    canvasController = [self.navigationController.viewControllers objectAtIndex:0];
    if (canvasController)
    {
        
        if ([canvasController respondsToSelector:@selector(argumentForCanvas:)])
        {
            if (argumentData)
            {
                [canvasController argumentForCanvas:argumentData];
            }
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    return canvasController;
}

- (WlwAbstractController *)popToRootCanvasWithArgment:(id)argumentData afterSeconds:(int)seconds{
    
    WlwAbstractController *canvasController = nil;
    canvasController = [self.navigationController.viewControllers objectAtIndex:0];
    if (canvasController)
    {
        
        if ([canvasController respondsToSelector:@selector(argumentForCanvas:)])
        {
            if (argumentData)
            {
                [canvasController argumentForCanvas:argumentData];
            }
        }
        sleep(seconds);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    return canvasController;
}

- (WlwAbstractController *)popToCanvasWithGrade:(NSInteger)grade  withArgument:(id)argumentData
{
    NSArray *canvasControllers = [[NSArray alloc] initWithArray:self.navigationController.viewControllers];
    NSInteger currentCanvasIndex = canvasControllers.count - 1;
    NSInteger desCanvaseIndex = currentCanvasIndex - grade;
    if (desCanvaseIndex < 0)
    {
        desCanvaseIndex = 0;
    }
    WlwAbstractController *canvasController = [canvasControllers objectAtIndex:desCanvaseIndex];
    if (canvasController)
    {
        if ([canvasController respondsToSelector:@selector(argumentForCanvas:)])
        {
            if (argumentData)
            {
                [canvasController argumentForCanvas:argumentData];
            }
        }
        [self.navigationController popToViewController:(UIViewController *)canvasController animated:YES];
    }
    return canvasController;
}

@end
