//
//  TwoViewController.m
//  AnimationDemo
//
//  Created by YI on 16/10/4.
//  Copyright © 2016年 Sandro. All rights reserved.
//

#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface TwoViewController (){
    UIView *view1;
}
@property(nonatomic,assign)BOOL stop;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.delegate = nil;
    _stop = YES;
    self.navigationController.hidesBarsOnSwipe = YES;
    view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(0, 90, 30, 20);
    view1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint p = [[touches anyObject] locationInView:self.view];
    CALayer *layer1 = view1.layer;
    self.layer = layer1;
    //开始动画
    [self keyFramed:layer1];
    //动画结束之后改变layer位置
    layer1.position = CGPointMake(layer1.position.x, layer1.position.y+200);
}

-(void)keyFramed:(CALayer *)layer{
    /*
    CAKeyframeAnimation *keyFramedAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat x = layer.position.x;
    CGFloat y = layer.position.y;
    //添加贝塞尔曲线路径
    CGPathMoveToPoint(path, nil, x, y);
    CGPathAddCurveToPoint(path, nil, x+200, y, x+200, y+100, x, y+100);
    CGPathAddCurveToPoint(path, nil, x+200, y+100, x+200, y+200, x, y+200);
    keyFramedAnimation.path = path;
    keyFramedAnimation.duration = 5;
    keyFramedAnimation.calculationMode = kCAAnimationCubicPaced;
    keyFramedAnimation.keyTimes = @[@0.0,@0.2,@1.0];
    [layer addAnimation:keyFramedAnimation forKey:@"KEYFRAME"];
    */
    
    
    CAKeyframeAnimation *keyFramedAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat x = layer.position.x;
    CGFloat y = layer.position.y;
    CGPathMoveToPoint(path, nil, x, y);
    CGPathAddCurveToPoint(path, nil, x+200, y, x+200, y+100, x, y+100);
    CGPathAddCurveToPoint(path, nil, x+200, y+100, x+200, y+200, x, y+200);
    keyFramedAnimation.path = path;
    keyFramedAnimation.duration = 5;
    keyFramedAnimation.calculationMode = kCAAnimationCubic;
    keyFramedAnimation.keyTimes = @[@0.0,@0.3,@1.0];
    [layer addAnimation:keyFramedAnimation forKey:@"KEYFRAME"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)pauseAnimation:(CALayer *)layer{
    CFTimeInterval pauseTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.timeOffset = pauseTime;
    layer.speed = 0;
}

- (void)resumeAnimation:(CALayer *)layer{
    CFTimeInterval pauseTime = [self.layer timeOffset];
    layer.timeOffset = 0;
    layer.beginTime = 0;
    layer.speed = 1;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    layer.beginTime = timeSincePause;
}

- (IBAction)pause:(id)sender {
    self.stop = !self.stop;
    if (self.stop) {
        [self resumeAnimation:view1.layer];
    }else{
        [self pauseAnimation:view1.layer];
    }
}

- (IBAction)nextAc:(id)sender {
    ThreeViewController *oneVc = [[ThreeViewController alloc] init];
    [self.navigationController pushViewController:oneVc animated:YES];
}
@end
