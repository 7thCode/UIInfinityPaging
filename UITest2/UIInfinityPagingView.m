//
//  UIInfScrollView.m
//  UITest2
//
//  Created by oda on 2013/06/20.
//  Copyright (c) 2013年 seventhcode. All rights reserved.
//

#import "UIInfinityPagingView.h"

#define VIEWS [views count]
#define FIRST_VIEW views[0]
#define LAST_VIEW [views lastObject]

#define H_SELF self.frame.size.height
#define W_SELF self.frame.size.width
#define SELF (isVirtical? H_SELF : W_SELF)

#define PREV_VIEW_FRAME(index) [views[index - 1] frame]
#define NEXT_VIEW_FRAME(index) [views[index + 1] frame]

#define H_SIZE      (H_SELF * VIEWS)
#define W_SIZE      (W_SELF * VIEWS)

#define H_CENTER    (H_SIZE / 2)
#define W_CENTER    (W_SIZE / 2)
#define CENTER      (isVirtical? H_CENTER : W_CENTER)

#define H_CENTER_RECT   CGRectMake(0.0f, H_CENTER, W_SELF, H_SELF)
#define W_CENTER_RECT   CGRectMake(W_CENTER, 0.0f, W_SELF, H_SELF)
#define CENTER_RECT     (isVirtical? H_CENTER_RECT : W_CENTER_RECT)

#define H_CONTENT_SIZE  CGSizeMake(W_SELF, H_SIZE)
#define W_CONTENT_SIZE  CGSizeMake(H_SIZE, H_SELF)
#define CONTENT_SIZE    (isVirtical? H_CONTENT_SIZE : W_CONTENT_SIZE)

#define VIEW_RECT(index) (isVirtical? CGRectMake(0.0f, index * H_SELF, W_SELF, H_SELF) : CGRectMake(index * W_SELF, 0.0f, W_SELF, H_SELF))

#define DIRECTON(scrollView) (isVirtical? (scrollView.contentOffset.y - V_CENTER : scrollView.contentOffset.x - H_CENTER))

#define THRESHOLD (SELF / 2.0f)

@implementation UIInfinityPagingView

@synthesize views;
@synthesize isVirtical;

-(id)init
{
    self = [super init];
    if (self)
    {
        isVirtical = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
    {
        isVirtical = NO;
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        isVirtical = NO;
    }
    return self;
}

-(void)setIsVirtical:(BOOL)_isVirtical
{
    isVirtical = _isVirtical;
    [self setViews:views];
}

-(void)clearSubViews
{
    for (UIView * view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

-(void)setSubViews:(NSArray*)_views
{
    [self clearSubViews];
    int index = 0;
    for (UIView * view in _views)
    {
        view.frame = VIEW_RECT(index);
        [self addSubview:view];
        index++;
    }
}

-(void)setViews:(NSArray*)_views
{
    views = _views;
    
    [self setSubViews:views];
    
    self.pagingEnabled = NO;
    super.delegate = self;
    self.contentSize = CONTENT_SIZE;
    [self scrollRectToVisible:CENTER_RECT animated:NO];
}

- (void)onMovement:(double)offset
{
    double movement = offset - CENTER;
    if (movement > THRESHOLD) //up
    {
        CGRect currentLastFrame = [LAST_VIEW frame];
        for (int index = VIEWS - 1 ; index >= 0 ; index--)
        {
            if (index == 0) //Last
                [FIRST_VIEW setFrame:currentLastFrame];
            else
                [views[index] setFrame:PREV_VIEW_FRAME(index)];
        }
    }
    else if (movement < -THRESHOLD) //down
    {
        CGRect currentFirstFrame = [FIRST_VIEW frame];
        for (int index = 0 ; index < VIEWS ; index++)
        {
            if (index == VIEWS - 1) //Last
                [LAST_VIEW setFrame:currentFirstFrame];
            else
                [views[index] setFrame:NEXT_VIEW_FRAME(index)];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^ {
        [scrollView setScrollEnabled:NO];
        [self onMovement: isVirtical? scrollView.contentOffset.y: scrollView.contentOffset.x];
        [scrollView scrollRectToVisible:CENTER_RECT animated:NO];
        [scrollView setScrollEnabled:YES];
    });
}

@end
