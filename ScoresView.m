#import "ScoresView.h"
#import <Parse/Parse.h>
#import "BestScore.h"

@interface ScoresView () <UITableViewDataSource, UITableViewDelegate>

// for downloading players bestScores
@property(nonatomic, strong) NSMutableArray *bestScores;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ScoresView {
  //  UITableView *_tableView;
  UITableViewCell *_cell;
}

// for downloading players bestScores**************************************
- (instancetype)init {
  self = [super init];
  if (self) {
    self.bestScores = [NSMutableArray array];
  }
  return self;
}

//- (id)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super initWithCoder:aDecoder]) {
//        self.bestScores = [NSMutableArray array];
//    }
//    return self;
//}
//
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil
//                         bundle:(NSBundle *)nibBundleOrNil {
//
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//        self.bestScores = [NSMutableArray array];
//    }
//    return self;
//}
// ************************************************************************

- (void)didMoveToView:(SKView *)view {
  [super didMoveToView:view];
  BestScore *bestScore = [BestScore object];

  // for downloading players bestScores************************************
  PFQuery *query = [PFQuery queryWithClassName:[bestScore parseClassName]];
  [query orderByDescending:@"playerScore"];
  //    query.limit = 10;
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
        //        [_tableView reloadData];
      }
  }];
  //    __weak id weakSelf = self;
  //    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError
  //    *error) {
  //        if(!error){
  //            [weakSelf setPeople:[NSMutableArray arrayWithArray:objects]];
  //            [[weakSelf tableViewPeople] reloadData];
  //        }
  //    }];

  // **********************************************************************
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

  _cell.detailTextLabel.text = [currentScore.playerResult stringValue];
  _cell.textLabel.text = currentScore.playerName;

  return _cell;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {

  NSLog(@"%ld", self.bestScores.count);
  return self.bestScores.count;
}

@end
