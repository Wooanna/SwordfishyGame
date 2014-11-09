#import "ScoresView.h"
#import <Parse/Parse.h>
#import "BestScore.h"


@interface ScoresView () <UITableViewDataSource, UITableViewDelegate>

// for downloading players bestScores
@property(nonatomic, strong) NSMutableArray *bestScores;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ScoresView {
  UITableViewCell *_cell;
    SKLabelNode *_scores;
    SKLabelNode *_menu;
}

// for downloading players bestScores
- (instancetype)init {
  self = [super init];
  if (self) {
    self.bestScores = [NSMutableArray array];
      
  }
  return self;
}


- (void)didMoveToView:(SKView *)view {
  [super didMoveToView:view];
  BestScore *bestScore = [BestScore object];

  // for downloading players bestScores
  PFQuery *query = [PFQuery queryWithClassName:[bestScore parseClassName]];
  [query orderByDescending:@"playerScore"];

  __weak id weakSelf = self;
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
      if (!error) {
        NSArray *sortedArray;
        sortedArray = [objects
            sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                NSNumber *first = [(BestScore *)a playerResult];
                NSNumber *second = [(BestScore *)b playerResult];
                return [second compare:first];
            }];

        [weakSelf setBestScores:[NSMutableArray arrayWithArray:sortedArray]];
        [[weakSelf tableView] reloadData];
      }
  }];

  _tableView =
      [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/3,
                                                    self.frame.size.height/2 - 100)];
  _tableView.delegate = self;
  _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"notebook_sheet.jpg"]];
_tableView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    _scores = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    _scores.position = CGPointMake(self.size.width/2, self.size.height - 50);
    _scores.fontSize = 30;
    _scores.text = @"SCORES: ";
    
    _menu = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    _menu.position = CGPointMake(self.size.width/2, 50);
    _menu.fontSize = 30;
    _menu.text = @"MENU";
    [self addChild:_menu];
    [self addChild:_scores];
  [self.view addSubview:_tableView];
}

- (void)setReturnScene:(SKScene *)returnScene {
    _returnScene = returnScene;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  NSString *identifier = @"cell";

  _cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!_cell) {
    _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                   reuseIdentifier:identifier];
        [_cell setBackgroundColor:[UIColor clearColor]];
        _cell.textLabel.font = [UIFont fontWithName:@"Chalkduster" size:15];

  }
  BestScore *currentScore = self.bestScores[indexPath.row];

  NSString *textLabel =
      [[NSString alloc] initWithFormat:(@"%@ - %@"), currentScore.playerName,
                                       currentScore.playerResult];
  NSString *detailTextLabel = [[NSString alloc]
      initWithFormat:(@"%@   %@   %@"), currentScore.locationName,
                     currentScore.subLocality, currentScore.countryName];

  _cell.textLabel.text = textLabel;

  _cell.detailTextLabel.text = detailTextLabel;

  return _cell;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {

  NSLog(@"%ld", self.bestScores.count);
  return self.bestScores.count;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self.scene];
    
    if(CGRectContainsPoint(_menu.frame, location)){
        SKTransition* transition = [SKTransition fadeWithDuration:0.5];
        [_tableView removeFromSuperview];
        __weak typeof(self) weakMe = self;
        
        [weakMe.view presentScene:_returnScene transition:transition];
    }
}

@end
