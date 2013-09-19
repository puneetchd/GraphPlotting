//
//  GraphConstants.h
//  FitnessApp
//
//  Created by Puneet Sharma on 13/04/13.
//  Copyright (c) 2013 Puneet Sharma. All rights reserved.
//

#ifndef FitnessApp_GraphConstants_h
#define FitnessApp_GraphConstants_h

#endif

#define Graph_MaxBarHeight                               ((IS_HEIGHT_GTE_568)?178.0f:133)
#define Graph_MaxGlassesIntake                           12
#define Graph_MaxMinutes                                 1440

#define Graph_Horizontal_Strip_Rect                      CGRectMake((IS_HEIGHT_GTE_568)?210:170, 0, 44, 36)
#define Graph_Vertical_Strip_Rect                        CGRectMake(142,0,34,(IS_HEIGHT_GTE_568)?520:380) 
#define Graph_Strip_Bg_Color                             [UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:1]
#define Graph_Date_Label_Rect                            CGRectMake((IS_HEIGHT_GTE_568)?212:173, 2, 40,30)
#define Graph_Date_Label_Center_Rect                     CGRectMake((IS_HEIGHT_GTE_568)?210:170, 0, 44,34)
#define Graph_Date_Label_Text_Color                      [UIColor colorWithRed:52/255.0f green:60/255.0f blue:64/255.0f alpha:.8]
#define Graph_Strip_Tag                                  2015