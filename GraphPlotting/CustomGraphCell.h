//
//  CustomGraphCell.h
//  FitnessApp
//
//  Created by Puneet Sharma on 13/04/13.
//  Copyright (c) 2013 Puneet Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataFood.h"
#import "DataGoalHours.h"

typedef struct  {
    BOOL hadOrange;
    BOOL hadWheat;
    BOOL hadCarrot;
    BOOL hadFish;
    BOOL hadMilk;
    BOOL hadLiquor;
}FoodStructureTypeStruct[10];

@interface CustomGraphCell : UITableViewCell
{
    FoodStructureTypeStruct *foodData;
    UILabel *dateLabel;
    UIView *grayStripHorizontal;
}

-(void)setWaterAndGoalsStatsData:(DataGoalHours*)goalsObject :(NSUInteger )numberOfGlasses :(NSIndexPath*)atIndexPath :(NSString*)dateStringValue;

-(void)setWaterAndFoodStatsData:(DataFood*)foodObject :(NSUInteger )numberOfGlasses :(NSIndexPath*)atIndexPath :(NSString*)dateStringValue;

@end
