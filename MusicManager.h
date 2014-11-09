//
//  MusicPlayer.h
//  SwordfishGame
//
//  Created by admin on 11/9/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface MusicManager : NSObject

-(void)playAudio:(NSString*)song withExtencion:(NSString*)extencion andDelegate:(UIResponder*)delegate;
@end
