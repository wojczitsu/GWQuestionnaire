//
//  GWQuestionnaireItem.h
//
//  Created by Grzegorz Wójcik on 07.03.2014.
//
//

#import <Foundation/Foundation.h>

typedef enum {
	GWQuestionnaireSingleChoice,
	GWQuestionnaireMultipleChoice,
	GWQuestionnaireOpenQuestion,
	GWQuestionnaireRateQuestion,
} GWQuestionnaireItemType;

@interface GWQuestionnaireItem : NSObject
// Question text
@property (nonatomic, strong) NSString *question;
// Possible choices 
@property (nonatomic, strong) NSArray *answers;
// Open answer text
@property (nonatomic, strong) NSString *userAnswer;

@property (assign) GWQuestionnaireItemType type;

-(id)initWithQuestion:(NSString*)question answers:(NSArray*)answers type:(GWQuestionnaireItemType)type;
@end
