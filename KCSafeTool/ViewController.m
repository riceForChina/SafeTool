//
//  ViewController.m
//  KCSafeTool
//
//  Created by FanQiLe on 2021/9/27.
//

#import "ViewController.h"
#import "DemoVc.h"
#import "NotificationVc.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NotificationVc *tempVc = [[NotificationVc alloc] init];
        [self presentViewController:tempVc animated:true completion:nil];
     });
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"post" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)onClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"log" object:nil userInfo:nil];
}
@end
