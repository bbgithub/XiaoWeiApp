//
//  WlwFormView.m
//  legwork360
//
//  Created by 物恋网 on 16/6/22.
//  Copyright © 2016年 wlw. All rights reserved.
//

#import "WlwFormView.h"
#import "Masonry.h"
@implementation WlwFormView

-(id)init{
    self  = [super init];
    if (self) {
        UIView *topLineView = [[UIView alloc] init];
        topLineView.backgroundColor = DIVIDER_COLOR;
        [self addSubview:topLineView];
        [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@(1/([WlwHelp deviceScale])));
        }];
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = DIVIDER_COLOR;
        [self addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@(1/([WlwHelp deviceScale])));
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
