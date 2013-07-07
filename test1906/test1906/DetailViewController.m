//
//  DetailViewController.m
//  test1906
//
//  Created by mobindus on 6/19/13.
//  Copyright (c) 2013 mobindustry. All rights reserved.
//

#import "DetailViewController.h"
#import "Person.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize myTable;
@synthesize fetchedResults;
@synthesize people;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showEntity];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backBtn:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) showEntity{
    self.people = [NSMutableArray array];
    self.fetchedResults = [Person MR_fetchAllSortedBy:@"firstname"
                                            ascending:YES
                                        withPredicate:nil
                                              groupBy:nil
                                             delegate:self
                                            inContext:[NSManagedObjectContext MR_contextForCurrentThread]];
//    self.people = [NSMutableArray arrayWithArray:[Person MR_findAllSortedBy:@"firstname" ascending:YES]];
    
}

#pragma mark - 
#pragma mark Table delegate

-(void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.myTable deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark Table datasource
-(void) tableView:(UITableView *) tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        Person *selectedPerson = [fetchedResults objectAtIndexPath:indexPath];
        //remove a person
        [selectedPerson MR_deleteInContext:[NSManagedObjectContext MR_contextForCurrentThread]];
        [[NSManagedObjectContext MR_contextForCurrentThread]MR_saveOnlySelfAndWait];
    }
}

-(NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResults sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

-(void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    Person *currentPerson = [fetchedResults objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", currentPerson.firstname, currentPerson.lastname];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", currentPerson.birthday];
}

-(UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"someIdentifier"];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"someIdentifier"];
    }
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

#pragma mark -
#pragma mark work with fetched information
-(void) controllerWillChangeContent:(NSFetchedResultsController *)controller{
    //prepare table view for updates
    [self.myTable beginUpdates];
}

-(void) controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    UITableView *tableView = self.myTable;
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}
-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.myTable endUpdates];
}

@end
