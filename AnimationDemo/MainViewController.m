//
//  MainViewController.m
//  AnimationDemo
//
//  Created by YI on 16/10/4.
//  Copyright © 2016年 Sandro. All rights reserved.
//

#import "MainViewController.h"
#import "OneViewController.h"

#import "PushTransition.h"
#import "PopTransition.h"
@interface MainViewController ()<CAAnimationDelegate,UINavigationControllerDelegate>{
    UIView *view1;
}
@property (strong, nonatomic) PushTransition * pushAnimation;
@property (strong, nonatomic) PopTransition * popAnimation;
@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.hidesBarsOnSwipe = YES;
    view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(0, 90, 30, 20);
    view1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view1];
    /*
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = [NSNumber numberWithFloat:1.0];
    fade.toValue = [NSNumber numberWithFloat:0.0];
    fade.duration = 1.0;
    fade.delegate = self;
    //注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [view1.layer addAnimation:fade forKey:@"opacity"];
     //动画不会真正改变opacity的值，在动画结束后要手动更改
    // view1.layer.opacity = 0;
    */
}

#pragma mark - **************** Navgation delegate
/** 返回转场动画实例*/
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return self.pushAnimation;
    }else if (operation == UINavigationControllerOperationPop){
        //return nil;
        return self.popAnimation;
    }
    return nil;
}

-(PushTransition *)pushAnimation
{
    if (!_pushAnimation) {
        _pushAnimation = [[PushTransition alloc] init];
    }
    return _pushAnimation;
}

-(PopTransition *)popAnimation
{
    if (!_popAnimation) {
        _popAnimation = [[PopTransition alloc] init];
    }
    return _popAnimation;
}

//代理方法
/*
- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"START");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //如果不通过动画事务将隐式动画关闭，会出现动画运行完毕后会从起点突变到终点。
    NSLog(@"STOP");
    if (flag) {
        NSLog(@"finished");
        view1.layer.opacity = 0;
    }
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    view1.layer.position = [[anim valueForKey:@"KPOINT"] CGPointValue];
//    [CATransaction commit];
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint p = [[touches anyObject] locationInView:self.view];

    CALayer *layer = view1.layer;
    self.lay = layer;
    //添加动画
    [self positionLayer:layer position:p];
    [self rotate:layer];
}

-(void)rotate:(CALayer *)layer{
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    basicAnimation.toValue=[NSNumber numberWithFloat:M_PI_2*8];
    basicAnimation.duration=3.0;
    //添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation0"];
    
    CABasicAnimation *basicAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation1.toValue=[NSNumber numberWithFloat:M_PI_2*3];
    basicAnimation1.duration=3.0;
    //添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [layer addAnimation:basicAnimation1 forKey:@"KCBasicAnimation_Rotation"];
}
int i = 0;
-(void)positionLayer:(CALayer *)layer position:(CGPoint)p{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.toValue = [NSValue valueWithCGPoint:p];
    animation.duration = 3;
    animation.delegate = self;
    [animation setValue:[NSValue valueWithCGPoint:p] forKey:@"KPOINT"];
    NSString *nameStr = [NSString stringWithFormat:@"KPOSITION%d",i];
    i++;
    [layer addAnimation:animation forKey:nameStr];
}

- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"START");
    NSString *nameStr = [NSString stringWithFormat:@"KPOSITION%d",i];
    [self.lay animationForKey:nameStr];
    [self.lay animationForKey:@"KCBasicAnimation_Rotation0"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.lay.position = [[anim valueForKey:@"KPOINT"] CGPointValue];
    [CATransaction commit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)nextAc:(id)sender {
    OneViewController *oneVc = [[OneViewController alloc] init];
    [self.navigationController pushViewController:oneVc animated:YES];
}
@end
