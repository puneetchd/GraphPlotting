//
//  GraphAndGoalsController.m
//  GraphPlotting
//
//  Created by Puneet Sharma on 14/04/13.
//  Copyright (c) 2013 Puneet Sharma. All rights reserved.
//

#import "GraphAndGoalsController.h"
#import "GraphConstants.h"
#import "CustomGraphCell.h"
#import "DataWaterCups.h"
#import "DataGoalHours.h"
#import "GraphView.h"

@interface GraphAndGoalsController ()

@end

@implementation GraphAndGoalsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.title = @"Graph View";
    //self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBackground.png"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnShowGraph = [UIButton buttonWithType:UIButtonTypeCustom];
    btnShowGraph.frame = CGRectMake(20, 0, 40, 40);
    btnShowGraph.clipsToBounds = YES;
    btnShowGraph.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [btnShowGraph addTarget:self action:@selector(showFoodView:) forControlEvents:UIControlEventTouchUpInside];
    [btnShowGraph setBackgroundImage:[UIImage imageNamed:@"RightButton.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *graphBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnShowGraph];
    graphBarButton.tintColor = [UIColor colorWithRed:50.0/255.0 green:190.0/255.0 blue:242.0/255.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = graphBarButton;
    [graphBarButton release];
    
    UIButton *btnShowFoodGraph = [UIButton buttonWithType:UIButtonTypeCustom];
    btnShowFoodGraph.frame = CGRectMake(20, 0, 40, 40);
    btnShowFoodGraph.clipsToBounds = YES;
    btnShowFoodGraph.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [btnShowFoodGraph setBackgroundImage:[UIImage imageNamed:@"LeftButton.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *foodGraphBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnShowFoodGraph];
    foodGraphBarButton.tintColor = [UIColor colorWithRed:50.0/255.0 green:190.0/255.0 blue:242.0/255.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = foodGraphBarButton;
    [foodGraphBarButton release];
    
    // Do any additional setup after loading the view from its nib.
    
    graphTable = [[UITableView alloc]initWithFrame:CGRectNull];
    graphTable.delegate = self;
    graphTable.dataSource = self;
    graphTable.showsVerticalScrollIndicator = NO;
    graphTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //graphTable.pagingEnabled = YES;
    graphTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:graphTable];
    [graphTable release];
    
    CGRect screenRect = [[UIScreen mainScreen]bounds];
    
    if (screenRect.size.height == 568) {
        graphTable.frame = CGRectMake(0, 0, 320, 460);
    }
    else
    {
        graphTable.frame = CGRectMake(0, 0, 320, 376);
    }
    
    CGRect frame = graphTable.frame;
    
    graphTable.transform = CGAffineTransformRotate(graphTable.transform, -M_PI / 2);
    
    graphTable.frame = frame;
    
    // Fill Dates Array
    
    datesArray = [[NSMutableArray alloc]initWithObjects:@"02 SUN",@"03 MON",@"04 TUE",@"05 WED",@"06 THU",@"07 FRI",@"08 SAT",@"09 SUN",@"10 MON",@"11 MON",@"12 TUE",@"13 WED",@"14 THU",@"15 FRI",@"16 SAT",@"17 SUN",@"18 MON",@"19 TUE",@"20 WED",@"21 THU",@"22 FRI",@"23 SAT",@"24 SUN",@"25 MON",@"26 TUE",@"27 WED",@"28 THU",@"29 FRI", nil];
    
    glsssesIntakeArray = [[NSMutableArray alloc]init];
    
    goalsArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<datesArray.count; i++) {
        
        DataWaterCups *dataWaterCups = [[DataWaterCups alloc ]init];
        dataWaterCups.noOfWaterCups = (NSUInteger)(arc4random()%13);
        
        [glsssesIntakeArray addObject:dataWaterCups];
        [dataWaterCups release];
        
        DataGoalHours *dataGoalHours = [[DataGoalHours alloc]init];
        dataGoalHours.totalHours = arc4random()%24;
        dataGoalHours.totalMinutes = arc4random()%60;
        [goalsArray addObject:dataGoalHours];
        [dataGoalHours release];
    }
    
    
    UIView *grayStripVertical = [[UIView alloc]initWithFrame:Graph_Vertical_Strip_Rect];
    grayStripVertical.backgroundColor = [UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:1];
    grayStripVertical.tag = Graph_Strip_Tag;
    grayStripVertical.alpha = .5;
    grayStripVertical.opaque = NO;
    [self.view addSubview:grayStripVertical];
    [grayStripVertical release];
    
    UIView *waterIntakeStatsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    waterIntakeStatsView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:waterIntakeStatsView];
    [waterIntakeStatsView release];
    
    UIImageView *dashedLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 29, 320, .7)];
    dashedLine.image = [UIImage imageNamed:@"DashedLine.png"];
    [waterIntakeStatsView addSubview:dashedLine];
    [dashedLine release];
    
    UIImageView *trophy = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 33.5, 29)];
    trophy.image = [UIImage imageNamed:@"Trophy.png"];
    [waterIntakeStatsView addSubview:trophy];
    [trophy release];
    
    UIImageView *cupsView = [[UIImageView alloc]initWithFrame:CGRectMake(142, -2, 34, 31)];
    cupsView.image = [UIImage imageNamed:@"Cups.png"];
    [waterIntakeStatsView addSubview:cupsView];
    [cupsView release];
    
    lblCups = [[UILabel alloc]initWithFrame:CGRectMake(33.5, 0, 108.5, 29)];
    lblCups.backgroundColor = [UIColor colorWithRed:226/255.0f green:229/255.0f blue:230/255.0f alpha:1];
    lblCups.text = @"12 CUPS";
    lblCups.font = [UIFont boldSystemFontOfSize:15];
    lblCups.textColor = [UIColor colorWithRed:86/255.0f green:136/255.0f blue:150/255.0f alpha:1];
    [waterIntakeStatsView addSubview:lblCups];
    [lblCups release];
    
    lblIntakeCups = [[UILabel alloc]initWithFrame:CGRectMake(176, 0, 145, 29)];
    lblIntakeCups.backgroundColor = [UIColor colorWithRed:226/255.0f green:229/255.0f blue:230/255.0f alpha:1];
    lblIntakeCups.textAlignment = NSTextAlignmentCenter;
    lblIntakeCups.font = [UIFont boldSystemFontOfSize:13];
    lblIntakeCups.textColor = [UIColor colorWithRed:86/255.0f green:136/255.0f blue:150/255.0f alpha:1];
    [waterIntakeStatsView addSubview:lblIntakeCups];
    [lblIntakeCups release];
    
    [self setStatsDataAndGoalsData:[glsssesIntakeArray objectAtIndex:4] :[goalsArray objectAtIndex:4]];
    
    UIView *goalCompletedStatsView = [[UIView alloc]initWithFrame:CGRectMake(0,(IS_HEIGHT_GTE_568)?425:340, 320, 30)];
    waterIntakeStatsView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:goalCompletedStatsView];
    [goalCompletedStatsView release];
    
    UIImageView *goalDashedLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, .7)];
    goalDashedLine.image = [UIImage imageNamed:@"DashedLine.png"];
    [goalCompletedStatsView addSubview:goalDashedLine];
    [goalDashedLine release];
    
    UIImageView *light_trophy = [[UIImageView alloc]initWithFrame:CGRectMake(0, 1, 33.5, 33)];
    light_trophy.image = [UIImage imageNamed:@"Trophy_Light.png"];
    [goalCompletedStatsView addSubview:light_trophy];
    [light_trophy release];
    
    UIImageView *blueBarView = [[UIImageView alloc]initWithFrame:CGRectMake(142, 1, 34, 31)];
    blueBarView.image = [UIImage imageNamed:@"BlueBar.png"];
    [goalCompletedStatsView addSubview:blueBarView];
    [blueBarView release];
    
    lblGoals = [[UILabel alloc]initWithFrame:CGRectMake(33.5, 0, 108, 30)];
    lblGoals.backgroundColor = [UIColor clearColor];
    lblGoals.text = @"No goals set";
    lblGoals.font = [UIFont boldSystemFontOfSize:14];
    lblGoals.textColor = [UIColor lightGrayColor];
    [goalCompletedStatsView addSubview:lblGoals];
    [lblGoals release];
    
    lblCompletedGoals = [[UILabel alloc]initWithFrame:CGRectMake(176, 0, 145, 30)];
    lblCompletedGoals.backgroundColor = [UIColor clearColor];
    lblCompletedGoals.textAlignment = NSTextAlignmentCenter;
    lblCompletedGoals.font = [UIFont boldSystemFontOfSize:13];
    lblCompletedGoals.textColor = [UIColor colorWithRed:24/255.0f green:89/255.0f blue:142/255.0f alpha:1];
    [goalCompletedStatsView addSubview:lblCompletedGoals];
    [lblCompletedGoals release];
    
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"Days",@"Weeks",@"Months", nil]];
    segmentControl.frame = CGRectMake(-10, (IS_HEIGHT_GTE_568)?455:370, 340, 50);
    [segmentControl addTarget:self action:@selector(segmentControlSelected:) forControlEvents:UIControlEventValueChanged];
    segmentControl.tintColor = [UIColor colorWithRed:215/255.0f green:215/255.0f blue:215/255.0f alpha:1];
    segmentControl.segmentedControlStyle = UISegmentedControlStylePlain;
    [self.view addSubview:segmentControl];
    [segmentControl release];
    
    UILabel *lblMonthView = [[UILabel alloc]initWithFrame:CGRectMake(-14, (IS_HEIGHT_GTE_568)?220:176, 45, 17)];
    lblMonthView.backgroundColor = [UIColor darkGrayColor];
    lblMonthView.text = @"FEB";
    lblMonthView.textColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1];
    lblMonthView.textAlignment = NSTextAlignmentCenter;
    lblMonthView.font = [UIFont boldSystemFontOfSize:10];
    [self.view addSubview:lblMonthView];
    [lblMonthView release];
    lblMonthView.transform = CGAffineTransformRotate(lblMonthView.transform, -M_PI / 2);
    
}

#pragma mark - Other Button Functions

-(void)showFoodView:(id)sender
{
    GraphView *graphController = [[GraphView alloc]init];
    [self.navigationController pushViewController:graphController animated:YES];
    [graphController release];
}

-(void)segmentControlSelected:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl*)sender;
    if (control.selectedSegmentIndex == 0) {
        
    }
    else if (control.selectedSegmentIndex == 1) {
    }
    else
    {
    }
}

#pragma mark - Set Values in Label Function

-(void)setStatsDataAndGoalsData:(DataWaterCups*)dataWater :(DataGoalHours*)dataGoals
{
    NSUInteger numberOfGlasses = dataWater.noOfWaterCups;
    
    NSString *inputString = [NSString stringWithFormat:@"Water Intake  cups"];
    UIFont *bigFont = [UIFont fontWithName:@"Helvetica" size:13];
    NSDictionary *bigFontdict = [NSDictionary dictionaryWithObject: bigFont forKey:NSFontAttributeName];
    NSMutableAttributedString *dateString = [[NSMutableAttributedString alloc] initWithString:[inputString substringToIndex:18] attributes: bigFontdict];
    
    UIFont *smallFont = [UIFont boldSystemFontOfSize:14];
    NSDictionary *smallFontDict = [NSDictionary dictionaryWithObject:smallFont forKey:NSFontAttributeName];
    NSMutableAttributedString *glassNumberString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"%d",numberOfGlasses] attributes:smallFontDict];
    [dateString insertAttributedString:glassNumberString atIndex:13];
    [glassNumberString release];
    
    lblIntakeCups.attributedText = dateString;
    [dateString release];
    
    NSString *labelString = [NSString stringWithFormat:@"Time  h  min"];
    UIFont *goalBigFont = [UIFont fontWithName:@"Helvetica" size:14];
    NSDictionary *goalBigFontdict = [NSDictionary dictionaryWithObject: goalBigFont forKey:NSFontAttributeName];
    NSMutableAttributedString *goalString = [[NSMutableAttributedString alloc] initWithString:[labelString substringToIndex:12] attributes: goalBigFontdict];
    
    UIFont *goalSmallFont = [UIFont boldSystemFontOfSize:14];
    NSDictionary *goalSmallFontDict = [NSDictionary dictionaryWithObject:goalSmallFont forKey:NSFontAttributeName];
    NSMutableAttributedString *hoursNumberString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"%d",dataGoals.totalHours] attributes:goalSmallFontDict];
    [goalString insertAttributedString:hoursNumberString atIndex:6];
    [hoursNumberString release];
    
    NSMutableAttributedString *minutesNumberString = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"%d",dataGoals.totalMinutes] attributes:goalSmallFontDict];
    [goalString insertAttributedString:minutesNumberString atIndex:10];
    [minutesNumberString release];
    
    lblCompletedGoals.attributedText = goalString;
    [goalString release];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UITableView *)tableView
{
    UIView *verticalStrip = [self.view viewWithTag:Graph_Strip_Tag];
    NSIndexPath *indexPath= [tableView indexPathForRowAtPoint:CGPointMake(0,verticalStrip.center.x+tableView.contentOffset.y)];
    NSUInteger rowNumber = indexPath.row;
    if (rowNumber<glsssesIntakeArray.count) {
        DataWaterCups *dataWaterCups = [glsssesIntakeArray objectAtIndex:rowNumber];
        DataGoalHours *dataGoals = [goalsArray objectAtIndex:rowNumber];
        [self setStatsDataAndGoalsData:dataWaterCups :dataGoals];
    }
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 142;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 142;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectNull];
    return [view autorelease];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectNull];
    return [view autorelease];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35.5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [datesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomGraphCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell%d",indexPath.row]];
    if (cell == nil)
    {
        cell = [[[CustomGraphCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    DataGoalHours *dataGoals = [goalsArray objectAtIndex:indexPath.row];
    
    DataWaterCups *dataWaterCups = [glsssesIntakeArray objectAtIndex:indexPath.row];
    [cell setWaterAndGoalsStatsData:dataGoals :dataWaterCups.noOfWaterCups :indexPath :[datesArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [super dealloc];
    [datesArray release];
    [glsssesIntakeArray release];
    [goalsArray release];
}

@end
