#import "SPComponentViewController.h"

@implementation SPComponentViewController
@synthesize langTable;
@synthesize langLabel;
@synthesize langArray;
@synthesize flagsArray;

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Компонент";
    
    
    //Заполняем массивы
    flagsArray = [[NSArray alloc] initWithObjects:@"russia.png", @"usa.png", @"germany.png", nil];
    langArray = [[NSArray alloc] initWithObjects:@"Русский", @"English", @"Deutsch", nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

//Снимаем выделение при переходе на это окно (тест)
//- (void) viewWillAppear:(BOOL)animated {
//    NSIndexPath *selectedIndexPath = [langTable indexPathForSelectedRow];
//    [langTable deselectRowAtIndexPath:selectedIndexPath animated:NO];
//    [langTable reloadData];
//}

#pragma mark - TableView
//Возвращает количество секций в таблице
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Определяем количество ячеек в таблице
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  langArray.count;
}

//Заполнение таблицы
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SPCustomCellViewController";
    SPCustomCellViewController *cell = (SPCustomCellViewController *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray * topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SPCustomCellViewController" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[SPCustomCellViewController class]]) {
                cell = (SPCustomCellViewController *) currentObject;
                break;
            }
        }
    }
    NSString *cellTitle = [[self langArray] objectAtIndex:[indexPath row]];

    //Присваиваем значения для ячейки таблицы
    cell.langLabel.text = cellTitle;
    cell.flagImg.image = [UIImage imageNamed:[flagsArray objectAtIndex:indexPath.row]];
    return cell;
}

//Выбор языка
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *stateSelected =
    [langArray objectAtIndex:[indexPath row]];
    NSString *msg = [[NSString alloc] initWithFormat:
                     @"You have selected %@", stateSelected];
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"lang selected"
                               message:msg
                              delegate:self
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil];
    [alert show];
    if (indexPath) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check.png"]];
        [tableView cellForRowAtIndexPath:indexPath].accessoryView = imageView;
        indexPath=FALSE;
    }
    
}


@end
