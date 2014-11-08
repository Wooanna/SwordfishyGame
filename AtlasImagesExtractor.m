//
//  AtlasImagesExtractor.m
//  SwordfishGame
//
//  Created by admin on 11/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "AtlasImagesExtractor.h"

@implementation AtlasImagesExtractor
- (NSMutableArray *)ExtractImagesFromAtlasNamed:(NSString *)atlasName {
    
     SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlasName];
    
    
  NSArray *fishyImageNames = [atlas textureNames];

  NSArray *sortedNames = [fishyImageNames
      sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

  NSMutableArray *textures = [NSMutableArray array];

  for (NSString *filename in sortedNames) {
    SKTexture *texture = [atlas textureNamed:filename];
    [textures addObject:texture];
  }
  return textures;
}
@end
