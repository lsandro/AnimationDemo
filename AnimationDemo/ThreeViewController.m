//
//  ThreeViewController.m
//  AnimationDemo
//
//  Created by YI on 16/10/4.
//  Copyright © 2016年 Sandro. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController (){
    UIView *view1;
}

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.hidesBarsOnSwipe = YES;
    view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(0, 90, 30, 20);
    view1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view1];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint p = [[touches anyObject] locationInView:self.view];
    CALayer *layer = view1.layer;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    CAKeyframeAnimation *key = [self createKeyFramed:layer];
    CABasicAnimation *rotate = [self createRotate:layer];
    group.animations = @[key,rotate];
    [layer addAnimation:group forKey:@"GROUP"];
    
    layer.position = CGPointMake(layer.position.x, layer.position.y+200);
}


-(CAKeyframeAnimation *)createKeyFramed:(CALayer *)layer{
    CGFloat x = layer.position.x;
    CGFloat y = layer.position.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, x, y);
    CGPathAddCurveToPoint(path, nil, x+200, y, x+200, y+100, x, y+100);
    CGPathAddCurveToPoint(path, nil, x+200, y+100, x+200, y+200, x, y+200);
    
    CAKeyframeAnimation *keyFramedAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFramedAnimation.path = path;
    keyFramedAnimation.duration = 5;
    [layer addAnimation:keyFramedAnimation forKey:@"KEYFRAME"];
    return keyFramedAnimation;
}

-(CABasicAnimation *)createRotate:(CALayer *)layer{
    CABasicAnimation *rotate=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.toValue =[NSNumber numberWithFloat:M_PI_2*3];
    rotate.duration =5.0;
    [layer addAnimation:rotate forKey:@"KCBasicAnimation_Rotation"];
    return rotate;
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

@end
