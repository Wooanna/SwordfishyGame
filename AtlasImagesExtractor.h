//
//  AtlasImagesExtractor.h
//  SwordfishGame
//
//  Created by admin on 11/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface AtlasImagesExtractor : NSObject
- (NSMutableArray *)ExtractImagesFromAtlasNamed:(NSString *)atlasName;
@end
