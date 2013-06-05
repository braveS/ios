//
//  InfoView.h
//  navigation_orth
//
//  Created by Mobile on 07.12.11.
//  Copyright 2011 FPMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingView.h"

@class EditingView;
@interface InfoView : UIViewController <UITableViewDelegate> {
    IBOutlet UITextView *someText;
    IBOutlet NSString *detailText;

}
@property (nonatomic,retain) IBOutlet UITextView *someText;
@property (nonatomic, retain) IBOutlet NSString *detailText;


@end
