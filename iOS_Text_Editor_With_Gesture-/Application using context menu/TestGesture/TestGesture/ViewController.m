//
//  ViewController.m
//  TestGesture
//
//  Created by Tamim Ryhan on 09/07/15.
//  Copyright (c) 2015 Tamim Ryhan. All rights reserved.
//
#import "ViewController.h"
#import "DollarDefaultGestures.h"
#import "DollarResult.h"
#import "DollarPGestureRecognizer.h"
#import "GestureView.h"
#import "GHContextMenuView.h"

@interface ViewController ()<GHContextOverlayViewDataSource,GHContextOverlayViewDelegate>

@end

@implementation ViewController
@synthesize myGestureView;
@synthesize myTextView;
@synthesize fontTypeActionSheet;
@synthesize fontSizeActionSheet;
@synthesize paragraphTypeActionSheet;
@synthesize fontColorActionSheet;



//NSTimer *myTimer;
//bool recognized;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"From viewDidLoad method");
    
    
    
    /*
    dollarPGestureRecognizer = [[DollarPGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(gestureRecognized:)];
    [dollarPGestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
    [dollarPGestureRecognizer setDelaysTouchesEnded:NO];
    
    [gestureView addGestureRecognizer:dollarPGestureRecognizer];
    gestureView.userInteractionEnabled = YES;
   
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recognizeGesture:)
                                                 name:@"GestureNotification"
                                               object:nil];
    */
    
    // Setting up textViewDelegate
     self.myTextView.delegate = self;
     
  
    // Adding Context Menu to view
    GHContextMenuView *overlay = [[GHContextMenuView alloc]init];
    overlay.delegate = self;
    overlay.dataSource = self;
    
    UILongPressGestureRecognizer *longPressRecognizer =  [[UILongPressGestureRecognizer alloc]initWithTarget:overlay action:@selector(longPressDetected:)];
    self.myTextView.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:longPressRecognizer];

    

    }


# pragma mark- Implementing context menu


// Number of context menu item defined in menu

- (NSInteger) numberOfMenuItems
{
    return 12;
}

-(UIImage*) imageForItemAtIndex:(NSInteger)index
{
    NSString* imageName = nil;
    switch (index) {
        case 0:
            imageName = @"FontColor_Icon";
            break;
        case 1:
            imageName = @"FontType_Icon";
            break;
        case 2:
            imageName = @"HighlightText_Icon";
            break;
        case 3:
            imageName = @"ParagraphAlignment_Icon";
            break;
        case 4:
            imageName = @"Shadow_Icon";
            break;
        case 5:
            imageName = @"Strikethrough_Icon";
            break;
        case 6:
            imageName = @"UnderLine_Icon";
            break;
        case 7:
            imageName = @"Undo_Icon";
            break;
        case 8:
            imageName = @"Redo_Icon";
            break;
        case 9:
            imageName = @"ItalicFont_Icon";
            break;
            case 10:
            imageName = @"Fontsize_Icon";
            break;
            case 11:
            imageName = @"Deletetext_Icon";
            break;
            
        default:
            break;
    }
    return [UIImage imageNamed:imageName];
}


-(void)didSelectItemAtIndex:(NSInteger)selectedIndex forMenuAtPoint:(CGPoint)point
{
    
    switch (selectedIndex) {
        case 0:
            [self FontColorText];
            break;
            
        case 1:
            [self FontTypeText];
            break;
        case  2:
            [self HighlightText];
            break;
        case 3:
            [self ParagraphAlignment];
            break;
        case 4:
            [self ShadowText];
            break;
        case 5:
            [self StrikethroughText];
            break;
        case 6:
            [self UnderlineText];
            break;
            case 7:
            [self UndoText];
            break;
            case 8:
            [self RedoText];
            break;
            case 9:
            [self ItalicText];
            case 10:
            [self FontSizeText];
            break;
            case 11:
            [self DeleteText];
            break;
            
        default:
            break;
    }
}





# pragma mark - UITextViewDelegate method to dismiss keyboard 

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}




/*

# pragma mark - recognize the gesture

-(void)recognizeGesture:(DollarPGestureRecognizer*)sender
{

    if (recognized)
    {
        [gestureView clearAll];
        
    }
    
    else
        
    {
        [dollarPGestureRecognizer recognize];
    }
    
    recognized = !recognized;
    
    
    [gestureView setUserInteractionEnabled:!recognized];
    

    

}

*/
 
/*

# pragma mark - other methods


 
- (void)gestureRecognized:(DollarPGestureRecognizer *)sender
{
    NSLog(@"Just entered gestureRecognized Method !!!");
    
    DollarResult *result = [sender result];
    //    [resultLabel setText:[NSString stringWithFormat:@"Result: %@ (Score: %.2f)",
    //                          [result name], [result score]]];
    NSLog(@"Gesture name=%@",[result name]);
    //  NSLog(@"Description0%@",[dollarPGestureRecognizer points]);
    
    if ([[result name] isEqualToString:@"S"]) {
        NSLog(@"S for Suffocation");
        
        [self PasteText:sender];
    }
    if ([[result name] isEqualToString:@"F"]) {
        [self CopyText];
        
        
    
    }
    if ([[result name] isEqualToString:@"G"]) {
       
    }
    if ([[result name] isEqualToString:@"C"]) {
        
        NSLog(@"C is Identified");
        [self SelectAllText];
    }
}

 */

-(void)SelectAllText
{[self.myTextView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1f];
    [self.myTextView selectAll:self];
    [[UIApplication sharedApplication] sendAction:@selector(selectAll:) to:nil from:self forEvent:nil];

}

-(void)CopyText
{
    
    [self.myTextView select:self];
    self.myTextView.selectedRange = NSMakeRange(0, [self.myTextView.text length]);
    [[UIApplication sharedApplication] sendAction:@selector(copy:) to:nil from:self forEvent:nil];
    [self.myTextView resignFirstResponder];
    
    
    


}

-(void)PasteText

{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    self.myTextView.text = [pb string];
    [[UIApplication sharedApplication] sendAction:@selector(paste:) to:nil from:self forEvent:nil];
    
}

// Cut Text
-(void)CutText
{
    [self.myTextView select:self];
    self.myTextView.selectedRange = NSMakeRange(0, [self.myTextView.text length]);
    [[UIApplication sharedApplication] sendAction:@selector(cut:) to:nil from:self forEvent:nil];
    [self.myTextView resignFirstResponder];
    self.myTextView.text= @"";
    
}

// Delete Selected Text
-(void)DeleteText
{
    [self.myTextView select:self];
    NSRange range = [myTextView selectedRange];
    myTextView.text = [myTextView.text stringByReplacingCharactersInRange:range withString:@""];
   // [[UIApplication sharedApplication] sendAction:@selector(DeleteText) to:nil from:self forEvent:nil];
    
}

// Undo Action
-(void)UndoText
{
    NSUndoManager *myUndoManager =  [self.myTextView undoManager];
    [myUndoManager undo];

   [[UIApplication sharedApplication] sendAction:@selector(undo) to:nil from:self forEvent:nil];
    
}

//  Redo Action
-(void)RedoText
{
    NSUndoManager *myRedoManager = [self.myTextView undoManager];
    [myRedoManager redo];
    
   [[UIApplication sharedApplication] sendAction:@selector(redo) to:nil from:self forEvent:nil];
}

// Bold Text
-(void)BoldText
{
    NSRange range = [myTextView selectedRange];
    
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
    
  //  [[UIApplication sharedApplication] sendAction:@selector(BoldText) to:nil from:self forEvent:nil];
    
}

// Make Italic Text
-(void)ItalicText
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
    
    //[[UIApplication sharedApplication] sendAction:@selector(ItalicText) to:nil from:self forEvent:nil];
    
}


// Shadow on text

-(void)ShadowText
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
    
    
  //  [[UIApplication sharedApplication] sendAction:@selector(ShadowText) to:nil from:self forEvent:nil];


}

// Strikethrough Text
-(void)StrikethroughText
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
    
   // [[UIApplication sharedApplication] sendAction:@selector(StrikethroughText) to:nil from:self forEvent:nil];

}




// Underline selected text
-(void)UnderlineText
{
    NSRange range = [myTextView selectedRange];
    NSInteger selectedTextLength = [myTextView.text substringWithRange:range].length;
    NSString *str = myTextView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    
    UIFont *font_regular = [UIFont fontWithName:myTextView.font.familyName
                                           size: myTextView.font.pointSize];
    
    if(range.location>0)
    {
        //[attributedString addAttribute:NSFontAttributeName
        //value:font_regular
        //range:NSMakeRange(0, range.location-1)];
    }
    
    NSInteger startIndex =range.location;
    NSLog(@"%lu, %lu", (long)startIndex, (long)selectedTextLength);
    [attributedString addAttribute: NSUnderlineStyleAttributeName
                             value:[NSNumber numberWithInt:NSUnderlineStyleSingle]
                             range:NSMakeRange(startIndex, selectedTextLength)];
    
    [self.myTextView setAttributedText:attributedString];
    [myTextView setFont: font_regular];
    
    
  //  [[UIApplication sharedApplication] sendAction:@selector(UnderlineText) to:nil from:self forEvent:nil];
    
}

// Highlight text
-(void)HighlightText
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
    
   // [[UIApplication sharedApplication] sendAction:@selector(HighlightText) to:nil from:self forEvent:nil];
    
}

// Change Font type
-(void)FontTypeText
{
    [self showFontTypeActionSheet];
    //[[UIApplication sharedApplication] sendAction:@selector(FontTypeText) to:nil from:self forEvent:nil];
}

-(void)FontSizeText
{
    [self ShowFontSizeActionSheet];
    //[[UIApplication sharedApplication] sendAction:@selector(FontSizeText) to:nil from:self forEvent:nil];
}
-(void)FontColorText
{
    [self ShowFontColorActionSheet];
   // [[UIApplication sharedApplication] sendAction:@selector(FontColorText) to:nil from:self forEvent:nil];
}


// ActionSheet method for Showing different Font type
-(void)showFontTypeActionSheet
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

// change font color

-(void)ShowFontColorActionSheet
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



// Action sheet method for showing different font size
-(void)ShowFontSizeActionSheet
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


//
-(void)ParagraphAlignment
{
    [self showParagraphTypeActionSheet];
   // [[UIApplication sharedApplication] sendAction:@selector(ParagraphAlignment) to:nil from:self forEvent:nil];

}


-(void)showParagraphTypeActionSheet
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
