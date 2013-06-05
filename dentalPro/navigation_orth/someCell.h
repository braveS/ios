//
//  someCell.h
//  navigation_orth
//
//  Created by Napoleon Bonapart on 01.12.11.
//  Copyright 2011 FPMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface someCell : UITableViewCell{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *phoneLabel;
    IBOutlet UILabel *operationLabel;
    IBOutlet UILabel *currentStateLabel;
    IBOutlet UILabel *timeLabel;
    
    IBOutlet UIImageView *photoView;
    IBOutlet UIImageView *phoneNumberView;
    IBOutlet UIImageView *checkView;
    //IBOutlet UIView *viewForBackground;
    
    IBOutlet UIButton *selectBtn;
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *phoneLabel;
@property (nonatomic, retain) IBOutlet UILabel *operationLabel;
@property (nonatomic, retain) IBOutlet UILabel *currentStateLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;

@property (nonatomic, retain) IBOutlet UIImageView *photoView;
@property (nonatomic, retain) IBOutlet UIImageView *phoneNumberView;
@property (nonatomic, retain) IBOutlet UIImageView *checkView;
//@property (nonatomic, retain) IBOutlet UIView *viewForBackground;

@property (nonatomic, retain) IBOutlet UIButton *selectBtn;


//- (IBAction)doselectBtn;


@end
