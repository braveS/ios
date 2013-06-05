#import <UIKit/UIKit.h>

@interface SPCustomCellViewController : UITableViewCell {
    IBOutlet UIImageView *flagImg;
    IBOutlet UIImageView *checkImg;
    IBOutlet UILabel *langLabel;
}

@property (nonatomic, retain) IBOutlet UIImageView *flagImg;
@property (nonatomic, retain) IBOutlet UIImageView *checkImg;
@property (nonatomic, retain) IBOutlet UILabel *langLabel;

@end
