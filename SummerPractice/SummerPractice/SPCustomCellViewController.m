#import "SPCustomCellViewController.h"

@implementation SPCustomCellViewController
@synthesize langLabel;
@synthesize flagImg;
@synthesize checkImg;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

@end
