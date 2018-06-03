//
//  MenuView.h
//  评价网络请求封装
//
//  Created by 王新伟 on 2018/5/21.
//  Copyright © 2018年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuCell;
/**箭头位置*/
typedef NS_ENUM(NSUInteger,ArrowDirection){
    ArrowDirectionTopLeft,            /**上居左*/
    ArrowDirectionTopCenter,          /**上居中*/
    ArrowDirectionTopRight,           /**上居右*/
    ArrowDirectionLeftTop,            /**左居上*/
    ArrowDirectionLeftCenter,         /**左居中*/
    ArrowDirectionLeftBottom,         /**左居下*/
    ArrowDirectionBottomLeft,         /**下居左*/
    ArrowDirectionBottomCenter,       /**下居中*/
    ArrowDirectionBottomRight,        /**下居右*/
    ArrowDirectionRightTop,           /**右居上*/
    ArrowDirectionRightCenter,        /**右居中*/
    ArrowDirectionRightBottom,        /**右居下*/
};

typedef NS_ENUM(NSInteger ,MenuViewStyle){
    MenuViewStyleBlack,               /**黑色 见微信效果*/
    MenuViewStyleWhite                /**白色 见QQ 效果*/
};

@interface MenuView : UIView

/**
 创建弹框菜单<图片 + 文字 or 文字>

 @param titleArray      标题数组    @[string,....]
 @parm  imagesArray     图片名称数组 @[string,....] 可为nil 代表只创建纯文字内容
 @param frame           确定弹框的大小及位置
 @param style           弹出框风格 <目前支持两种: 黑色 or 白色>
 @param arrowDirection  弹出框箭头方向<提供12中方式,见枚举>
 @param callBack        选中弹框内容回调
 */
+(instancetype )showMenuViewWithTitleArray:(NSArray *)titleArray imagesArray:(NSArray *)imagesArray frame:(CGRect )frame style:(MenuViewStyle )style arrowDirection:(ArrowDirection )arrowDirection callBack:(void(^)(NSInteger index))callBack;

@end

@interface MenuCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setTitle:(NSString *)title;

-(void)setImageName:(NSString *)imageName;

-(void)setComponentsColor:(UIColor *)color;

-(void)setHiddenLine;

@end


