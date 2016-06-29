//
//  ViewController.h
//  AppSymbolic
//
//  Created by Tamim Ryhan on 13/11/15.
//  Copyright © 2015 Tamim Ryhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureView.h"
#import "DollarPGestureRecognizer.h"


@interface ViewController : UIViewController<UITextViewDelegate, UIGestureRecognizerDelegate, UIApplicationDelegate>

{

    
    __weak IBOutlet GestureView *gestureView;
    DollarPGestureRecognizer *dollarPGestureRecognizer;
    BOOL recognized;
    


}


@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *leftSwipeGestureRecognizer;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *rightSwipeGestureRecognizer;



@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@property (weak, nonatomic) IBOutlet UIView *myUIView;

- (void)actionButton:(id)sender;
- (void)gestureRecognized:(DollarPGestureRecognizer *)sender;
@property (retain,nonatomic) UIActionSheet *fontTypeActionSheet;
@property (retain,nonatomic) UIActionSheet *fontSizeActionSheet;
@property (retain,nonatomic) UIActionSheet *fontColorActionSheet;
@property (retain,nonatomic) UIActionSheet *paragraphTypeActionSheet;


// Define all methods to edit text
-(void)SelectAllText:(id)sender;
-(void)CopyText:(id)sender;
-(void)CutText:(id)sender;
-(void)PasteText:(id)sender;
-(void)DeleteText:(id)sender;
-(void)UndoText:(id)sender;
-(void)RedoText:(id)sender;
-(void)BoldText:(id)sender;
-(void)ItalicText:(id)sender;
-(void)UnderlineText:(id)sender;
-(void)HighlightText:(id)sender;
-(void)FontSizeText:(id)sender;
-(void)FontFamilyText:(id)sender;
-(void)ParagraphStyleText:(id)sender;
-(void)FontColorText:(id)sender;
-(void)StrikethorughText:(id)sender;
-(void)ShadowText:(id)sender;





@end

