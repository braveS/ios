#import <UIKit/UIKit.h>
#import "SPCustomCellViewController.h"

@interface SPComponentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {    
    IBOutlet UITableView * langTable;
    IBOutlet UILabel * langLabel;
    
    NSArray * flagsArray;
    NSArray * langArray;
}

@property (nonatomic, retain) IBOutlet UITableView * langTable;
@property (nonatomic, retain) IBOutlet UILabel * langLabel;
@property (nonatomic, retain) NSArray * flagsArray;
@property (nonatomic, retain) NSArray * langArray;

@end
