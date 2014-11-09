//
//  TALocationProvider.h
//  SwordfishGame
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface TALocationProvider : NSObject

-(void) getLocationWithBlock: (void(^)(CLLocation* location)) block;

-(void) getLocationWithTarget:(id) target
                    andAction:(SEL) action;

@end
