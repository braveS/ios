#import "SPCalculatorBrain.h"
@implementation SPCalculatorBrain
@synthesize operand;
@synthesize num = numSave;

#pragma mark - Actions
-(void)performWaitingOperation
{
	if ([@"+" isEqual:waitingOperation]) {
		operand = waitingOperand +	operand;
	}
	else if ([@"*" isEqual:waitingOperation]) {
		operand = waitingOperand * operand;
	}
	else if ([@"-" isEqual:waitingOperation]) {
		operand = waitingOperand - operand;
	}
	else if ([@"/" isEqual:waitingOperation]) {
		// Gives error if divide by 0
		if (operand) {
			operand = waitingOperand / operand;
		}
		else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка!" 
															message:@"Деление на 0 невозможно" 
														   delegate:nil 
												  cancelButtonTitle:@"Ок" 
												  otherButtonTitles:nil];
			[alert show];
		}
	}
}

// Perform one of the operations on the number operand
-(double)performOperation:(NSString *)operation
{
	if ([operation isEqual:@"sqrt"]) {
		operand = sqrt(operand);
	}
	else if ([@"tg" isEqual:operation]) {
		operand = tan(operand);
	}
    else if ([@"ctg" isEqual:operation]) {
		operand = 1/tan(operand);
	} else {
		[self performWaitingOperation];
		waitingOperation = operation;
		waitingOperand = operand;
	}
    
	return operand;
}


@end
