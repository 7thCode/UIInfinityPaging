//
//  UIInfScrollView.h
//  UITest2
//
//  Created by oda on 2013/06/20.
//  Copyright (c) 2013年 seventhcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIInfScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, weak) NSArray * views;
@property (nonatomic) BOOL isVirtical;

-(void)setViews:(NSArray *)views;

@end
