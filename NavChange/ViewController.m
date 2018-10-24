//
//  ViewController.m
//  NavChange
//
//  Created by Cary on 2018/6/26.
//  Copyright © 2018年 Cary. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate> {
    
    CGFloat alpha;
}

@property(nonatomic,strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.title = @"导航栏渐变";
    self.view.backgroundColor = [UIColor whiteColor];

    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.barTintColor = [UIColor greenColor];

    //1.导航栏静态设置为透明（不可改变）故此方法不适合渐变
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    //2.设置导航栏ImageView的子视图的透明度，此方法可以在scrollView代理方法中改变alpha 可动态改变！
    //因ios11导航栏的层级结构有所变化，故作出判断。
    
    
    if (alpha > 0) {
        
        self.navigationItem.title = @"导航栏渐变";
        
        if (@available(iOS 11.0, *)) {
            [[[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews] objectAtIndex:1].alpha = alpha;
            [[[[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews] objectAtIndex:0] setHidden:YES];
        } else {
            
            self.navigationController.navigationBar.subviews.firstObject.alpha = alpha;
        }
        
    } else {
        
        self.navigationItem.title = @"";
        
        if (@available(iOS 11.0, *)) {
            [[[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews] objectAtIndex:1].alpha = 0;
            
            [[[[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews] objectAtIndex:0] setHidden:YES];
        }else {
            
            self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
        }
        
    }

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    //    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.shadowImage = nil;
    if (@available(iOS 11.0, *)) {
        [[[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews] objectAtIndex:1].alpha = 1;
        [[[[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews] objectAtIndex:0] setHidden:NO];
    } else {
        
        self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString * const cellId = @"myCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"测试";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *vc = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat minAlphaOffset = -64;
    CGFloat maxAlphaOffset = 100;
    CGFloat offset = scrollView.contentOffset.y;
    alpha = (offset - minAlphaOffset)/(maxAlphaOffset-minAlphaOffset);
    
    if (@available(iOS 11.0, *)) {
        [[[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews] objectAtIndex:1].alpha = alpha;
        [[[[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews] objectAtIndex:0] setHidden:YES];
    } else {
        
        self.navigationController.navigationBar.subviews.firstObject.alpha = alpha;
    }
    
    if (alpha > 0) {
        
       self.navigationItem.title = @"导航栏渐变";
        
    } else {
        
       self.navigationItem.title = @"";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
