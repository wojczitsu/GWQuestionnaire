//
//  GWQuestionnaireCellTextField.m
//
//  Created by Grzegorz Wójcik on 10.03.2014.
//
//

#import "GWQuestionnaireCellTextField.h"
@interface GWQuestionnaireCellTextField ()
{
    GWQuestionnaire *owner;
    int row;
}
@end
@implementation GWQuestionnaireCellTextField

-(void)setContent:(GWQuestionnaireItem*)item row:(int)r
{
    row = r;
    [self.textField setText:item.userAnswer];
    [self setDefaultText];
}
-(void)setDefaultText
{
    if(!_textField.text || [_textField.text length] == 0)
    {
        _textField.text = NSLocalizedString(@"Your answer...",nil);
    }
}
-(void)setOwner:(GWQuestionnaire*)val
{
    owner = val;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
}
#pragma mark UITextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [owner performSelector:@selector(surveyCellUserAnswerChanged:atIndex:) withObject:self.textField.text withObject:[NSNumber numberWithInt:row]];
    [self setDefaultText];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([_textField.text isEqualToString:NSLocalizedString(@"Your answer...",nil)])
        _textField.text = @"";
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    return YES;
}

@end
