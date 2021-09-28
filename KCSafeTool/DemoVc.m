//
//  DemoVc.m
//  KCSafeTool
//
//  Created by FanQiLe on 2021/9/27.
//

#import "DemoVc.h"
#import "KVOData.h"

@interface DemoVc ()
@property (nonatomic, strong)UIButton *btn;

@property (nonatomic, strong) KVOData *tempData;

@end

@implementation DemoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.btn = [[UIButton alloc]init];
    [self.view addSubview:self.btn];
    [self.btn setTitle:@"disMiss" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    self.btn.frame = CGRectMake(100, 100, 100, 100);
    
    self.tempData = [[KVOData alloc] init];
    self.tempData.num = 1;
    //重复添加会有多次相同回调,重复移除会崩溃
    [self.tempData addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionNew context:nil];
     
    [self.tempData addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionNew context:nil];
    self.tempData.num = 2;
    
    
}

- (void)onClick {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (void)dealloc
{
    NSLog(@"demoVcDealloc");
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"num"]) {
          NSLog(@"%@", change);
    }

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.tempData removeObserver:self forKeyPath:@"num"];
    [self.tempData removeObserver:self forKeyPath:@"num"];
   
}


@end
