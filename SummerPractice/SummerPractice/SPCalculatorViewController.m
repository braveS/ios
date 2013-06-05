#import "SPCalculatorViewController.h"

@interface SPCalculatorViewController()
@property (readonly) SPCalculatorBrain *brain;
@end

@implementation SPCalculatorViewController
@synthesize dialogText;
@synthesize displayLabel;

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Калькулятор";
    NSArray *dialogArray = [NSArray arrayWithObjects:@"Приветствую..пшш.шш.. Подсчитай-ка сегодняшние доходы!", @"Как дела?", @"Приступим!", @"Пш..ш.. Я твой отец", nil];
    NSString *someString = [[NSString alloc] initWithFormat: @"%@", [dialogArray objectAtIndex:random()%[dialogArray count]]];
    dialogText.text = someString;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - Calculating
// Initialize our Calculator Brain
- (SPCalculatorBrain *)brain
{
	if (!brain) {
		brain = [[SPCalculatorBrain alloc] init];
	}
	return brain;
}

// Button action for digits
-(IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit = [sender.titleLabel text];
	if (userIsInTheMiddleOfTypingANumer) {
		if (!decUsed) {
			if ([digit isEqual:@"."]) {
				[displayLabel setText:[displayLabel.text stringByAppendingString:@"."]];
				decUsed = YES;
			}
			else {
				[displayLabel setText:[displayLabel.text stringByAppendingString:digit]];
			}
		}
		else {
			[displayLabel setText:[displayLabel.text stringByAppendingString:digit]];
		}
	}
	else {
		[displayLabel setText:digit];
		userIsInTheMiddleOfTypingANumer = YES;
	}
}

// Button action for operations
-(IBAction)operationPressed:(UIButton *)sender
{
	if (userIsInTheMiddleOfTypingANumer) {
		self.brain.operand = [displayLabel.text doubleValue];
		userIsInTheMiddleOfTypingANumer = NO;
	}
	NSString *operation = [sender.titleLabel text];
	[self.brain performOperation:operation];
	[displayLabel setText:[NSString stringWithFormat:@"%g", self.brain.operand]];
//    [dialogText setText:[NSString stringWithFormat:@"congratulations! %g", self.brain.operand]];
    NSArray *dialogArray = [NSArray arrayWithObjects:@"Уверен?", @"Да!", @"Хм...", @"Отлично!",@"Еще немного",@"Продолжай",@"Правильно",@"если рассудить правильно, то..",  nil];
    NSString *someString = [[NSString alloc] initWithFormat:
                            @"%@", [dialogArray objectAtIndex:random()%[dialogArray count]]];
    dialogText.text = someString;
}

-(IBAction)cancelInput{
    
}


@end
