//
//  GraphView.h
//  FitnessApp
//
//  Created by Puneet Sharma on 13/04/13.
//  Copyright (c) 2013 Puneet Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct  {
    BOOL hadOrange;
    BOOL hadWheat;
    BOOL hadCarrot;
    BOOL hadFish;
    BOOL hadMilk;
    BOOL hadLiquor;
}FoodStructureType[10];

@interface GraphView : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *datesArray;
    NSMutableArray *glsssesIntakeArray;
    NSMutableArray *foodIntakeArray;
    
    UILabel *lblCups;
    UILabel *lblIntakeCups;
    UITableView *graphTable;    
}

@end
