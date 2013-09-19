//
//  CustomGraphCell.m
//  FitnessApp
//
//  Created by Puneet Sharma on 13/04/13.
//  Copyright (c) 2013 Puneet Sharma. All rights reserved.
//

#import "CustomGraphCell.h"
#import "GraphConstants.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomGraphCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        grayStripHorizontal = [[UIView alloc]initWithFrame:Graph_Horizontal_Strip_Rect];
        grayStripHorizontal.backgroundColor = Graph_Strip_Bg_Color;
        [self addSubview:grayStripHorizontal];
        [grayStripHorizontal release];
        
        dateLabel = [[UILabel alloc]initWithFrame:Graph_Date_Label_Rect];
        dateLabel.font = [UIFont boldSystemFontOfSize:12];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.numberOfLines = 2;
        dateLabel.textColor = Graph_Date_Label_Text_Color;
        [self addSubview:dateLabel];
        
        CGRect frame = dateLabel.frame;
        dateLabel.transform = CGAffineTransformRotate(dateLabel.transform, M_PI / 2);
        dateLabel.frame = frame;
        
    }
    return self;
}

-(void)setWaterAndGoalsStatsData:(DataGoalHours*)goalsObject :(NSUInteger )numberOfGlasses :(NSIndexPath*)atIndexPath :(NSString*)dateStringValue
{
    // Bar Creation based on Glasses intake of water.
    
    UIFont *bigFont = [UIFont boldSystemFontOfSize:16];
    NSDictionary *bigFontdict = [NSDictionary dictionaryWithObject: bigFont forKey:NSFontAttributeName];
    NSMutableAttributedString *dateString = [[NSMutableAttributedString alloc] initWithString:[dateStringValue substringToIndex:2] attributes: bigFontdict];
    
    UIFont *smallFont = [UIFont boldSystemFontOfSize:10];
    NSDictionary *smallFontDict = [NSDictionary dictionaryWithObject:smallFont forKey:NSFontAttributeName];
    NSMutableAttributedString *dayString = [[NSMutableAttributedString alloc]initWithString: [dateStringValue substringFromIndex:2] attributes:smallFontDict];
    [dateString appendAttributedString:dayString];
    [dayString release];
    
    dateLabel.attributedText = dateString;
    
    [dateString release];
    
    NSUInteger noOfGlasses = numberOfGlasses;
    CGFloat glassFraction = ((float)noOfGlasses/(float)Graph_MaxGlassesIntake);
    
    CGFloat heightOfBar = Graph_MaxBarHeight*glassFraction;
    
    UIView *lightBlueBar = [[UIView alloc]initWithFrame:CGRectMake((IS_HEIGHT_GTE_568)?253:170+43, 0, heightOfBar, 34)];
    lightBlueBar.backgroundColor = (atIndexPath.row%2==0 && atIndexPath.row!=0)?[UIColor colorWithRed:180/255.0f green:219/255.0f blue:230/255.0f alpha:1]:[UIColor colorWithRed:126/255.0f green:181/255.0f blue:196/255.0f alpha:1];
    [self insertSubview:lightBlueBar belowSubview:grayStripHorizontal];
    lightBlueBar.layer.cornerRadius = 1.5;
    [lightBlueBar release];
    
    // Bottom Inverted Graphs
    
    NSUInteger noOfHoursCompleted = goalsObject.totalMinutes + goalsObject.totalHours*60;
    CGFloat goalsFraction = ((float)noOfHoursCompleted/(float)Graph_MaxMinutes);
    
    CGFloat heightOfGoalsBar = Graph_MaxBarHeight*goalsFraction;
    
    UIView *bottomGraphLabel = [[UIView alloc]initWithFrame:CGRectMake(((IS_HEIGHT_GTE_568)?210:170)-heightOfGoalsBar+1, 0, heightOfGoalsBar, 34)];
    bottomGraphLabel.backgroundColor = (atIndexPath.row%2==0)?[UIColor colorWithRed:33/255.0f green:118/255.0f blue:189/255.0f alpha:1]:[UIColor colorWithRed:24/255.0f green:89/255.0f blue:142/255.0f alpha:1];
    [self insertSubview:bottomGraphLabel belowSubview:grayStripHorizontal];
    bottomGraphLabel.layer.cornerRadius = 1.5;
    [bottomGraphLabel release];
}


-(void)setWaterAndFoodStatsData:(DataFood*)foodObject :(NSUInteger )numberOfGlasses :(NSIndexPath*)atIndexPath :(NSString*)dateStringValue
{
    UIFont *bigFont = [UIFont boldSystemFontOfSize:16];
    NSDictionary *bigFontdict = [NSDictionary dictionaryWithObject: bigFont forKey:NSFontAttributeName];
    NSMutableAttributedString *dateString = [[NSMutableAttributedString alloc] initWithString:[dateStringValue substringToIndex:2] attributes: bigFontdict];
    
    UIFont *smallFont = [UIFont boldSystemFontOfSize:10];
    NSDictionary *smallFontDict = [NSDictionary dictionaryWithObject:smallFont forKey:NSFontAttributeName];
    NSMutableAttributedString *dayString = [[NSMutableAttributedString alloc]initWithString: [dateStringValue substringFromIndex:2] attributes:smallFontDict];
    [dateString appendAttributedString:dayString];
    [dayString release];
    
    dateLabel.attributedText = dateString;
    
    [dateString release];
    
    NSUInteger noOfGlasses = numberOfGlasses;
    CGFloat glassFraction = ((float)noOfGlasses/(float)Graph_MaxGlassesIntake);
    
    CGFloat heightOfBar = Graph_MaxBarHeight*glassFraction;
    
    UIView *lightBlueBar = [[UIView alloc]initWithFrame:CGRectMake((IS_HEIGHT_GTE_568)?253:170+43, 0, heightOfBar, 34)];
    lightBlueBar.backgroundColor = (atIndexPath.row%2==0 && atIndexPath.row!=0)?[UIColor colorWithRed:180/255.0f green:219/255.0f blue:230/255.0f alpha:1]:[UIColor colorWithRed:126/255.0f green:181/255.0f blue:196/255.0f alpha:1];
    [self insertSubview:lightBlueBar belowSubview:grayStripHorizontal];
    lightBlueBar.layer.cornerRadius = 1.5;
    [lightBlueBar release];

    if (foodObject.hadOrange) {
        UIImageView *carrotView = [[UIImageView alloc]initWithFrame:CGRectMake((IS_HEIGHT_GTE_568)?181:141.1, 0, 28, 34.5)];
        carrotView.image = [UIImage imageNamed:@"Orange.png"];
        [self addSubview:carrotView];
        [carrotView release];
        
        CGRect carrotFrame = carrotView.frame;
        carrotView.transform = CGAffineTransformRotate(carrotView.transform, M_PI / 2);
        carrotView.frame = carrotFrame;
    }
    
    if (foodObject.hadWheat) {
        UIImageView *carrotView = [[UIImageView alloc]initWithFrame:CGRectMake(((IS_HEIGHT_GTE_568)?181:141.1)-28-28-2, 0, 28,34.5)];
        carrotView.image = [UIImage imageNamed:@"Wheat.png"];
        [self addSubview:carrotView];
        [carrotView release];
        
        CGRect carrotFrame = carrotView.frame;
        carrotView.transform = CGAffineTransformRotate(carrotView.transform, M_PI / 2);
        carrotView.frame = carrotFrame;
    }
    
    if (foodObject.hadMilk) {
        UIImageView *carrotView = [[UIImageView alloc]initWithFrame:CGRectMake(((IS_HEIGHT_GTE_568)?181:141.1)-28-28-28-28-4, 0, 28,34.5)];
        carrotView.image = [UIImage imageNamed:@"Milk.png"];
        [self addSubview:carrotView];
        [carrotView release];
        
        CGRect carrotFrame = carrotView.frame;
        carrotView.transform = CGAffineTransformRotate(carrotView.transform, M_PI / 2);
        carrotView.frame = carrotFrame;
    }
    
    if (foodObject.hadCarrot) {
        UIImageView *carrotView = [[UIImageView alloc]initWithFrame:CGRectMake(((IS_HEIGHT_GTE_568)?181:141.1)-28-1, 0, 28, 34.5)];
        carrotView.image = [UIImage imageNamed:@"Carrot.png"];
        [self addSubview:carrotView];
        [carrotView release];
        
        CGRect carrotFrame = carrotView.frame;
        carrotView.transform = CGAffineTransformRotate(carrotView.transform, M_PI / 2);
        carrotView.frame = carrotFrame;
    }
    if (foodObject.hadFish) {
        UIImageView *fishView = [[UIImageView alloc]initWithFrame:CGRectMake(((IS_HEIGHT_GTE_568)?181:141.1)-28-28-28-3, 0, 28, 34.5)];
        fishView.image = [UIImage imageNamed:@"Fish.png"];
        [self addSubview:fishView];
        [fishView release];
        
        CGRect fishFrame = fishView.frame;
        fishView.transform = CGAffineTransformRotate(fishView.transform, M_PI / 2);
        fishView.frame = fishFrame;
    }
    
    if (foodObject.hadLiquor) {
        UIImageView *liquorView = [[UIImageView alloc]initWithFrame:CGRectMake(((IS_HEIGHT_GTE_568)?181:141.1)-28-28-28-28-28-5, 0, 28, 34.5)];
        liquorView.image = [UIImage imageNamed:@"Liquor.png"];
        [self addSubview:liquorView];
        [liquorView release];
        
        CGRect liquorFrame = liquorView.frame;
        liquorView.transform = CGAffineTransformRotate(liquorView.transform, M_PI / 2);
        liquorView.frame = liquorFrame;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
