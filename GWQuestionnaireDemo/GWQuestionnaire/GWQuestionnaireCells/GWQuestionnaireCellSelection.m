//
//  GWQuestionnaireCellSelection.m
//
//  Created by Grzegorz Wójcik on 07.03.2014.
//
//

#import "GWQuestionnaireCellSelection.h"

#define OPTION_H 44

@interface GWQuestionnaireCellSelection ()
{
    float actualY;
    NSMutableArray *answers;
    GWQuestionnaire *owner;
    int row;
    GWQuestionnaireItemType typeOfItem;
}
@end
@implementation GWQuestionnaireCellSelection
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.container.layer setCornerRadius:8.0];
    [self.container.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.container.layer setBorderWidth:1.0];
}

-(void)setOwner:(GWQuestionnaire*)val
{
    owner = val;
}
-(void)setContent:(GWQuestionnaireItem*)item row:(int)r
{
    row = r;
    typeOfItem = item.type;
    answers = [NSMutableArray arrayWithArray:item.answers];
    [[self.container subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    actualY = 0;
    for(int i=0; i < [item.answers count]; i++)
    {
        NSDictionary *option = [item.answers objectAtIndex:i];
        UIView *subview = [self createOptionView:option index:i];
        [subview setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin |
              UIViewAutoresizingFlexibleLeftMargin];
        [self.container addSubview:subview];
    }
    CGRect f = self.container.frame;
    f.size.height = actualY;
    self.container.frame = f;
}
-(UIView*)createOptionView:(NSDictionary*)dict index:(int)index
{
    index += 1;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,actualY,_container.frame.size.width,OPTION_H)];
    [v setBackgroundColor:[UIColor clearColor]];
    int labelX = 80;
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(labelX,0,v.frame.size.width-labelX,OPTION_H)];
    [lbl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [lbl setAdjustsFontSizeToFitWidth:YES];
    [lbl setMinimumScaleFactor:8./15.];
    [lbl setFont:[UIFont systemFontOfSize:15.0]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setText:[dict objectForKey:@"text"]];
    [v addSubview:lbl];
    [v setTag:index];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 41, 41)];
    [img setTag:index];
    if(![[dict objectForKey:@"marked"] boolValue])
        [img setImage:[UIImage imageNamed:@"unchecked"]];
    else
        [img setImage:[UIImage imageNamed:@"checked"]];
    [v addSubview:img];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = index;
    [btn addTarget:self action:@selector(checboxPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0,0,v.frame.size.width, v.frame.size.height);
    [btn setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin |
     UIViewAutoresizingFlexibleLeftMargin];
    [v addSubview:btn];
    
    actualY += OPTION_H;
    return v;
}

-(void)checboxPressed:(id)sender
{
    UIView *cont = [self.container viewWithTag:[sender tag]];
    UIImageView *image = nil;
    for(UIView *subview in cont.subviews)
    {
        if([subview isKindOfClass:[UIImageView class]])
        {
            image = (UIImageView*)subview;
            break;
        }
    }
    
    if([[[answers objectAtIndex:[sender tag]-1] objectForKey:@"marked"] boolValue])
    {
        [image setImage:[UIImage imageNamed:@"unchecked"]];
        NSDictionary *old = [answers objectAtIndex:[sender tag]-1];
        NSDictionary *newD = [NSDictionary dictionaryWithObjectsAndKeys:[old objectForKey:@"text"],@"text",[NSNumber numberWithBool:NO],@"marked", nil];
        [answers replaceObjectAtIndex:[sender tag]-1 withObject:newD];
    }
    else
    {
        if(typeOfItem == GWQuestionnaireSingleChoice)
        {
            for(UIView *containerSubview in self.container.subviews)
            {
                for(UIView *subview in containerSubview.subviews)
                {
                    if([subview isKindOfClass:[UIImageView class]])
                    {
                        UIImageView *btn = (UIImageView*)subview;
                        [btn setImage:[UIImage imageNamed:@"unchecked"]];
                        NSDictionary *old = [answers objectAtIndex:[btn tag]-1];
                        NSDictionary *newD = [NSDictionary dictionaryWithObjectsAndKeys:[old objectForKey:@"text"],@"text",[NSNumber numberWithBool:NO],@"marked", nil];
                        [answers replaceObjectAtIndex:[btn tag]-1 withObject:newD];
                    }
                }
            }
        }

        [image setImage:[UIImage imageNamed:@"checked"]];
        NSDictionary *old = [answers objectAtIndex:[sender tag]-1];
        NSDictionary *newD = [NSDictionary dictionaryWithObjectsAndKeys:[old objectForKey:@"text"],@"text",[NSNumber numberWithBool:YES],@"marked", nil];
        [answers replaceObjectAtIndex:[sender tag]-1 withObject:newD];
    }
    [owner performSelector:@selector(surveyCellSelectionChanged:atIndex:) withObject:answers withObject:[NSNumber numberWithInt:row]];
}
@end
