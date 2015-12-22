//
//  ViewController.m
//  TestScrollView
//
//  Created by huangxinling on 15/12/22.
//  Copyright © 2015年 huangxinling. All rights reserved.
//

#import "ViewController.h"
#define COUNT 6
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface ViewController (){
    
    UIScrollView *mainView;//放置buttom
    
    UIPageControl *pageControl;//控制当前页数
    
    UIScrollView *mainView2;//显示内容
    
    NSMutableArray *array;//buttom数组
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    array = [[NSMutableArray alloc] init];
    
    mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 50, ScreenWidth, ScreenHeight)];
    mainView.directionalLockEnabled = YES;
    mainView.pagingEnabled = YES;
    mainView.tag =1000;
    mainView.showsVerticalScrollIndicator = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.delegate = self;
    mainView.backgroundColor = [UIColor whiteColor];
    CGSize newSize = CGSizeMake(ScreenWidth * COUNT,  ScreenHeight);
    [mainView setContentSize:newSize];
    [self.view addSubview:mainView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0, 401, ScreenWidth, 80)];
    pageControl.hidesForSinglePage = YES;
    pageControl.userInteractionEnabled = NO;
    //    pageControl.backgroundColor = [UIColor redColor];
    [self.view addSubview:pageControl];
    
    
    for(int i=0;i<COUNT;i++){
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, 200)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 60)];
        label.text = [NSString stringWithFormat:@"当前页数：%d",(i+1)];
        [view addSubview:label];
        [mainView addSubview:view];
    }
    
    
    [mainView scrollRectToVisible:CGRectMake(ScreenWidth*0, (ScreenHeight-250)/2,  ScreenWidth, 200) animated:NO];//初始化
    
    
    
    mainView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 20, ScreenWidth, 30)];
    //    mainView2.directionalLockEnabled = YES;
    //    mainView2.pagingEnabled = YES;
    mainView2.backgroundColor = [UIColor whiteColor];
    //    mainView2.showsVerticalScrollIndicator = NO;
    //    mainView2.showsHorizontalScrollIndicator = NO;
    mainView2.delegate = self;
    mainView2.tag = 2000;
    [mainView2 setShowsHorizontalScrollIndicator:NO];
    CGSize newSize2 = CGSizeMake(100 * COUNT,  30);
    [mainView2 setContentSize:newSize2];
    [self.view addSubview:mainView2];
    
    
    for(int i=0;i<COUNT;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0+i*100, 0, 100, 30);
        [btn setTitle:[NSString stringWithFormat:@"test%d",(i+1)] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if(i==0){
            btn.backgroundColor = [UIColor redColor];
        }else{
            btn.backgroundColor = [UIColor whiteColor];
        }
        
        [mainView2 addSubview:btn];
    }
    
}
#pragma mark - **************** 点击的方法
-(void)buttonAction:(id)sender{
    
    if([sender isKindOfClass:[UIButton class]]){
        UIButton *button = (UIButton *)sender;
        [self changeBtnBackGround:button.tag:ScreenWidth];
    }
}

-(void)changeBtnBackGround:(int) index:(int)width{
    
//     NSLog(@"====index==%d",index);
    for(int i=0;i<COUNT;i++){
        UIButton *btn = (UIButton *)[mainView2 viewWithTag:i];
//        NSLog(@"====btn==%@",btn);
        if(i==index){

            btn.backgroundColor = [UIColor redColor];
        }else{
            
            btn.backgroundColor = [UIColor whiteColor];
        }
        
    }
    if(width==100){
    [mainView2 scrollRectToVisible:CGRectMake(width*index,0,ScreenWidth,30) animated:YES];//滚动的位置
    }else{
    [mainView scrollRectToVisible:CGRectMake(width*index,0,ScreenWidth,30) animated:YES];//滚动的位置
    }
    
    
}

#pragma mark -
#pragma mark UIScrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    
    if(scrollView.tag == 1000){
        int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
        NSLog(@"====100*(index+1)====%d",100*(index+1));
        [self changeBtnBackGround:index:100];
        pageControl.currentPage = index;
        
        NSLog(@"%d",index);
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //       NSLog(@"=====scrollView.frame.size.width=====%f",scrollView.frame.size.width);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
