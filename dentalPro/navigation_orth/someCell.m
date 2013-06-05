//
//  someCell.m
//  navigation_orth
//
//  Created by Napoleon Bonapart on 01.12.11.
//  Copyright 2011 FPMSoft. All rights reserved.
//

#import "someCell.h"

@implementation someCell
@synthesize nameLabel, timeLabel, operationLabel, currentStateLabel, phoneLabel, phoneNumberView,photoView, checkView;
@synthesize selectBtn;
//@synthesize backgroundView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    //[self doselectBtn];
    // Configure the view for the selected state
}


-(NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    navigation_orthAppDelegate *appDelegate = (navigation_orthAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.patients.count;
}
/*
- (IBAction)doselectBtn{
    [self doBtn];
}

+ (void) doBtn {
     [navigation_orthAppDelegate didSelectRowAtIndexPath];
}
*/
@end











