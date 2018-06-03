//
//  MenuView.m
//  评价网络请求封装
//
//  Created by 王新伟 on 2018/5/21.
//  Copyright © 2018年 王新伟. All rights reserved.
//

#import "MenuView.h"
#import <Masonry.h>
#define kRowHeight 40
#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height
#define kWindows  [[UIApplication sharedApplication].delegate window]
#define RGBAColor(r,g,b,a)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
@interface MenuView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy)   void(^callBack)(NSInteger index);
@property (nonatomic, assign) ArrowDirection arrowDirection;
@property (nonatomic, assign) MenuViewStyle style;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) NSArray * titleArray;
@property (nonatomic, strong) NSArray * imagesArray;
@property (nonatomic, strong) UITableView * myTableView;
@property (nonatomic, strong) UIButton * bgButton;
@property (nonatomic, assign) CGFloat maxHeight;

@end

@implementation MenuView

+(instancetype )showMenuViewWithTitleArray:(NSArray *)titleArray imagesArray:(NSArray *)imagesArray frame:(CGRect )frame style:(MenuViewStyle )style arrowDirection:(ArrowDirection)arrowDirection callBack:(void (^)(NSInteger))callBack{
    MenuView * view = [[MenuView alloc]initWithTitleArray:titleArray imagesArray:imagesArray frame:frame style:style arrowDirection:arrowDirection callBack:callBack];
    return view;
}

-(instancetype )initWithTitleArray:(NSArray*)titleArray imagesArray:(NSArray *)imagesArray frame:(CGRect )frame style:(MenuViewStyle )style arrowDirection:(ArrowDirection)arrowDirection callBack:(void (^)(NSInteger))callBack{
    if (self = [super initWithFrame:frame]) {
        self.style          = style;
        self.callBack       = callBack;
        self.titleArray     = titleArray;
        self.imagesArray    = imagesArray;
        self.maxHeight      = frame.size.height;
        self.arrowDirection = arrowDirection;
        [self addSubViews];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGFloat Width  = self.frame.size.width;
    CGFloat Height = self.frame.size.height;
    /**定义箭头等边三角形 宽 下面计算绘图点使用*/
    CGFloat arrowW = 14;
    /**等边三角形 算出高度*/
    CGFloat arrowH = (1.5 * arrowW)/2;
    CGPoint point1;
    CGPoint point2;
    CGPoint point3;
    /**定义需要画箭头的位置*/
    switch (self.arrowDirection) {
        case ArrowDirectionTopLeft:{
            point1 = CGPointMake(arrowW/2, 0);
            point2 = CGPointMake(arrowW, -arrowH);
            point3 = CGPointMake(arrowW * 1.5,0);
        }
            break;
        case ArrowDirectionTopCenter:{
            point1 = CGPointMake((Width/2) - arrowW/2, 0);
            point2 = CGPointMake(Width/2 + arrowW/5, -arrowH);
            point3 = CGPointMake((Width/2) + arrowW ,0);
        }
            break;
        case ArrowDirectionTopRight:{
            point1 = CGPointMake(Width - arrowW/2, 0);
            point2 = CGPointMake(Width - arrowW, -arrowH);
            point3 = CGPointMake(Width - arrowW * 1.5 ,0);
        }
            break;
        case ArrowDirectionRightTop:{
            point1 = CGPointMake(Width, arrowW/2);
            point2 = CGPointMake(Width+arrowH, arrowW);
            point3 = CGPointMake(Width ,arrowW * 1.5);
        }
            break;
        case ArrowDirectionRightCenter:{
            point1 = CGPointMake(Width, Height/2 - arrowW/2);
            point2 = CGPointMake(Width+arrowH, Height/2 + arrowW/5);
            point3 = CGPointMake(Width, Height/2 + arrowW);
        }
            break;
        case ArrowDirectionRightBottom:{
            point1 = CGPointMake(Width, Height - arrowW * 1.5);
            point2 = CGPointMake(Width+arrowH, Height - arrowW);
            point3 = CGPointMake(Width ,Height - arrowW/2);
        }
            break;
        case ArrowDirectionBottomRight:{
            point1 = CGPointMake(Width - arrowW/2, Height);
            point2 = CGPointMake(Width - arrowW, Height + arrowH);
            point3 = CGPointMake(Width - arrowW * 1.5 ,Height);
        }
            break;
        case ArrowDirectionBottomCenter:{
            point1 = CGPointMake((Width/2) - arrowW/2, Height);
            point2 = CGPointMake(Width/2 + arrowW/8, Height + arrowH);
            point3 = CGPointMake((Width/2) + arrowW ,Height);
        }
            break;
        case ArrowDirectionBottomLeft:{
            point1 = CGPointMake(arrowW/2, Height);
            point2 = CGPointMake(arrowW, Height + arrowH);
            point3 = CGPointMake(arrowW * 1.5,Height);
        }
            break;
        case ArrowDirectionLeftBottom:{
            point1 = CGPointMake(0, Height - arrowW * 1.5);
            point2 = CGPointMake(-arrowH, Height - arrowW);
            point3 = CGPointMake(0, Height - arrowW/2);
        }
            break;
        case ArrowDirectionLeftCenter:{
            point1 = CGPointMake(0, Height/2 - arrowW/2);
            point2 = CGPointMake(-arrowH, Height/2 + arrowW/5);
            point3 = CGPointMake(0, Height/2 + arrowW);
        }
            break;
        case ArrowDirectionLeftTop:{
            point1 = CGPointMake(0, arrowW/2);
            point2 = CGPointMake(-arrowH, arrowW);
            point3 = CGPointMake(0 ,arrowW * 1.5);
        }
            break;
        default:
            break;
    }
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:self.bounds];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path closePath];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = (self.style == MenuViewStyleBlack) ? RGBAColor(33, 33, 33,1).CGColor : RGBAColor(255, 255, 255,1).CGColor;
    layer.fillColor = layer.strokeColor;
    [self.layer addSublayer:layer];
    [self showMenuView];
}

-(void)addSubViews{
    [kWindows addSubview:self.bgButton];
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 0;
    [kWindows addSubview:self];
    [self.myTableView reloadData];
}

-(UIButton *)bgButton{
    if (_bgButton == nil) {
        _bgButton = [[UIButton alloc]init];
        [_bgButton addTarget:self action:@selector(hideMenuView) forControlEvents:UIControlEventTouchUpInside];
        _bgButton.backgroundColor = [UIColor clearColor];
        _bgButton.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
    return _bgButton;
}

-(UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.showsVerticalScrollIndicator = false;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight = kRowHeight;
        _myTableView.alpha = 0;
        CGRect Frame = self.frame;
        Frame.size.height = self.titleArray.count * kRowHeight >= self.maxHeight ? self.maxHeight : self.titleArray.count * kRowHeight;
        _myTableView.frame = Frame;
        self.frame = Frame;
        _myTableView.scrollEnabled = self.titleArray.count * kRowHeight >= self.maxHeight;
        [kWindows addSubview:_myTableView];
    }
    return _myTableView;
}

-(void)showMenuView{
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 1;
        self.myTableView.alpha = 1;
    } completion:^(BOOL finished) {
       
    }];
}

-(void)hideMenuView{
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 0;
        self.myTableView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.bgButton removeFromSuperview];
        [self.myTableView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell * cell = [MenuCell cellWithTableView:tableView];
    [cell setTitle:self.titleArray[indexPath.row]];
    BOOL isShowAssert = self.imagesArray!= nil && self.imagesArray.count != self.titleArray.count;
    /**断言 第一个参数是条件 为false执行,并打印具体信息*/
    /**这里处 针对 文字+图片 但是图片数量与文字数量不符的情况*/
    NSCAssert(!isShowAssert, @"图片与文字数量不匹配,请检查!");
    if (self.imagesArray!= nil && self.imagesArray.count == self.titleArray.count) {
        /**处理 图片与文字数量匹配的情况*/
        [cell setImageName:self.imagesArray[indexPath.row]];
    }
    if(indexPath.row == self.titleArray.count - 1) [cell setHiddenLine];
    [cell setComponentsColor:(self.style != MenuViewStyleBlack) ? RGBAColor(223, 223, 223,1) : RGBAColor(255, 255, 255,1)];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self hideMenuView];
    self.callBack(indexPath.row);
}

@end

@interface MenuCell()
@property (nonatomic, strong) UILabel * titleLbel;
@property (nonatomic, strong) UIView  * lineView;
@property (nonatomic, strong) UIImageView * leftImageView;
@end

@implementation MenuCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    MenuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"kCellIdentifier"];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadWithComponents];
    }
    return cell;
}

-(void)loadWithComponents{
    self.backgroundColor = [UIColor clearColor];
    [self addLineView];
    [self addLeftImageView];
    [self addTitleLbel];
}

-(void)addTitleLbel{
    if (!_titleLbel) {
        _titleLbel = [[UILabel alloc]init];
        _titleLbel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLbel];
        [_titleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
        }];
    }
}

-(void)addLeftImageView{
    if(!_leftImageView){
        _leftImageView = [[UIImageView alloc]init];
        _leftImageView.hidden = YES;
        [self.contentView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(24, 24));
        }];
    }
}

-(void)addLineView{
    if (!_lineView) {
        _lineView = [[UILabel alloc]init];
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.height.mas_equalTo(.5f);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
}

-(void)setTitle:(NSString *)title{
    _titleLbel.text = title;
}

-(void)setImageName:(NSString *)imageName{
    self.leftImageView.hidden = NO;
    self.leftImageView.image = [UIImage imageNamed:imageName];
    [self.titleLbel mas_updateConstraints:^(MASConstraintMaker *make) {
         make.centerX.mas_equalTo(self.contentView).offset(15);
    }];
}

-(void)setComponentsColor:(UIColor *)color{
    if([self isTheSameColor2:color anotherColor:RGBAColor(223, 223, 223,1)]){
        self.titleLbel.textColor = RGBAColor(33, 33, 33,1);
    }else{
          self.titleLbel.textColor = color;
    }
    self.lineView.backgroundColor = color;
}

-(void)setHiddenLine{
    self.lineView.hidden = YES;
}

-(BOOL)isTheSameColor2:(UIColor*)color1 anotherColor:(UIColor*)color2{
    return  CGColorEqualToColor(color1.CGColor, color2.CGColor);
}

@end

