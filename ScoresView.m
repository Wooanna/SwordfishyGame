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
      [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,
                                                    self.frame.size.height)];
  _tableView.delegate = self;
  _tableView.dataSource = self;
  [self.view addSubview:_tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  NSString *identifier = @"cell";

  _cell = [tableView dequeueReusableCellWithIdentifier:identifier];

  if (!_cell) {
    _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                   reuseIdentifier:identifier];
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

@end
