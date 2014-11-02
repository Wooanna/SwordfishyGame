//
//  AppDelegate.h
//  SwordfishGame
//
//  Created by admin on 11/1/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,AVAudioPlayerDelegate>{
    AVAudioPlayer *audioPlayer1;
}

@property (strong, nonatomic) UIWindow *window;


@end

