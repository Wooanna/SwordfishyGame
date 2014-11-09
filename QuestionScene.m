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

- (void)initQuestionNode {

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

  QuestionWithAnswer *currentQuestion =
      fetchedObjects[arc4random_uniform(fetchedObjects.count)];
  _question = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _answerOne = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _answerTwo = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _answerTree = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];

  _question.position = CGPointMake(self.size.width/2 -self.size.width/2, self.size.height/2 - self.size.height/2 + 120);
  _question.text = currentQuestion.question;
  _question.fontSize = 20;
    _question.fontColor = [UIColor brownColor];

  _answerOne.position =
      CGPointMake(self.size.width/2 -self.size.width/2 , self.size.height/2 - self.size.height/2 - 100);
  _answerOne.text = currentQuestion.answerOne;
  _answerOne.fontSize = 20;
     _answerOne.fontColor = [UIColor brownColor];

  _answerTwo.position =
      CGPointMake(self.size.width/2 -self.size.width/2, self.size.height/2 - self.size.height/2 - 50);
  _answerTwo.text = currentQuestion.answerTwo;
  _answerTwo.fontSize = 20;
     _answerTwo.fontColor = [UIColor brownColor];

  _answerTree.position =
      CGPointMake(self.size.width/2 -self.size.width/2, self.size.height/2 - self.size.height/2 );
  _answerTree.text = currentQuestion.answerThree;
  _answerTree.fontSize = 20;
     _answerTree.fontColor = [UIColor brownColor];
    
  

  [self addChild:_question];
  [self addChild:_answerOne];
  [self addChild:_answerTwo];
  [self addChild:_answerTree];
}

-(CGRect)getAnswerOneFrame{
        return  _answerOne.frame;
}
-(CGRect)getAnswerTwoFrame{
    return  _answerTwo.frame;
}
-(CGRect)getAnswerTreeFrame{
    return  _answerTree.frame;
}


   @end
