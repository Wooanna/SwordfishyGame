//
//  NetworkConnectionChecker.m
//  SwordfishGame
//
//  Created by admin on 11/4/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "NetworkConnectionChecker.h"

@implementation NetworkConnectionChecker

-(instancetype)init{
    self = [super init];
    return self;
}
-(BOOL)connection{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
   
}
@end
