//
//  DetailViewController.h
//  test1906
//
//  Created by mobindus on 6/19/13.
//  Copyright (c) 2013 mobindustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *myTable;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResults;
@property (nonatomic, strong) NSArray *people;

-(IBAction)backBtn:(id)sender;

@end
