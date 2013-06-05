#import <Foundation/Foundation.h>

@interface SPCalculatorBrain : NSObject {
@private
	double operand;
	NSString *waitingOperation;
	double waitingOperand;
	double numSave;
}
@property double operand;
@property double num;

- (double)performOperation:(NSString *)operation;

@end
