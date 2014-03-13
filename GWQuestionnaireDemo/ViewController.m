//
//  ViewController.m
//  GWQuestionnaireDemo
//
//  Created by Grzegorz Wójcik on 10.03.2014.
//  Copyright (c) 2014 Wojczitsu. All rights reserved.
//

#import "ViewController.h"
#import "GWQuestionnaire.h"
@interface ViewController ()
{
    GWQuestionnaire *surveyController;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    // add survey / questionnaire
    [self addSurvey];
}

-(void)addSurvey
{
    NSMutableArray *questions = [NSMutableArray array];
    
    NSDictionary *a1 = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"text",[NSNumber numberWithBool:NO],@"marked", nil];
    NSDictionary *a2 = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"text",[NSNumber numberWithBool:NO],@"marked", nil];
    
    NSDictionary *a3 = [NSDictionary dictionaryWithObjectsAndKeys:@"A",@"text",[NSNumber numberWithBool:NO],@"marked", nil];
    NSDictionary *a4 = [NSDictionary dictionaryWithObjectsAndKeys:@"B",@"text",[NSNumber numberWithBool:NO],@"marked", nil];
    NSDictionary *a5 = [NSDictionary dictionaryWithObjectsAndKeys:@"C",@"text",[NSNumber numberWithBool:NO],@"marked", nil];
    
    NSDictionary *a6 = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"text",[NSNumber numberWithBool:NO],@"marked", nil];
    NSDictionary *a7 = [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"text",[NSNumber numberWithBool:NO],@"marked", nil];
    NSDictionary *a8 = [NSDictionary dictionaryWithObjectsAndKeys:@"3",@"text",[NSNumber numberWithBool:NO],@"marked", nil];
    NSDictionary *a9 = [NSDictionary dictionaryWithObjectsAndKeys:@"4",@"text",[NSNumber numberWithBool:NO],@"marked", nil];
    
    
    // single choice question
    GWQuestionnaireItem *item = [[GWQuestionnaireItem alloc] initWithQuestion:@"Single choice question ?"
                                                        answers:[NSArray arrayWithObjects:a1,a2, nil]
                                                           type:GWQuestionnaireSingleChoice];
    [questions addObject:item];
    
    // multiple choice question
    item = [[GWQuestionnaireItem alloc] initWithQuestion:@"Multiple choice question ?"
                                          answers:[NSArray arrayWithObjects:a3,a4,a5, nil]
                                             type:GWQuestionnaireMultipleChoice];
    [questions addObject:item];
    
    // "Rate" question
    item = [[GWQuestionnaireItem alloc] initWithQuestion:@"Rate it:"
                                          answers:[NSArray arrayWithObjects:a6,a7,a8,a9, nil]
                                             type:GWQuestionnaireRateQuestion];
    [questions addObject:item];
    
    // "open" question
    item = [[GWQuestionnaireItem alloc] initWithQuestion:@"Type your answer:"
                                          answers:nil
                                             type:GWQuestionnaireOpenQuestion];
    [questions addObject:item];
    
    surveyController = [[GWQuestionnaire alloc] initWithItems:questions];
    surveyController.view.frame = CGRectMake(0,20,self.view.frame.size.width,self.view.frame.size.height-20);
    [self.view addSubview:surveyController.view];
    
    
    // add button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:NSLocalizedString(@"Get answers!", nil) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getAnswersPressed:) forControlEvents:UIControlEventTouchUpInside];
    int btnW = 150;
    int btnX = (self.view.frame.size.width - btnW)/2;
    [btn setFrame:CGRectMake(btnX, self.view.frame.size.height - 40, btnW, 40)];
    [self.view addSubview:btn];
}


-(void)getAnswersPressed:(id)sender
{
    if(![surveyController isCompleted])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Questionnaire not completed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // NSLog answers
    for(GWQuestionnaireItem *item in surveyController.surveyItems)
    {
        NSLog(@"-----------------");
        NSLog(@"%@",item.question);
        NSLog(@"-----------------");
        if(item.type == GWQuestionnaireOpenQuestion)
            NSLog(@"Answer: %@", item.userAnswer);
        else
            for(NSDictionary *dict in item.answers)
            {
                NSLog(@"%d - %@",[[dict objectForKey:@"marked"]boolValue], [dict objectForKey:@"text"]);
            }
    }
}


@end
