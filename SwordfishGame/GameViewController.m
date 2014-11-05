//
//  GameViewController.m
//  SwordfishGame
//
//  Created by admin on 11/1/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "GameViewController.h"
#import "MenuScene.h"
#import <Parse/Parse.h>
#import "BestScore.h"

// for downloading players bestScores************************************
@interface GameViewController ()

@property(nonatomic, strong) NSMutableArray *bestScores;

@end
// **********************************************************************

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
  /* Retrieve scene file path from the application bundle */
  NSString *nodePath =
      [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
  /* Unarchive the file to an SKScene object */
  NSData *data = [NSData dataWithContentsOfFile:nodePath
                                        options:NSDataReadingMappedIfSafe
                                          error:nil];
  NSKeyedUnarchiver *arch =
      [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
  [arch setClass:self forClassName:@"SKScene"];
  SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
  [arch finishDecoding];

  return scene;
}

@end

@implementation GameViewController

// for downloading players bestScores**************************************
- (instancetype)init {
  self = [super init];
  if (self) {
    self.bestScores = [NSMutableArray array];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    self.bestScores = [NSMutableArray array];
  }
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {

  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    self.bestScores = [NSMutableArray array];
  }
  return self;
}
// ************************************************************************

- (void)viewDidLoad {
  [super viewDidLoad];

  // Configure the view.
  SKView *skView = (SKView *)self.view;
  skView.showsFPS = YES;
  skView.showsNodeCount = YES;
  /* Sprite Kit applies additional optimizations to improve rendering
   * performance */
  skView.ignoresSiblingOrder = YES;

  // Create and configure the scene.
  MenuScene *scene = [MenuScene unarchiveFromFile:@"GameScene"];
  scene.scaleMode = SKSceneScaleModeAspectFill;

  // Present the scene.
  [skView presentScene:scene];

  // Add object to Parse.com **********************************************
  BestScore *bestScore = [BestScore object];
  [bestScore setPlayerName:@"2"];
  [bestScore setPlayerResult:@2];

  [bestScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
      if (succeeded) {
        NSLog(@"Result saved");
      } else {
        NSLog(@"%@", error);
      }
  }];

  //  PFObject *gameScore = [PFObject objectWithClassName:@"GameScore"];
  //  gameScore[@"user"] = @"Yoanna";
  //  gameScore[@"result"] = @99;
  //  [gameScore saveInBackground];
  // **********************************************************************

  // for downloading players bestScores************************************
  PFQuery *query = [PFQuery queryWithClassName:[bestScore parseClassName]];
  [query orderByDescending:@"playerScore"];
  query.limit = 10;
  //  __weak id weakSelf = self;
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
      if (!error) {
        NSLog(@"%@", objects);
        //          [weakSelf setPeople:[NSMutableArray
        //          arrayWithArray:objects]];
        //          [[weakSelf tableViewPeople] reloadData];
      }
  }];
  // **********************************************************************
}

- (BOOL)shouldAutorotate {
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
  if ([[UIDevice currentDevice] userInterfaceIdiom] ==
      UIUserInterfaceIdiomPhone) {
    return UIInterfaceOrientationMaskAllButUpsideDown;
  } else {
    return UIInterfaceOrientationMaskAll;
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

@end
