//
//  FishMaker.h
//  SwordfishGame
//
//  Created by admin on 11/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FishMaker : NSObject

@property (strong, nonatomic, readonly) SKScene* parentScene;

-initWithParentScene:(SKScene*)scene;
-(void) generateFish;
@end
