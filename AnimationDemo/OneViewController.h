//
//  OneViewController.h
//  AnimationDemo
//
//  Created by YI on 16/10/4.
//  Copyright © 2016年 Sandro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneViewController : UIViewController

@property(nonatomic,strong)CALayer *colorLayer;
@property (weak, nonatomic) IBOutlet UIView *layerView;
- (IBAction)nextAc:(id)sender;

@end
