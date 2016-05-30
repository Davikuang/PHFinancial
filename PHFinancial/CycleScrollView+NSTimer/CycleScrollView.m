//
//  CycleScrollView.m
//  PagedScrollView
//
//  Created by 陈政 on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"

@interface CycleScrollView () <UIScrollViewDelegate>
@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *page;

@property (nonatomic,strong) NSThread *myThread;
@property (nonatomic , assign) NSTimeInterval animationDuration;

@end

@implementation CycleScrollView

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalPageCount = totalPagesCount();
    if (_totalPageCount > 0) {
        [self configContentViews];
        _page.numberOfPages = _totalPageCount;
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    self.open = YES;
   _myThread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(newThread)
                                                   object:nil];
    [_myThread start]; //启动线程
    return self;
}

- (void)newThread
{
    // 创建线程池
    @autoreleasepool
    {
        [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(animationTimerDidFired:) userInfo:nil repeats:YES];
             [[NSRunLoop currentRunLoop] run];
    }
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.bounces = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;

        self.scrollView.alwaysBounceVertical = YES;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);

        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        //  UIPageControl
        _page = [[UIPageControl alloc] initWithFrame:CGRectMake(self.width - 2*self.width / 3,self.height - 30,self.width/3, 30)];
        _page.tag = 1001;
        [self addSubview:_page];
        _page.currentPageIndicatorTintColor = [UIColor colorWithHexString:kNumberColor];
    }
    
    return self;
}


#pragma mark - 私有函数

- (void)configContentViews
{
    
    if (_open == NO) {
        [_animationTimer pauseTimer];
        [_animationTimer invalidate];
        _animationTimer = nil;
        self.scrollView = nil;
    }
    
    // 移除所有子视图重新添加
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    // 添加子视图，同时给子视图添加手势
    NSInteger counter = 0;
    for (UIImageView *contentView in self.contentViews) {
        
        contentView.userInteractionEnabled = NO;
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
        
    }
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        
        [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
        
        [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        
        [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
        
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    
    if(currentPageIndex == -1) {
        
        return self.totalPageCount - 1;
        
    } else if (currentPageIndex == self.totalPageCount) {
        
        return 0;
        
    } else {
        return currentPageIndex;
    }
    
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 拖动时禁止定时器
    [self.animationTimer pauseTimer];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 拖动结束开启定时器
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        [self configContentViews];
    }
    // 控制UIpageControll
    UIPageControl *page = (UIPageControl *)[self viewWithTag:1001];
    page.currentPage = self.currentPageIndex;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
   
}

#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    if (newOffset.x != 2*kScreenWidth) {
        newOffset.x = 2*kScreenWidth;
    }
    
    // 防止没网的时候没数据 出现闪退
    if (_page.numberOfPages == 0) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.scrollView setContentOffset:newOffset animated:YES];
    });
    
}
// 手势事件
- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    __weak CycleScrollView *this = self;
    if (this.TapActionBlock) {
        this.TapActionBlock(this.currentPageIndex);
    }
}

- (void)dealloc{
    
    [_animationTimer pauseTimer];
    [_animationTimer invalidate];
    _animationTimer = nil;
    
}
#pragma mark 滑动开关
- (void)layoutSubviews {
    if (_totalPageCount <= 2) {
        self.userInteractionEnabled = NO;
    }else {
        self.userInteractionEnabled = YES;
    }
}

@end
