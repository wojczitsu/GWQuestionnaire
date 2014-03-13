//
//  GWQuestionnaireCellSelection.h
//
//  Created by Grzegorz Wójcik on 07.03.2014.
//
//

#import <UIKit/UIKit.h>
#import "GWQuestionnaireItem.h"
#import "GWQuestionnaire.h"
@interface GWQuestionnaireCellSelection : UITableViewCell
@property (nonatomic, weak) IBOutlet UIView *container;

-(void)setContent:(GWQuestionnaireItem*)item row:(int)r;
-(void)setOwner:(GWQuestionnaire*)val;
@end
