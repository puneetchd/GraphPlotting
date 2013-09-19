//
//  DataFood.h
//  GraphPlotting
//
//  Created by Puneet Sharma on 14/04/13.
//  Copyright (c) 2013 Puneet Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataFood : NSObject
{
    BOOL hadOrange;
    BOOL hadWheat;
    BOOL hadCarrot;
    BOOL hadFish;
    BOOL hadMilk;
    BOOL hadLiquor;
}

@property(assign) BOOL hadOrange;
@property(assign) BOOL hadWheat;
@property(assign) BOOL hadCarrot;
@property(assign) BOOL hadFish;
@property(assign) BOOL hadMilk;
@property(assign) BOOL hadLiquor;

@end
