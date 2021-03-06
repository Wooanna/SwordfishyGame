//
//  BubbleMaker.m
//  SwordfishGame
//
//  Created by admin on 11/6/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "BubbleMaker.h"
#import <SpriteKit/SpriteKit.h>

@implementation BubbleMaker{
    
    SKSpriteNode *_bubble;
    NSArray* _numbers;
    NSArray* _scales;
}

-(id)initWithParentScene:(SKScene *)scene{
    if(self = [super init]){
     _parentScene = scene;
     
     _numbers = @[@20, @(-20), @(-30), @30, @40, @(-40), @(-50), @(-60), @(60), @(50)];
     _scales = @[@0.05, @0.1, @0.15];

    }
    
    return self;
}

- (void)generateBubbles {
    
    CGFloat scale = [_scales[arc4random_uniform((int)_scales.count)] floatValue];
    int duration = arc4random_uniform(3);
    SKAction *moveBubbleUp = [SKAction moveToY:_parentScene.frame.size.height duration:duration];
    SKAction *moveToSides =  [SKAction
                             repeatActionForever:
                             [SKAction moveByX:[_numbers[arc4random_uniform((int)_numbers.count)] floatValue]
                                             y:0
                                      duration:0.001 * [_numbers[arc4random_uniform((int)_numbers.count)] floatValue]]];
    SKAction *moveGroup = [SKAction group:@[ moveBubbleUp, moveToSides ]];
    _bubble = [SKSpriteNode spriteNodeWithImageNamed:@"bubble.png"];
    _bubble.xScale = scale;
    _bubble.yScale = scale;
    _bubble.position = CGPointMake(arc4random_uniform(_parentScene.frame.size.width), -50);
    _bubble.zPosition = 50;
    [_bubble runAction:moveGroup];    
    [_parentScene addChild:_bubble];
}
@end
