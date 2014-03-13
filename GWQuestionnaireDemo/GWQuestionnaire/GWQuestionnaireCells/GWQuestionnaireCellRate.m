//
//  GWQuestionnaireCellRate.m
//
//  Created by Grzegorz Wójcik on 10.03.2014.
//
//

#import "GWQuestionnaireCellRate.h"
@interface GWQuestionnaireCellRate ()
{
    NSMutableArray *answers;
    GWQuestionnaire *owner;
    int row;
    int itemWidth;
}
@end

@implementation GWQuestionnaireCellRate
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.container.layer setCornerRadius:8.0];
    [self.container.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.container.layer setBorderWidth:1.0];
}

-(void)setContent:(GWQuestionnaireItem*)item row:(int)r parentWidth:(int)width
{
    width -= 40;
    row = r;
    answers = [NSMutableArray arrayWithArray:item.answers];
    [self.container.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    itemWidth = width / item.answers.count;
    
    for(int i=0; i < [item.answers count]; i++)
    {
        NSDictionary *option = [item.answers objectAtIndex:i];
        UIView *subview = [self createOptionView:option index:i];
        [self.container addSubview:subview];
    }
}
-(void)setOwner:(GWQuestionnaire*)val
{
    owner = val;
}
-(UIView*)createOptionView:(NSDictionary*)dict index:(int)index
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(index * itemWidth, 0, itemWidth,self.frame.size.height)];
    [v setBackgroundColor:[UIColor clearColor]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = index;
    [btn addTarget:self action:@selector(checboxPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    if(![[dict objectForKey:@"marked"] boolValue])
        [btn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    else
        [btn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    int btnH = 41;
    int btnW = 41;
    btn.frame = CGRectMake((v.frame.size.width - btnW)/2, 5, btnW, btnH);
    [v addSubview:btn];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, btn.frame.origin.y + btn.frame.size.height,
                                                             v.frame.size.width, v.frame.size.height - (btn.frame.origin.y + btn.frame.size.height))];
    [lbl setNumberOfLines:0];
    [lbl setFont:[UIFont systemFontOfSize:15.0]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setText:[dict objectForKey:@"text"]];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [v addSubview:lbl];
    return v;
}

-(void)checboxPressed:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if([[[answers objectAtIndex:[btn tag]] objectForKey:@"marked"] boolValue])
    {
        [btn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        NSDictionary *old = [answers objectAtIndex:[btn tag]];
        NSDictionary *newD = [NSDictionary dictionaryWithObjectsAndKeys:[old objectForKey:@"text"],@"text",[NSNumber numberWithBool:NO],@"marked", nil];
        [answers replaceObjectAtIndex:[btn tag] withObject:newD];
    }
    else
    {
        for(UIView *containerSubview in self.container.subviews)
        {
            for(UIView *subview in containerSubview.subviews)
            {
                if([subview isKindOfClass:[UIButton class]])
                {
                    UIButton *btn = (UIButton*)subview;
                    [btn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
                    NSDictionary *old = [answers objectAtIndex:[btn tag]];
                    NSDictionary *newD = [NSDictionary dictionaryWithObjectsAndKeys:[old objectForKey:@"text"],@"text",[NSNumber numberWithBool:NO],@"marked", nil];
                    [answers replaceObjectAtIndex:[btn tag] withObject:newD];
                }
            }
        }
        
        [btn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
        NSDictionary *old = [answers objectAtIndex:[btn tag]];
        NSDictionary *newD = [NSDictionary dictionaryWithObjectsAndKeys:[old objectForKey:@"text"],@"text",[NSNumber numberWithBool:YES],@"marked", nil];
        [answers replaceObjectAtIndex:[btn tag] withObject:newD];
    }
    [owner performSelector:@selector(surveyCellSelectionChanged:atIndex:) withObject:answers withObject:[NSNumber numberWithInt:row]];
}


@end
