//
//  GWQuestionnaireItem.m
//
//  Created by Grzegorz Wójcik on 07.03.2014.
//
//

#import "GWQuestionnaireItem.h"

@implementation GWQuestionnaireItem
-(id)initWithQuestion:(NSString*)question answers:(NSArray*)answers type:(GWQuestionnaireItemType)type
{
    self = [super init];
    if (self) {
        [self setQuestion:question];
        [self setAnswers:answers];
        [self setType:type];
    }
    return self;
}

-(void)dealloc
{
    self.question = nil;
    self.answers = nil;
    self.userAnswer = nil;
}
@end
