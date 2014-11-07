//
//  QuestionScene.m
//  SwordfishGame
//
//  Created by admin on 11/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "QuestionScene.h"
#import "CoreDataHelper.h"
#import "QuestionWithAnswer.h"

@interface QuestionScene ()

// for coredata
@property(nonatomic, strong) CoreDataHelper *cdHelper;

@end

@implementation QuestionScene

- (void)didMoveToView:(SKView *)view {

  _cdHelper = [[CoreDataHelper alloc] init];
  [_cdHelper setupCoreData];

  NSFetchRequest *request =
      [NSFetchRequest fetchRequestWithEntityName:@"QuestionWithAnswer"];

  NSArray *fetchedObjects =
      [_cdHelper.context executeFetchRequest:request error:nil];

  for (QuestionWithAnswer *q in fetchedObjects) {
    NSLog(@"Question = %@", q.question);
    NSLog(@"Answer A = %@", q.answerOne);
    NSLog(@"Answer B = %@", q.answerTwo);
    NSLog(@"Answer C = %@", q.answerThree);
    NSLog(@"Right answer = %@", q.rightAnswer);
  }
    
    QuestionWithAnswer * currentQuestion = fetchedObjects[arc4random_uniform(fetchedObjects.count)];
    SKLabelNode * question = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    SKLabelNode * answerOne = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    SKLabelNode * answerTwo = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    SKLabelNode * answerTree = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    question.position = CGPointMake(self.size.width/2, self.size.height/2);
    question.text = currentQuestion.question;
    question.fontSize = 40;
    
    answerOne.position  = CGPointMake(self.size.width/2 - 100, self.size.height/2 - 50);
    answerOne.text = currentQuestion.answerOne;
     answerOne.fontSize = 20;
    
     answerTwo.position  = CGPointMake(self.size.width/2 , self.size.height/2 - 50);
    answerTwo.text = currentQuestion.answerTwo;
     answerTwo.fontSize = 20;
    
      answerTree.position  = CGPointMake(self.size.width/2 + 100, self.size.height/2 - 50);
    answerTree.text = currentQuestion.answerThree;
     answerTree.fontSize = 20;
    
        [self addChild:question];
    [self addChild:answerOne];
    [self addChild:answerTwo];
    [self addChild:answerTree];

    
    
}

@end
