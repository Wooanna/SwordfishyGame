//
//  NetworkConnectionChecker.h
//  SwordfishGame
//
//  Created by admin on 11/4/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface NetworkConnectionChecker : NSObject
- (BOOL)connection;
@end
