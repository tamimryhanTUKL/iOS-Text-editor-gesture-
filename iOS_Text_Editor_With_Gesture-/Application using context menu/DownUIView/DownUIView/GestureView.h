#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DollarPGestureRecognizer.h"
@interface GestureView : UIView {
    NSMutableDictionary *currentTouches;
    NSMutableArray *completeStrokes;
    DollarPGestureRecognizer *dollarPGestureRecognizer;

}

-(void)clearAll;

-(void)fireNotification:(NSNotification*)sender;

@end