//
//  ViewController.h
//  TestGesture
//
//  Created by Tamim Ryhan on 09/07/15.
//  Copyright (c) 2015 Tamim Ryhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DollarPGestureRecognizer.h"
#import "GestureView.h"
#import "DollarDefaultGestures.h"

@interface ViewController : UIViewController<UITextViewDelegate, UIActionSheetDelegate>

{

    
    
    __weak IBOutlet GestureView *gestureView;
   DollarPGestureRecognizer *dollarPGestureRecognizer;
    BOOL recognized;
    
   
}

@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property(retain,nonatomic) GestureView *myGestureView;
//-(void)recognizeGesture:(DollarPGestureRecognizer*)sender;
@property (retain,nonatomic) UIActionSheet *fontTypeActionSheet;
@property (retain,nonatomic) UIActionSheet *fontSizeActionSheet;
@property (retain,nonatomic) UIActionSheet *paragraphTypeActionSheet;
@property (retain, nonatomic) UIActionSheet *fontColorActionSheet;

// Define method names
-(void)UndoText;
-(void)RedoText;
-(void)BoldText;
-(void)UnderlineText;
-(void)CutText;
-(void)CopyText;
-(void)PasteText;
-(void)DeleteText;
-(void)ShadowText;
-(void)StrikethroughText;
-(void)SelectAllText;
-(void)ItalicText;




@end


