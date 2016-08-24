//
//  UIView+MGBadgeView.h
//  BESTKEEP
//
//  Created by Canny on 16/5/17.
//  Copyright © 2016年 YISHANG. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, MGBadgePosition) {
    MGBadgePositionCenterLeft,
    MGBadgePositionCenterRight,
    MGBadgePositionTopLeft,
    MGBadgePositionTopRight,
    MGBadgePositionBottomLeft,
    MGBadgePositionBottomRight,
    MGBadgePositionBest
};


@interface MGBadgeView : UIView

@property (nonatomic) MGBadgePosition position;

@property (nonatomic) NSInteger badgeValue;

@property(strong, nonatomic) UIFont *font;

@property(strong, nonatomic) UIColor *badgeColor;

@property(strong, nonatomic) UIColor *textColor;

@property(strong, nonatomic) UIColor *outlineColor;

@property (nonatomic) float outlineWidth;

@property (nonatomic) float minDiameter;

@property (nonatomic) BOOL displayIfZero;

@property (nonatomic) float horizontalOffset;

@property (nonatomic) float verticalOffset;

@end


@interface UIView (MGBadgeView)

@property(nonatomic, readonly) MGBadgeView *badgeView;

@end
