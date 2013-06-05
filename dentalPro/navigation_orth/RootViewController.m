//
//  RootViewController.m
//  navigation_orth
//
//  Created by Napoleon Bonapart on 01.12.11.
//  Copyright 2011 FPMSoft. All rights reserved.
//

#import "RootViewController.h"
#import "navigation_orthAppDelegate.h"
#import "EditingView.h"
#import "PatientSQL.h"

@implementation RootViewController
@synthesize mainBar;
@synthesize sceduleTable;
@synthesize currentDateLabel;
@synthesize currentDayLabel;

// Читаем интерфейс окна редактирования из внешнего файла EditingView.xib
-(EditingView *)editViewController {
    if (editViewController == nil) {
        editViewController = [[EditingView alloc] initWithNibName:@"EditingView" bundle:nil];
    }
    return editViewController;
}

- (void) viewWillAppear:(BOOL)animated {
    NSIndexPath *selectedIndexPath = [sceduleTable indexPathForSelectedRow];
    [sceduleTable deselectRowAtIndexPath:selectedIndexPath animated:NO];
    
    [sceduleTable reloadData];
}

- (void)dealloc
{
    [sceduleTable release];
    [editViewController release];
    [super dealloc];
}

// Вызывает появление окна создания нового документа
-(IBAction)addRecord {
    EditingView *controller = self.editViewController;
    controller.patient = [[[PatientSQL alloc] init] autorelease];
    
    //navigation_orthAppDelegate *appDelegate = (navigation_orthAppDelegate *) [[UIApplication sharedApplication] delegate];
    //NSLog(@"pushed %@", appDelegate.primaryKeyNum);

    [[self navigationController] pushViewController:controller animated:YES];
}

- (IBAction) deleteRecord{

}

- (void)viewDidLoad
{
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [super viewDidLoad];
    // Set date for labels
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:now];
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"EEEE"];
    NSString *dateString2 = [dateFormat2 stringFromDate:now];
    currentDateLabel.text = dateString;
    currentDayLabel.text  = dateString2;
    
    [dateFormat release];
    [dateFormat2 release];
    // *** Set date for labels
    self.title = @"Scedule";
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self.sceduleTable reloadData];
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete) {
     navigation_orthAppDelegate *appDelegate = (navigation_orthAppDelegate *) [[UIApplication sharedApplication] delegate];
        //Get the object to delete from the array.
        PatientSQL *patient = [appDelegate.patients objectAtIndex:indexPath.row];
        [appDelegate deleteRowFromDatabase: patient];
        
        //Delete the object from the table.
        [self.sceduleTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    NSLog(@"edstyleWas");
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
	[super setEditing:editing animated:animated];
    [self.sceduleTable setEditing:editing animated:YES];
	
	//Do not let the user add if the app is in edit mode.
	if(editing)
		self.navigationItem.rightBarButtonItem.enabled = NO;
	else
		self.navigationItem.rightBarButtonItem.enabled = YES;
}	

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    navigation_orthAppDelegate *appDelegate = (navigation_orthAppDelegate *)[[UIApplication sharedApplication] delegate];
    return [appDelegate.patients count];
}

-(UITableViewCell *) tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"someCell";
    someCell *cell = (someCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UIImage *buttonImage = [UIImage imageNamed:@"arrow.png"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];    
    
    if (cell==nil) 
    {       
        NSArray *topLevelObjectcs = [[NSBundle mainBundle] loadNibNamed:@"someCell" owner: nil options:nil];
        for (id currentObject in topLevelObjectcs) 
        {
            if([currentObject isKindOfClass:[someCell class]])
            {
                cell = (someCell*) currentObject;
                break;
            }
        }                            
    }
    // Получаем ссылку на делегат класса UIApplication и доступ к его переменным
    navigation_orthAppDelegate *appDelegate = (navigation_orthAppDelegate *)[[UIApplication sharedApplication] delegate];
	PatientSQL *patient = (PatientSQL *)[appDelegate.patients objectAtIndex:indexPath.row];
	
    //EditingView *boolDelegate = (EditingView *) [[UIApplication sharedApplication] delegate];
    
	cell.nameLabel.text=patient.name;
    cell.phoneLabel.text=patient.phone;
    [cell.photoView setImage:patient.photo];
    NSLog(@"patientPhotoCell %@",patient.photo);
    cell.timeLabel.text=patient.meetTime;
    NSLog(@"name %@", patient.name);
    cell.currentStateLabel.text= patient.complainsText;
    cell.operationLabel.text= patient.diagnosisText;
        
    [cell.selectBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    if (cell.phoneLabel.text != NULL) 
    [[cell phoneNumberView] setImage:[UIImage imageNamed:@"phone.png"]];
    
    NSInteger currValue = [patient.checkedBool integerValue];
    NSLog(@"currValue= %i", currValue);
    
    if (currValue != 0)
    [[cell checkView] setImage:[UIImage imageNamed:@"check_v2_1.png"]];
   
    NSLog(@"patient.checked = %@", patient.checkedBool);
       return cell;
}

// Вызывает открытие окна редактирования для выбранного документа в таблице
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    navigation_orthAppDelegate *appDelegate = (navigation_orthAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    EditingView *controller = self.editViewController;
    
    PatientSQL *patient = (PatientSQL *)[appDelegate.patients objectAtIndex:indexPath.row];
    
    //NSLog(@"primary Key DIDSELECT =%i", patient.primaryKey);
    
    [patient readRecord];
    
    controller.patient = patient;
    
    [[self navigationController] pushViewController:controller animated:YES];
    //NSLog(@"didselect %i",indexPath.row);

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}



@end
