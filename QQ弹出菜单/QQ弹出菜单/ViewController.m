//
//  ViewController.m
//  QQ弹出菜单
//
//  Created by 王新伟 on 2018/5/24.
//  Copyright © 2018年 王新伟. All rights reserved.
//

#import "ViewController.h"
#import "MenuView.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
/***/
@property (nonatomic, strong) NSArray * titlesArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlesArray = @[@"创建群聊",@"加好友/群",@"扫一扫",@"面对面快传",@"付款",@"拍摄"];
}

- (IBAction)popMenuView:(id)sender {
    [MenuView showMenuViewWithTitleArray:self.titlesArray imagesArray:nil frame:CGRectMake((kScreenW - 170), 80,150, 250) style:MenuViewStyleBlack arrowDirection:ArrowDirectionTopRight callBack:^(NSInteger index) {
        
    }];
}

@end
