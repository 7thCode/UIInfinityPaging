//
//  UIInfScrollView.m
//  UITest2
//
//  Created by oda on 2013/06/20.
//  Copyright (c) 2013年 seventhcode. All rights reserved.
//

#import "UIInfScrollView.h"

#define VIEWS [views count]
#define FIRST_VIEW views[0]
#define LAST_VIEW [views lastObject]

#define SELF_H self.frame.size.height
#define SELF_W self.frame.size.width

#define PREV_VIEW_FRAME(index) [views[index - 1] frame]
#define NEXT_VIEW_FRAME(index) [views[index + 1] frame]

#define V_SIZE (SELF_H * VIEWS)
#define H_SIZE (SELF_W * VIEWS)

#define V_CENTER (SELF_H * (VIEWS / 2))
#define H_CENTER (SELF_W * (VIEWS / 2))
#define V_CENTER_RECT CGRectMake(0.0f, V_CENTER, SELF_W, SELF_H)
#define H_CENTER_RECT CGRectMake(H_CENTER, 0.0f, SELF_W, SELF_H)

#define CENTER (isVirtical? V_CENTER : H_CENTER)
#define CENTER_RECT (isVirtical? V_CENTER_RECT : H_CENTER_RECT)

#define V_CONTENT_SIZE CGSizeMake(SELF_W, V_SIZE)
#define H_CONTENT_SIZE CGSizeMake(H_SIZE, SELF_H)
#define CONTENT_SIZE isVirtical? V_CONTENT_SIZE : H_CONTENT_SIZE

#define VIEW_RECT(index) (isVirtical? CGRectMake(0.0f, index * SELF_H, SELF_W, SELF_H) : CGRectMake(index * SELF_W, 0.0f, SELF_W, SELF_H))

#define DIRECTON(scrollView) (isVirtical? (scrollView.contentOffset.y - V_CENTER : scrollView.contentOffset.x - H_CENTER))
        
@implementation UIInfScrollView

@synthesize views;
@synthesize isVirtical;

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
    
    [self setSubViews:_views];
    
    self.pagingEnabled = NO;
    self.delegate = self;
    self.contentSize = CONTENT_SIZE;
    [self scrollRectToVisible:CENTER_RECT animated:NO];
}

- (void)cycle:(double)offset
{
    double dist = offset - CENTER;
    if (dist > 50.0f) //up
    {
        CGRect lastFrame = [LAST_VIEW frame];
        for (int index = VIEWS - 1 ; index >= 0 ; index--)
        {
            if (index == 0) //Lsst
                [FIRST_VIEW setFrame:lastFrame];
            else
                [views[index] setFrame:PREV_VIEW_FRAME(index)];
        }
    }
    else if (dist < -50.0f) //down
    {
        CGRect firstFrame = [FIRST_VIEW frame];
        for (int index = 0 ; index < VIEWS ; index++)
        {
            if (index == VIEWS - 1) //Last
                [LAST_VIEW setFrame:firstFrame];
            else
                [views[index] setFrame:NEXT_VIEW_FRAME(index)];
        }
    }
}

// called on finger up as we are moving
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{

}

// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^ {
        [self setScrollEnabled:NO];
        [self cycle: isVirtical? scrollView.contentOffset.y: scrollView.contentOffset.x];
        [scrollView scrollRectToVisible:CENTER_RECT animated:NO];
        [self setScrollEnabled:YES];
    });    
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^ {
        [self setScrollEnabled:NO];
        [self cycle: isVirtical? scrollView.contentOffset.y: scrollView.contentOffset.x];
        [scrollView scrollRectToVisible:CENTER_RECT animated:NO];
        [self setScrollEnabled:YES];
    });
}

// any offset changes
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}

// any zoom scale changes
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
}

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

// called on finger up if the user dragged. velocity is in points/second. targetContentOffset may be changed to adjust where the scroll view comes to rest. not called when pagingEnabled is YES
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}

// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

// return a view that will be scaled. if delegate returns nil, nothing happens
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//
//}

// called before the scroll view begins zooming its content
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    
}

// scale between minimum and maximum. called after any 'bounce' animations
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    
}

// return a yes if you want to scroll to the top. if not defined, assumes YES
//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
//{
//
//}

// called when scrolling animation finished. may be called immediately if already at top
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    
}

@end
