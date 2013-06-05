#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface SPGraphViewController : UIViewController <CPTPlotDataSource> {
    CPTXYGraph *graph;
    IBOutlet UIView *graphView;
    IBOutlet UIButton *buildBtn;
    IBOutlet UIImageView *taskImageView;
    
    NSString *functionString;
}
@property (nonatomic, retain) IBOutlet UIView *graphView;
@property (nonatomic, retain) IBOutlet UIImageView * taskImageView;

-(IBAction) doBuildBtn;
@end
