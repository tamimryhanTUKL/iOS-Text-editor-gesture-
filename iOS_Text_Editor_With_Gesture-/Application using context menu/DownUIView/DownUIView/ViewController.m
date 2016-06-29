//
//  ViewController.m
//  DownUIView
//
//  Created by Tamim Ryhan on 21/10/15.
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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    

}


# pragma mark - recognize the gesture

- (void)actionButton:(id)sender
{
    
    
    
    [dollarPGestureRecognizer recognize];
    [gestureView clearAll];
    recognized = !recognized;
    
}






# pragma mark - other methods

- (void)gestureRecognized:(DollarPGestureRecognizer *)sender


{
    
    DollarResult *result = [sender result];
    
    NSLog(@"Gesture name=%@",[result name]);
    
    
    if ([[result name] isEqualToString:@"S"])
    {
        
        NSLog(@"S for Suffocation");
        [self SelectAllText:sender];
       
        
    }
    if ([[result name] isEqualToString:@"F"])
    {
        
        NSLog(@"F is Fallujah");
        [self PasteText:sender];
        
    }
    
    if ([[result name] isEqualToString:@"G"])
    {
        NSLog(@"G is Golden kobra ");
    }
    if ([[result name] isEqualToString:@"C"])
    {
        
        NSLog(@"C is Identified !!!");
        [self CopyText:sender];
    }
    if ([[result name] isEqualToString:@"Flash"])
    {
        
    }
    if ([[result name] isEqualToString:@"Camera"])
    {
        
    }
}

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
    
    
    [self.myTextView setAttributedText:attributedString];
    
}

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
-(void)FontTypeText:(id)sender
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
