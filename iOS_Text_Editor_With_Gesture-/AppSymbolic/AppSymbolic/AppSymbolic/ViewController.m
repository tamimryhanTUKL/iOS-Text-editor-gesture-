//
//  ViewController.m
//  AppSymbolic
//
//  Created by Tamim Ryhan on 13/11/15.
//  Copyright © 2015 Tamim Ryhan. All rights reserved.
//

#import "ViewController.h"
#import "DollarDefaultGestures.h"
#import "GestureView.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "DollarPGestureRecognizer.h"
#import "DollarResult.h"


@interface ViewController ()

@end


@implementation ViewController
@synthesize myUIView;
@synthesize myTextView;
bool recognized;
@synthesize fontSizeActionSheet;
@synthesize fontTypeActionSheet;
@synthesize fontColorActionSheet;
@synthesize paragraphTypeActionSheet;
@synthesize leftSwipeGestureRecognizer;
@synthesize rightSwipeGestureRecognizer;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // Initialize dollarPGestureRecognizer in viewDidLoad method
    dollarPGestureRecognizer = [[DollarPGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(gestureRecognized:)];
    [dollarPGestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
    [dollarPGestureRecognizer setDelaysTouchesEnded:NO];
    
    [gestureView addGestureRecognizer:dollarPGestureRecognizer];
    gestureView.userInteractionEnabled = YES;
    
    
    
    // Notification issues are here
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(actionButton:)
                                                 name:@"GestureNotification"
                                               object:nil];
    
    
    
    // For making text bold
    leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(BoldText:)];
    [leftSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [leftSwipeGestureRecognizer setNumberOfTouchesRequired:3];
    [[self view] addGestureRecognizer:leftSwipeGestureRecognizer];
    
    
    // For making text italic
    rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(ItalicText:)];
    [rightSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [rightSwipeGestureRecognizer setNumberOfTouchesRequired:3];
    [[self view] addGestureRecognizer:rightSwipeGestureRecognizer];
    
    
    leftSwipeGestureRecognizer.delegate = self;
    dollarPGestureRecognizer.delegate=self;
    myUIView.userInteractionEnabled = YES;
    self.view.userInteractionEnabled = YES;


}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    return  YES;
}



# pragma mark UIGestureRecognizerDelegate Method

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    
    return YES;
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    
}


# pragma mark - recognize the gesture

- (void)actionButton:(id)sender
{
    
    
    
    [dollarPGestureRecognizer recognize];
    [gestureView clearAll];
    recognized = !recognized;
    
}



// Reclamation for my undo/redo survival ;)

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    
    
}


// View and get resigned after perfroming operation ;)

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self resignFirstResponder];
}


// the savior method :)

-(BOOL)canBecomeFirstResponder
{
    return YES;
}



# pragma mark - other methods

- (void)gestureRecognized:(DollarPGestureRecognizer *)sender


{
    
    DollarResult *result = [sender result];
    
    NSLog(@"Gesture name=%@",[result name]);
    
    
    if ([[result name] isEqualToString:@"SelectAll_Rectangle_Gesture"])
    {
        
        [self SelectAllText:sender];
        
        
    }
    if ([[result name] isEqualToString:@"Copy_CopyIcon_Gesture"])
    {
        
        
        [self CopyText:sender];
        
    }
    
    if ([[result name] isEqualToString:@"Paste_Twofinger_Gesture"])
    {
        [self PasteText:sender];
    }
    
    if ([[result name] isEqualToString:@"Cut_Lasso_Gesture"])
    {
        
        [self CutText:sender];
        
    }
    if ([[result name] isEqualToString:@"Undo_1FingerLeftSwipe_Gesture"])
    {
        
        [self UndoText:sender];
        
    }
    if ([[result name] isEqualToString:@"Redo_1FingerRightSwipe_Gesture"])
    {
        [self RedoText:sender];
    }
    if ([[result name] isEqualToString:@"Italic_I_Gesture"])
    {
        
        
        [self ItalicText:sender];
        
        
    }
    
    if ([[result name] isEqualToString:@"Bold_TwofingerB_Gesture"])
    {
        [self BoldText:sender];
    }
    
    if ([[result name] isEqualToString:@"Underline_3FingerRightSwipe_Gesture"])
    {
        [self UnderlineText:sender];
    }
    
    if ([[result name] isEqualToString:@"Strikethrough_StopSymbol_Gesture"])
    {
        [self StrikethorughText:sender];
        
    }
    
    if ([[result name] isEqualToString:@"Delete_Zigzag_Gesture"])
    {
        [self DeleteText:sender];
    }
    
    if ([[result name] isEqualToString:@"Highlight_#_Gesture"])
    {
        [self HighlightText:sender];
    }
    
    if ([[result name] isEqualToString:@"Paragraphstyle_Frame_Gesture"])
    {
        
        [self ParagraphStyleText:sender];
        
        
        
    }
    
    if ([[result name] isEqualToString:@"Fontsize_+_Gesture"])
    {
        [self FontSizeText:sender];
        
    }
    
    if ([[result name] isEqualToString:@"Fontfamily__Gesture"])
    {
        
        [self FontFamilyText:sender];
    }
    
    if ([[result name] isEqualToString:@"Fontcolor_Circleinsidecircle_Gesture"])
    {
        [self FontColorText:sender];
        
    }
    
    if ([[result name] isEqualToString:@"Shadowtext_ShadowTriangle_Gesture"])
    {
        [self ShadowText:sender];
    }
    
    
    
    
}



// Select all text
-(void)SelectAllText:(id)sender
{
    
    [self.myTextView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1f];
    [self.myTextView selectAll:self];
    [[UIApplication sharedApplication] sendAction:@selector(selectAll:) to:nil from:self forEvent:nil];
}





// Copy selected text
-(void)CopyText:(id)sender
{
    [self.myTextView select:self];
    self.myTextView.selectedRange = NSMakeRange(0, [self.myTextView.text length]);
    [[UIApplication sharedApplication] sendAction:@selector(copy:) to:nil from:self forEvent:nil];
    [self.myTextView resignFirstResponder];
    
}

// Paste copied text
-(void)PasteText:(id)sender

{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    self.myTextView.text = [pb string];
    [[UIApplication sharedApplication] sendAction:@selector(paste:) to:nil from:self forEvent:nil];
}

// Cut Text
-(void)CutText:(id)sender
{
    [self.myTextView select:self];
    self.myTextView.selectedRange = NSMakeRange(0, [self.myTextView.text length]);
    [[UIApplication sharedApplication] sendAction:@selector(cut:) to:nil from:self forEvent:nil];
    [self.myTextView resignFirstResponder];
    self.myTextView.text= @"";
    
}

// Delete Selected Text
-(void)DeleteText:(id)sender
{
    [self.myTextView select:self];
    NSRange range = [myTextView selectedRange];
    myTextView.text = [myTextView.text stringByReplacingCharactersInRange:range withString:@""];
    
}


// Undo Action
-(void)UndoText:(id)sender
{
    NSUndoManager *myUndoManager =  [self.myTextView undoManager];
    [myUndoManager undo];
    
}

//  Redo Action
-(void)RedoText:(id)sender
{
    NSUndoManager *myRedoManager = [self.myTextView undoManager];
    [myRedoManager redo];
}

// Bold Text
-(void)BoldText:(id)sender
{NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    UIFontDescriptor *fontD = [myTextView.font.fontDescriptor fontDescriptorWithSymbolicTraits: UIFontDescriptorTraitBold];
    UIFont *font_bold = [UIFont fontWithDescriptor:fontD size:0];
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_bold
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];}

// Make Italic Text
-(void)ItalicText:(id)sender
{
    NSRange range = [myTextView selectedRange];
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    UIFontDescriptor *fontD = [myTextView.font.fontDescriptor fontDescriptorWithSymbolicTraits: UIFontDescriptorTraitItalic];
    UIFont *font_italic = [UIFont fontWithDescriptor:fontD size:0];
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_italic
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
}

// Underline text
-(void)UnderlineText:(id)sender
{
    NSRange range = [myTextView selectedRange];
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    if(range.location>0)
    {
        
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
        
    }
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute: NSUnderlineStyleAttributeName
                             value:[NSNumber numberWithInt:NSUnderlineStyleSingle]
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    [self.myTextView setAttributedText:attributedString];
    [myTextView setFont: font_regular];
    
}

// Highlight text
-(void)HighlightText:(id)sender
{
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSBackgroundColorAttributeName
                             value:[UIColor yellowColor]
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
    [myTextView setFont: font_regular];
    
}


-(void)StrikethorughText:(id)sender
{NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSStrikethroughStyleAttributeName
                             value:[NSNumber numberWithInt:2]
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
    [self.myTextView setFont:font_regular];
    
    
    
}



// Change Font type
-(void)FontFamilyText:(id)sender
{
    [self showFontTypeActionSheet:sender];
    
}

// ActionSheet method for Showing different Font type
-(void)showFontTypeActionSheet:(id)sender
{
    
    NSString *actionSheetTitle = @"Action Sheet Title";
    NSString *destructiveTitle = @"Destructive";
    NSString *other1 =  @"Courier";
    NSString *other2 =  @"Verdana";
    NSString *other3 = @"Georgia";
    NSString *cancelTitle = @"Cancel";
    
    
    
    fontTypeActionSheet = [[UIActionSheet alloc]initWithTitle:actionSheetTitle
                                                     delegate:self
                                            cancelButtonTitle:cancelTitle
                                       destructiveButtonTitle:destructiveTitle
                                            otherButtonTitles:other1,other2,other3, nil];
    
    [fontTypeActionSheet showInView:myTextView];
    
}



-(void)ShadowText:(id)sender
{
    
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    // Add Shadow on text
    NSShadow *shadow =  [[NSShadow alloc]init];
    [shadow setShadowColor:[UIColor colorWithRed:0.053 green:0.088 blue:0.205 alpha:1.000]];
    [shadow setShadowBlurRadius:4.0];
    [shadow setShadowOffset:CGSizeMake(2, 2)];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSShadowAttributeName
                             value:shadow
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
    [self.myTextView setFont:font_regular];
    
    
}





// Change Font size
-(void)FontSizeText:(id)sender
{
    [self ShowFontSizeActionSheet:sender];
    
}

// Action sheet method for showing different font size
-(void)ShowFontSizeActionSheet:(id)sender
{
    NSString *actionSheetTitle = @"Font Size";
    NSString *destructiveTitle = @"Destructive";
    NSString *other1 =  @"10";
    NSString *other2 =  @"12";
    NSString *other3 = @"14";
    NSString *other4 = @"16";
    NSString *other5 = @"18";
    NSString *other6 = @"20";
    NSString*other7 = @"32";
    NSString *cancelTitle = @"Cancel";
    
    fontSizeActionSheet = [[UIActionSheet alloc]
                           initWithTitle:actionSheetTitle
                           delegate:self
                           cancelButtonTitle:cancelTitle
                           destructiveButtonTitle:destructiveTitle
                           otherButtonTitles:other1,other2,other3,other4,other5,other6,other7, nil];
    
    [fontSizeActionSheet showInView:myTextView];
}



// ActionSheet method for different paragraph style
-(void)showParagraphTypeActionSheet:(id)sender
{
    
    NSString *actionSheetTitle = @"Paragraph Alignment";
    NSString *destructiveTitle = @"Destroy";
    NSString *other1 =  @"Center";
    NSString *other2 =  @"Left";
    NSString *other3 = @"Right";
    NSString *other4 = @"Justified";
    NSString *other5 = @"Natural";
    NSString *cancelTitle = @"Cancel";
    
    paragraphTypeActionSheet = [[UIActionSheet alloc]
                                initWithTitle:actionSheetTitle
                                delegate:self
                                cancelButtonTitle:cancelTitle
                                destructiveButtonTitle:destructiveTitle
                                otherButtonTitles:other1,other2,other3,other4,other5,nil];
    
    [paragraphTypeActionSheet showInView:myTextView];
    
    
    
}


// Method to apply different paragraph style in text
-(void)ParagraphStyleText:(id)sender
{
    
    [self showParagraphTypeActionSheet:sender];
    
}




// change font color

-(void)ShowFontColorActionSheet:(id)sender
{
    
    
    NSString *actionSheetTitle = @"Action Sheet Title";
    NSString *destructiveTitle = @"Destructive";
    NSString *other1 =  @"Red";
    NSString *other2 =  @"Blue";
    NSString *other3 = @"Green";
    NSString *other4 = @"Orange";
    NSString *other5 = @"Yellow";
    NSString *cancelTitle = @"Cancel";
    
    
    
    fontColorActionSheet = [[UIActionSheet alloc]initWithTitle:actionSheetTitle
                                                      delegate:self
                                             cancelButtonTitle:cancelTitle
                                        destructiveButtonTitle:destructiveTitle
                                             otherButtonTitles:other1,other2,other3,other4,other5,nil];
    
    [fontColorActionSheet showInView:myTextView];
    
    
    
}

-(void)FontColorText:(id)sender
{
    [self ShowFontColorActionSheet:sender];
}






// Fire the Action sheets UIActionSheetDelegate method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // for font type
    if(actionSheet == fontTypeActionSheet)
    {
        
        NSString *buttonTitle =  [actionSheet buttonTitleAtIndex:buttonIndex];
        
        if ([buttonTitle isEqualToString:@"Destructive"])
        {
            NSLog(@"Symphony of Destruction");
            
        }
        
        if ([buttonTitle isEqualToString:@"Courier"])
        {
            [self Courier];
            
        }
        
        if ([buttonTitle isEqualToString:@"Verdana"])
        {
            [self Verdana];
        }
        
        if ([buttonTitle isEqualToString:@"Georgia"])
        {
            [self Georgia];
        }
        
        if ([buttonTitle isEqualToString:@"Cancel"])
        {
            NSLog(@"Button Cancelled compadre");
            
        }
        
    }
    
    
    // font size
    if(actionSheet == fontSizeActionSheet)
    {
        
        NSString *buttonTitle =  [actionSheet buttonTitleAtIndex:buttonIndex];
        
        if ([buttonTitle isEqualToString:@"Destructive"])
        {
            NSLog(@"Symphony of Destruction");
            
        }
        
        if ([buttonTitle isEqualToString:@"10"])
        {
            [self FontSize10];
            
        }
        
        if ([buttonTitle isEqualToString:@"12"])
        {
            [self FontSize12];
        }
        
        if ([buttonTitle isEqualToString:@"14"])
        {
            [self FontSize14];
        }
        
        if ([buttonTitle isEqualToString:@"16"])
        {
            [self FontSize16];
        }
        if ([buttonTitle isEqualToString:@"18"])
        {
            [self FontSize20];
        }
        if ([buttonTitle isEqualToString:@"20"])
        {
            [self FontSize20];
        }
        
        if ([buttonTitle isEqualToString:@"32"])
        {
            [self FontSize32];
        }
        if ([buttonTitle isEqualToString:@"Cancel"])
        {
            NSLog(@"Button Cancelled compadre");
            
        }
    }
    
    
    // Action sheet for paragraph alignment style
    
    if(actionSheet == paragraphTypeActionSheet)
    {
        
        NSString *buttonTitle =  [actionSheet buttonTitleAtIndex:buttonIndex];
        
        if ([buttonTitle isEqualToString:@"Destruction"])
        {
            NSLog(@"Symphony of Destruction");
            
        }
        
        if ([buttonTitle isEqualToString:@"Center"])
        {
            [self CenterAlignment];
            
        }
        
        if ([buttonTitle isEqualToString:@"Left"])
        {
            [self LeftAlignment];
        }
        
        if ([buttonTitle isEqualToString:@"Right"])
        {
            [self RightAlignment];
        }
        
        if ([buttonTitle isEqualToString:@"Justified"])
        {
            [self JustifiedAlignment];
        }
        if ([buttonTitle isEqualToString:@"Natural"])
        {
            [self NaturalAlignment];
        }
        if ([buttonTitle isEqualToString:@"Cancel"])
        {
            NSLog(@"Button Cancelled compadre");
            
        }
    }
    
    // Action sheet for font color
    
    if(actionSheet == fontColorActionSheet)
    {
        
        NSString *buttonTitle =  [actionSheet buttonTitleAtIndex:buttonIndex];
        
        if ([buttonTitle isEqualToString:@"Destruction"])
        {
            NSLog(@"Symphony of Destruction");
            
        }
        
        if ([buttonTitle isEqualToString:@"Red"])
        {
            [self FontRed];
            
        }
        
        if ([buttonTitle isEqualToString:@"Green"])
        {
            [self FontGreen];
        }
        
        if ([buttonTitle isEqualToString:@"Blue"])
        {
            [self FontBlue];
        }
        
        if ([buttonTitle isEqualToString:@"Orange"])
        {
            [self FontOrange];
        }
        if ([buttonTitle isEqualToString:@"Yellow"])
        {
            [self FontYellow];
        }
        if ([buttonTitle isEqualToString:@"Cancel"])
        {
            NSLog(@"Button Cancelled compadre");
            
        }
    }
    
    
    
    
    
    
}


// Implementing different font family
-(void)Courier
{
    NSRange range = [myTextView selectedRange];
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    UIFont *font_Type = [UIFont fontWithName:@"Courier" size:14];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_Type
                             range:NSMakeRange(startIndex, selectedTextLength)];
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    [self.myTextView setAttributedText:attributedString];
    
}

-(void)Verdana
{
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    UIFont *font_Type = [UIFont fontWithName:@"Verdana" size:14];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_Type
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
}
-(void)Georgia
{
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    UIFont *font_Type = [UIFont fontWithName:@"Georgia" size:14];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_Type
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
}



// Method to implement different font size

-(void)FontSize10
{
    NSRange range = [myTextView selectedRange];
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    UIFont *font_Type = [UIFont fontWithName:myTextView.font.familyName size:10];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_Type
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    [self.myTextView setAttributedText:attributedString];
    
    
}

-(void)FontSize12
{
    NSRange range = [myTextView selectedRange];
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    UIFont *font_Type = [UIFont fontWithName:myTextView.font.familyName size:12];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_Type
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    [self.myTextView setAttributedText:attributedString];
    
}
-(void)FontSize14
{
    NSRange range = [myTextView selectedRange];
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    UIFont *font_Type = [UIFont fontWithName:myTextView.font.familyName size:14];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_Type
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    [self.myTextView setAttributedText:attributedString];
    
}
-(void)FontSize16
{
    NSRange range = [myTextView selectedRange];
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    UIFont *font_Type = [UIFont fontWithName:myTextView.font.familyName size:16];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_Type
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    [self.myTextView setAttributedText:attributedString];
    
    
}

-(void)FontSize18
{
    NSRange range = [myTextView selectedRange];
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    UIFont *font_Type = [UIFont fontWithName:myTextView.font.familyName size:18];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_Type
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    [self.myTextView setAttributedText:attributedString];
    
}
-(void)FontSize20
{
    NSRange range = [myTextView selectedRange];
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    UIFont *font_Type = [UIFont fontWithName:myTextView.font.familyName size:20];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_Type
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    [self.myTextView setAttributedText:attributedString];
    
    
}
-(void)FontSize32
{
    NSRange range = [myTextView selectedRange];
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    UIFont *font_Type = [UIFont fontWithName:myTextView.font.familyName size:32];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_Type
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    [self.myTextView setAttributedText:attributedString];
    
    
}

// Implemented methods for different paragraph alignment style
-(void)CenterAlignment
{
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
    [self.myTextView setFont:font_regular];
    
    
    
}

-(void)LeftAlignment
{
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setAlignment:NSTextAlignmentLeft];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
    [self.myTextView setFont:font_regular];
}


-(void)RightAlignment
{
    
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setAlignment:NSTextAlignmentRight];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
    [self.myTextView setFont:font_regular];
    
    
}

-(void)JustifiedAlignment
{
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setAlignment:NSTextAlignmentJustified];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
    [self.myTextView setFont:font_regular];
    
    
}
-(void)NaturalAlignment
{
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setAlignment:NSTextAlignmentNatural];
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
    [self.myTextView setFont:font_regular];
    
    
}


// Different font color types

-(void)FontRed
{
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor redColor]
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
    [self.myTextView setFont:font_regular];
    
    
    
}

-(void)FontBlue
{
    
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor blueColor]
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
    [self.myTextView setFont:font_regular];
    
    
}

-(void)FontGreen
{
    
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor greenColor]
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
    [self.myTextView setFont:font_regular];
    
    
}

-(void)FontOrange
{
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor orangeColor]
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
    [self.myTextView setFont:font_regular];
    
    
    
}


-(void)FontYellow
{
    
    
    NSRange range = [myTextView selectedRange];
    
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    
    
    NSLog(@"%lu",(unsigned long)range.location-1);
    
    if(range.location>0)
    {
        [attributedString addAttribute:NSFontAttributeName
                                 value:font_regular
                                 range:NSMakeRange(0, range.location-1)];
    }
    
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor yellowColor]
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    
    NSInteger startIndexOfRestText =range.location+selectedTextLength;
    NSInteger lengthOfRestText = str.length-(range.location+selectedTextLength);
    NSLog(@"%lu, %lu",(long)startIndexOfRestText, (long)lengthOfRestText);
    [attributedString addAttribute:NSFontAttributeName
                             value:font_regular
                             range:NSMakeRange(startIndexOfRestText, lengthOfRestText)];
    
    
    [self.myTextView setAttributedText:attributedString];
    [self.myTextView setFont:font_regular];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
