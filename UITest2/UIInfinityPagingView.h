//
//  UIInfScrollView.h
//  UITest2
//
//  Created by oda on 2013/06/20.
//  Copyright (c) 2013年 seventhcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIInfinityPagingView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray * views;
@property (nonatomic) BOOL isVirtical;

-(id)init;
-(id)initWithCoder:(NSCoder *)aDecoder;
-(id)initWithFrame:(CGRect)frame;
-(void)setIsVirtical:(BOOL)_isVirtical;
-(void)setViews:(NSArray*)_views;

@end

