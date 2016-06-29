//
//  ViewController.h
//  DownUIView
//
//  Created by Tamim Ryhan on 21/10/15.
//  Copyright © 2015 Tamim Ryhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DollarPGestureRecognizer.h"
#import "GestureView.h"


@interface ViewController : UIViewController<UITextViewDelegate,UIGestureRecognizerDelegate,UIApplicationDelegate>

{

    __weak IBOutlet GestureView *gestureView;
    DollarPGestureRecognizer *dollarPGestureRecognizer;
    BOOL recognized;



}


@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UIView *myUIView;
- (void)actionButton:(id)sender;
- (void)gestureRecognized:(DollarPGestureRecognizer *)sender;
@property (retain,nonatomic) UIActionSheet *fontTypeActionSheet;
@property (retain,nonatomic) UIActionSheet *fontSizeActionSheet;
@property (retain,nonatomic) UIActionSheet *fontColorActionSheet;
@property (retain,nonatomic) UIActionSheet *paragraphTypeActionSheet;
@property(readwrite, nonatomic) NSUndoManager *undoManager;


// Define all methods to edit text
-(void)SelectAllText:(id)sender;
-(void)CopyText:(id)sender;
-(void)CutText:(id)sender;
-(void)PasteText:(id)sender;
-(void)DeleteText:(id)sender;
-(IBAction)UndoText:(id)sender;
-(IBAction)RedoText:(id)sender;
-(void)BoldText:(id)sender;
-(void)ItalicText:(id)sender;
-(void)UnderlineText:(id)sender;
-(void)HighlightText:(id)sender;
-(void)FontSizeText:(id)sender;
-(void)FontTypeText:(id)sender;
-(void)ParagraphStyleText:(id)sender;
-(void)FontColorText:(id)sender;
-(void)StrikethorughText:(id)sender;
-(void)ShadowText:(id)sender;





@end

