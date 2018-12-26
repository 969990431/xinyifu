//
//  NavViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBar];
}
- (void)setNaviBar {
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.tintColor = UIColorFromRGB(119,119,119);
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:18]};
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
