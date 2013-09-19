//
//  GraphAndGoalsController.h
//  GraphPlotting
//
//  Created by Puneet Sharma on 14/04/13.
//  Copyright (c) 2013 Puneet Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphAndGoalsController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *datesArray;
    NSMutableArray *glsssesIntakeArray;
    NSMutableArray *goalsArray;
    
    UILabel *lblCups;
    UILabel *lblIntakeCups;
    UITableView *graphTable;
    
    UILabel *lblGoals;
    UILabel *lblCompletedGoals;
}

@end
