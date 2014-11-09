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
#import "CoreDataHelper.h"
#import "QuestionWithAnswer.h"
#import "QuestionWithAns.h"

@interface GameViewController ()

// for downloading new questions
@property(nonatomic, strong) NSMutableArray *quests;

// for coredata
@property(nonatomic, strong) CoreDataHelper *cdHelper;

@end

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

// for downloading from Parse.com
- (instancetype)init {
  self = [super init];
  if (self) {
    self.quests = [NSMutableArray array];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    self.quests = [NSMutableArray array];
  }
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    self.quests = [NSMutableArray array];
  }
  return self;
}

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

  PFObject *question = [PFObject objectWithClassName:@"QuestionsWithAns"];

  //  // Add quests to Parse.com
  //  question[@"question"] = @"1 question";
  //  question[@"rightAnswer"] = @2;
  //  question[@"answerOne"] = @"Answer 1";
  //  question[@"answerTwo"] = @"Answer 2";
  //  question[@"answerThree"] = @"Answer 3";
  //  [question saveInBackground];

  // Read questions from CoreData
  _cdHelper = [[CoreDataHelper alloc] init];
  [_cdHelper setupCoreData];

  NSFetchRequest *request =
      [NSFetchRequest fetchRequestWithEntityName:@"QuestionWithAnswer"];

  NSArray *fetchedObjects =
      [_cdHelper.context executeFetchRequest:request error:nil];
  //      for (QuestionWithAnswer *q in fetchedObjects) {
  //        NSLog(@"Question = %@", q.question);
  //        NSLog(@"Answer A = %@", q.answerOne);
  //        NSLog(@"Answer B = %@", q.answerTwo);
  //        NSLog(@"Answer C = %@", q.answerThree);
  //        NSLog(@"Right answer = %@", q.rightAnswer);
  //      }

  //  // DELETE:
  //  int k = 1;
  //  for (QuestionWithAnswer *item in fetchedObjects) {
  //    if (k > 0) {
  //      NSLog(@"Deleting Object '%@'", item.question);
  //      [_cdHelper.context deleteObject:item];
  //    }
  //    k++;
  //  }
  //  [self.cdHelper saveContext];

  // Download new questions from Parse.com
  PFQuery *query = [PFQuery queryWithClassName:[question parseClassName]];
  [query orderByAscending:@"createdAt"];
  query.limit = query.countObjects - fetchedObjects.count;
  NSLog(@"%ld", query.countObjects);
  NSLog(@"%ld", fetchedObjects.count);
  NSLog(@"%ld", query.limit);

  __weak id weakSelf = self;
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
      if (!error) {
        NSLog(@"%lu", objects.count);

        for (QuestionWithAnswer *item in objects) {
          NSLog(@"%@", item);

          QuestionWithAnswer *quest = [NSEntityDescription
              insertNewObjectForEntityForName:@"QuestionWithAnswer"
                       inManagedObjectContext:_cdHelper.context];

          quest.question = item.question;
          [quest setAnswerOne:item.answerOne];
          [quest setAnswerTwo:item.answerTwo];
          [quest setAnswerThree:item.answerThree];
          [quest setRightAnswer:item.rightAnswer];
          [_cdHelper.context insertObject:quest];
          [[weakSelf cdHelper] saveContext];
        }
      }
  }];
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
