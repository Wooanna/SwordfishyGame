#import "QuestionScene.h"
#import "CoreDataHelper.h"
#import "QuestionWithAnswer.h"

@interface QuestionScene ()

// for coredata
@property(nonatomic, strong) CoreDataHelper *cdHelper;

@end

@implementation QuestionScene

const int fontSize = 25;
const int offset = 60;
- (void)initQuestionNode {

  _cdHelper = [[CoreDataHelper alloc] init];
  [_cdHelper setupCoreData];

  NSFetchRequest *request =
      [NSFetchRequest fetchRequestWithEntityName:@"QuestionWithAnswer"];

  NSArray *fetchedObjects =
      [_cdHelper.context executeFetchRequest:request error:nil];

  QuestionWithAnswer *currentQuestion =
      fetchedObjects[arc4random_uniform((uint32_t)fetchedObjects.count)];
  _question = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _answerOne = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _answerTwo = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _answerTree = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];

  _question.position =
      CGPointMake(self.size.width / 2 - self.size.width / 2,
                  self.size.height / 2 - self.size.height / 2 + 120);
  _question.text = currentQuestion.question;
  _question.fontSize = fontSize;
  _question.fontColor = [UIColor brownColor];

  _answerOne.position =
      CGPointMake(self.size.width / 2 - self.size.width / 2,
                  self.size.height / 2 - self.size.height / 2 - 2*offset);
  _answerOne.text = currentQuestion.answerOne;
  _answerOne.fontSize = fontSize;
  _answerOne.fontColor = [UIColor brownColor];

  _answerTwo.position =
      CGPointMake(self.size.width / 2 - self.size.width / 2,
                  self.size.height / 2 - self.size.height / 2 - offset);
  _answerTwo.text = currentQuestion.answerTwo;
  _answerTwo.fontSize = fontSize;
  _answerTwo.fontColor = [UIColor brownColor];

  _answerTree.position =
      CGPointMake(self.size.width / 2 - self.size.width / 2,
                  self.size.height / 2 - self.size.height / 2);
  _answerTree.text = currentQuestion.answerThree;
  _answerTree.fontSize = fontSize;
  _answerTree.fontColor = [UIColor brownColor];

  _rightAnswer = currentQuestion.rightAnswer;

  [self addChild:_question];
  [self addChild:_answerOne];
  [self addChild:_answerTwo];
  [self addChild:_answerTree];
}

- (CGRect)getAnswerOneFrame {
  return _answerOne.frame;
}
- (CGRect)getAnswerTwoFrame {
  return _answerTwo.frame;
}
- (CGRect)getAnswerTreeFrame {
  return _answerTree.frame;
}

- (NSNumber *)getRightAnswer {
  return _rightAnswer;
}

@end
