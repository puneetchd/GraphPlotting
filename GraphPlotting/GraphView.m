//
//  GraphView.m
//  FitnessApp
//
//  Created by Puneet Sharma on 13/04/13.
//  Copyright (c) 2013 Puneet Sharma. All rights reserved.
//

#import "GraphView.h"
#import "GraphConstants.h"
#import "CustomGraphCell.h"
#import "DataFood.h"
#import "DataWaterCups.h"

@interface GraphView ()

@end

@implementation GraphView

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // Do any additional setup after loading the view from its nib.
    
    graphTable = [[UITableView alloc]initWithFrame:CGRectNull];
    graphTable.delegate = self;
    graphTable.dataSource = self;
    graphTable.showsVerticalScrollIndicator = NO;
    graphTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    graphTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:graphTable];
    [graphTable release];
    
    CGRect screenRect = [[UIScreen mainScreen]bounds];
    
    if (screenRect.size.height == 568) {
        graphTable.frame = CGRectMake(0, 0, 320, 460);
    }
    else
    {
        graphTable.frame = CGRectMake(0, 0, 320, 380);
    }
    
    CGRect frame = graphTable.frame;
    
    graphTable.transform = CGAffineTransformRotate(graphTable.transform, -M_PI / 2);
    
    graphTable.frame = frame;
    
    // Fill Dates Array
    
    datesArray = [[NSMutableArray alloc]initWithObjects:@"02 SUN",@"03 MON",@"04 TUE",@"05 WED",@"06 THU",@"07 FRI",@"08 SAT",@"09 SUN",@"10 MON",@"11 MON",@"12 TUE",@"13 WED",@"14 THU",@"15 FRI",@"16 SAT",@"17 SUN",@"18 MON",@"19 TUE",@"20 WED",@"21 THU",@"22 FRI",@"23 SAT",@"24 SUN",@"25 MON",@"26 TUE",@"27 WED",@"28 THU",@"29 FRI", nil];
    
    glsssesIntakeArray = [[NSMutableArray alloc]init];
    
    foodIntakeArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<datesArray.count; i++) {
        DataFood *dataFood = [[DataFood alloc]init];
        dataFood.hadCarrot = arc4random()%2;
        dataFood.hadFish = arc4random()%2;
        dataFood.hadLiquor = arc4random()%2;
        dataFood.hadMilk = arc4random()%2;
        dataFood.hadOrange = arc4random()%2;
        dataFood.hadWheat = arc4random()%2;
        
        [foodIntakeArray addObject:dataFood];
        [dataFood release];
        
        DataWaterCups *dataWaterCups = [[DataWaterCups alloc ]init];
        dataWaterCups.noOfWaterCups = (NSUInteger)(arc4random()%13);
        
        [glsssesIntakeArray addObject:dataWaterCups];
        [dataWaterCups release];
    }
    
    UIView *grayStripVertical = [[UIView alloc]initWithFrame:Graph_Vertical_Strip_Rect];
    grayStripVertical.backgroundColor = [UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:1];
    grayStripVertical.tag = Graph_Strip_Tag;
    grayStripVertical.alpha = .5;
    grayStripVertical.opaque = NO;
    [self.view addSubview:grayStripVertical];
    [grayStripVertical release];
    
    UIView *statsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    statsView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:statsView];
    [statsView release];
    
    UIImageView *dashedLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 29, 320, .7)];
    dashedLine.image = [UIImage imageNamed:@"DashedLine.png"];
    [statsView addSubview:dashedLine];
    [dashedLine release];
    
    UIImageView *trophy = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 33.5, 29)];
    trophy.image = [UIImage imageNamed:@"Trophy.png"];
    [statsView addSubview:trophy];
    [trophy release];
    
    UIImageView *cupsView = [[UIImageView alloc]initWithFrame:CGRectMake(142, -2, 34, 31)];
    cupsView.image = [UIImage imageNamed:@"Cups.png"];
    [statsView addSubview:cupsView];
    [cupsView release];
    
    lblCups = [[UILabel alloc]initWithFrame:CGRectMake(33.5, 0, 108.5, 29)];
    lblCups.backgroundColor = [UIColor colorWithRed:226/255.0f green:229/255.0f blue:230/255.0f alpha:1];
    lblCups.text = @"12 CUPS";
    lblCups.font = [UIFont boldSystemFontOfSize:15];
    lblCups.textColor = [UIColor colorWithRed:86/255.0f green:136/255.0f blue:150/255.0f alpha:1];
    [statsView addSubview:lblCups];
    [lblCups release];
    
    lblIntakeCups = [[UILabel alloc]initWithFrame:CGRectMake(176, 0, 145, 29)];
    lblIntakeCups.backgroundColor = [UIColor colorWithRed:226/255.0f green:229/255.0f blue:230/255.0f alpha:1];
    lblIntakeCups.textAlignment = NSTextAlignmentCenter;
    lblIntakeCups.font = [UIFont boldSystemFontOfSize:13];
    lblIntakeCups.textColor = [UIColor colorWithRed:86/255.0f green:136/255.0f blue:150/255.0f alpha:1];
    [statsView addSubview:lblIntakeCups];
    [lblIntakeCups release];
    [self setStatsData:0];
    
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"Days",@"Weeks",@"Months", nil]];
    segmentControl.frame = CGRectMake(-10, (IS_HEIGHT_GTE_568)?455:380, 340, 50);
    [segmentControl addTarget:self action:@selector(segmentControlSelected:) forControlEvents:UIControlEventValueChanged];
    segmentControl.tintColor = [UIColor colorWithRed:215/255.0f green:215/255.0f blue:215/255.0f alpha:1];
    segmentControl.segmentedControlStyle = UISegmentedControlStylePlain;
    [self.view addSubview:segmentControl];
    [segmentControl release];
    
    UILabel *lblMonthView = [[UILabel alloc]initWithFrame:CGRectMake(-14, (IS_HEIGHT_GTE_568)?220:180, 45, 17)];
    lblMonthView.backgroundColor = [UIColor darkGrayColor];
    lblMonthView.text = @"FEB";
    lblMonthView.textColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1];
    lblMonthView.textAlignment = NSTextAlignmentCenter;
    lblMonthView.font = [UIFont boldSystemFontOfSize:10];
    [self.view addSubview:lblMonthView];
    [lblMonthView release];
    lblMonthView.transform = CGAffineTransformRotate(lblMonthView.transform, -M_PI / 2);
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

#pragma mark - Set Values In Label Function

-(void)setStatsData : (NSUInteger)numberOfGlasses
{
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
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UITableView *)tableView
{
    UIView *verticalStrip = [self.view viewWithTag:Graph_Strip_Tag];
    NSIndexPath *indexPath= [tableView indexPathForRowAtPoint:CGPointMake(0,verticalStrip.center.x+tableView.contentOffset.y)];
    NSUInteger rowNumber = indexPath.row;
    if (rowNumber<glsssesIntakeArray.count) {
        DataWaterCups *dataWaterCups = [glsssesIntakeArray objectAtIndex:rowNumber];
        [self setStatsData:dataWaterCups.noOfWaterCups];
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
    
    DataFood *dataFood = [foodIntakeArray objectAtIndex:indexPath.row];
    
    DataWaterCups *dataWaterCups = [glsssesIntakeArray objectAtIndex:indexPath.row];
    
    [cell setWaterAndFoodStatsData:dataFood :dataWaterCups.noOfWaterCups :indexPath :[datesArray objectAtIndex:indexPath.row]];
    
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
    [foodIntakeArray release];
}

@end
