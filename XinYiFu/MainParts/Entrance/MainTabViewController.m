//
//  MainTabViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MainTabViewController.h"
#import "CashierViewController.h"
#import "BillViewController.h"
#import "MineViewController.h"
#import "NavViewController.h"
#import "UserPreferenceModel.h"
#import "LoginViewController.h"
#import "NavViewController.h"

@interface MainTabViewController ()
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation MainTabViewController

- (void)viewWillAppear:(BOOL)animated {
    if ([UserPreferenceModel shareManager].guideViewHidden == 0) {
        [UserPreferenceModel shareManager].guideViewHidden = 1;
        [self prepareGuideViews];
    }
}

- (void)prepareGuideViews {
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = 0;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, SCREEN_HEIGHT);
    NSArray *imageNames;
    if (iPhoneX) {
        imageNames = @[@"欢迎页1-x", @"欢迎页2-x"];
    }else {
        imageNames = @[@"欢迎页1", @"欢迎页2"];
    }
    for (int i = 0; i<2; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageNames[i]]];
        imageV.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.scrollView addSubview:imageV];
        if (i == 1) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoMain)];
            imageV.userInteractionEnabled = YES;
            [imageV addGestureRecognizer:tap];
        }
        
    }
    
    [self.view addSubview:self.scrollView];
}
- (void)gotoMain {
    [self.scrollView removeFromSuperview];
    
    if (![UserPreferenceModel shareManager].token) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[NavViewController alloc]initWithRootViewController:loginVC];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setChildVc:[[CashierViewController alloc]init] title:@"收银" image:@"shouyin2" selectImage:@"shouyin1"];
    [self setChildVc:[[BillViewController alloc]init] title:@"账单" image:@"zhangdan2" selectImage:@"zhangdan1"];
    [self setChildVc:[[MineViewController alloc]init] title:@"我的" image:@"geren2" selectImage:@"geren1"];
    
    UITabBar *tab = [[UITabBar alloc]init];
    //    [[UITabBar appearance] setBarTintColor:[UIColor lightGrayColor]];
        [UITabBar appearance].translucent = 0;
    [self setValue:tab forKeyPath:@"tabBar"];
}

- (void)setChildVc: (UIViewController *)vc title: (NSString *)title image: (NSString *)image selectImage: (NSString *)selectImage {
    
    //    vc.tabBarItem.title = title;
    vc.title = title;
//        vc.tabBarItem.image = [self OriginImage:[UIImage imageNamed:image] scaleToSize:CGSizeMake(30, 30)];
//        vc.tabBarItem.selectedImage = [self OriginImage:[UIImage imageNamed:selectImage] scaleToSize:CGSizeMake(30, 30)];
    vc.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:[[NavViewController alloc]initWithRootViewController:vc]];
    
}

//自定义图片大小
- (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}

+ (void)initialize {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = TabGray;
    
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAtts[NSForegroundColorAttributeName] = TabRed;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}

@end
