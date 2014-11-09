#import "GameOverScene.H"
#import "BestScore.h"
#import "TALocationProvider.h"
#import "MenuScene.h"

@implementation GameOverScene {
  UITextField *textField;
  SKLabelNode *labelDone;
  SKSpriteNode *gameOver;
  SKSpriteNode *waterLayer;
  int _score;
  SKLabelNode *yourScoreIs;

  // add location
  TALocationProvider *locationProvider;
}

- (instancetype)initWithSize:(CGSize)size andScore:(int)score {
  if (self = [super initWithSize:size]) {
    self.backgroundColor = [UIColor blackColor];
    _score = score;
  }
  return self;
}
- (void)didMoveToView:(SKView *)view {

  [self runAction:[SKAction playSoundFileNamed:@"incorrect.wav"
                             waitForCompletion:NO]];

  gameOver = [SKSpriteNode spriteNodeWithImageNamed:@"gameover.png"];
  gameOver.position =
      CGPointMake(self.frame.size.width / 2, self.frame.size.height - 150);
  gameOver.zPosition = 600;

  waterLayer = [SKSpriteNode spriteNodeWithImageNamed:@"water_layer_over.png"];
  waterLayer.position =
      CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
  waterLayer.alpha = 0.5;

  yourScoreIs = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  yourScoreIs.position =
      CGPointMake(self.size.width / 2, self.size.height / 2 + 50);
  yourScoreIs.text = [NSString stringWithFormat:@"YourScoreIs %d", _score];
  yourScoreIs.fontSize = 40;
  yourScoreIs.zPosition = 500;

  // add location
  locationProvider = [[TALocationProvider alloc] init];
  textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
  textField.center = self.view.center;
  textField.borderStyle = UITextBorderStyleRoundedRect;
  textField.textColor = [UIColor blackColor];
  textField.font = [UIFont systemFontOfSize:17.0];
  textField.placeholder = @"Enter your name here";
  textField.backgroundColor = [UIColor whiteColor];
  textField.autocorrectionType = UITextAutocorrectionTypeYes;
  textField.keyboardType = UIKeyboardTypeDefault;
  textField.clearButtonMode = UITextFieldViewModeWhileEditing;

  labelDone = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  labelDone.position =
      CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 - 100);
  labelDone.text = @"DONE";
  labelDone.fontSize = 40;
  labelDone.zPosition = 500;
  [self runAction:[SKAction playSoundFileNamed:@"incorrect.wav"
                             waitForCompletion:NO]];

  [self addChild:waterLayer];
  [self addChild:yourScoreIs];
  [self addChild:labelDone];
  [self addChild:gameOver];
  [self.view addSubview:textField];
}

- (void)locationUpdated:(CLLocation *)geoLocation {

  NSString *geoLocationMessage =
      [NSString stringWithFormat:@"Your position is (%lf, %lf)",
                                 geoLocation.coordinate.latitude,
                                 geoLocation.coordinate.longitude];
  NSLog(@"%@", geoLocationMessage);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInNode:self.scene];

  if (CGRectContainsPoint(labelDone.frame, location)) {
    NSString *name = [textField text];
    NSNumber *score = [NSNumber numberWithInt:_score];

    if (name.length >= 12) {
      UIAlertView *nameLength = [[UIAlertView alloc]
              initWithTitle:@"Message"
                    message:@"Your name must be shorter than 12 symbols."
                   delegate:nil
          cancelButtonTitle:@"OK"
          otherButtonTitles:nil];
      [nameLength show];
    }
    if (name.length < 3) {

      UIAlertView *nameLength = [[UIAlertView alloc]
              initWithTitle:@"Message"
                    message:@"Your name must be longer than 3 symbols"
                   delegate:nil
          cancelButtonTitle:@"OK"
          otherButtonTitles:nil];
      [nameLength show];

    } else {
      // Add score to Parse.com
      BestScore *bestScore = [BestScore object];
      [bestScore setPlayerName:name];
      [bestScore setPlayerResult:score];

      [locationProvider getLocationWithTarget:self
                                    andAction:@selector(locationUpdated:)];
      [locationProvider getLocationWithBlock:^(CLLocation *geoLocation) {
          NSString *geoLocationMessage =
              [NSString stringWithFormat:@"Your position is (%lf, %lf)",
                                         geoLocation.coordinate.latitude,
                                         geoLocation.coordinate.longitude];
          NSLog(@"%@", geoLocationMessage);

          CLGeocoder *coder = [[CLGeocoder alloc] init];
          [coder
              reverseGeocodeLocation:geoLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       CLPlacemark *mark = [placemarks lastObject];
                       NSLog(@"%@ - %@ - %@", mark.name, mark.subLocality,
                             mark.country);

                       [bestScore setLocationName:mark.name];

                       if (mark.subLocality) {
                         [bestScore setSubLocality:mark.subLocality];
                       } else {
                         [bestScore setSubLocality:@""];
                       }

                       if (mark.country) {
                         [bestScore setCountryName:mark.country];
                       } else {
                         [bestScore setCountryName:@""];
                       }

                       [bestScore saveInBackgroundWithBlock:^(BOOL succeeded,
                                                              NSError *error) {
                           if (succeeded) {
                             NSLog(@"Result saved");
                             [[[UIAlertView alloc]
                                     initWithTitle:@"Thank you for playing"
                                           message:@"Goodbye. \nLooking "
                                                   @"forward to see you again."
                                          delegate:self
                                 cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil, nil] show];
                           } else {
                             NSLog(@"%@", error);
                           }
                       }];

                   }];
      }];
    }
  }
}
- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  NSString *title = [alertView buttonTitleAtIndex:buttonIndex];

  if ([title isEqualToString:@"Ok"]) {

    exit(0);
  }
}
@end
