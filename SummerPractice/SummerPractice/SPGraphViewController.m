#import "SPGraphViewController.h"

@implementation SPGraphViewController
@synthesize graphView;
@synthesize taskImageView;

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"График";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - Graph
-(IBAction)doBuildBtn{
    graph = [[CPTXYGraph alloc] initWithFrame: self.view.bounds];
    CPTGraphHostingView *hostingView = [[CPTGraphHostingView alloc] initWithFrame:self.graphView.bounds];
    graphView.hidden = NO;
    [self.view addSubview:hostingView];
    
    hostingView.hostedGraph = graph;
    graph.paddingLeft = 20.0;
    graph.paddingTop = 20.0;
    graph.paddingRight = 20.0;
    graph.paddingBottom = 00.0;
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-6) 
                                                    length:CPTDecimalFromFloat(12)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-10) 
                                                    length:CPTDecimalFromFloat(30)];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor blackColor];
    lineStyle.lineWidth = 2.0f;
    
    axisSet.xAxis.majorIntervalLength = [[NSNumber numberWithInt:5] decimalValue];
    axisSet.xAxis.minorTicksPerInterval = 4;
    axisSet.xAxis.majorTickLineStyle = lineStyle;
    axisSet.xAxis.minorTickLineStyle = lineStyle;
    axisSet.xAxis.axisLineStyle = lineStyle;
    axisSet.xAxis.minorTickLength = 5.0f;
    axisSet.xAxis.majorTickLength = 7.0f;
    axisSet.xAxis.labelOffset = 3.0f;
    
    axisSet.yAxis.majorIntervalLength = [[NSNumber numberWithInt:5] decimalValue];
    axisSet.yAxis.minorTicksPerInterval = 4;
    axisSet.yAxis.majorTickLineStyle = lineStyle;
    axisSet.yAxis.minorTickLineStyle = lineStyle;
    axisSet.yAxis.axisLineStyle = lineStyle;
    axisSet.yAxis.minorTickLength = 5.0f;
    axisSet.yAxis.majorTickLength = 7.0f;
    axisSet.yAxis.labelOffset = 3.0f;
    
    CPTScatterPlot *xSquaredPlot = [[CPTScatterPlot alloc] initWithFrame:graph.defaultPlotSpace.accessibilityFrame];
    xSquaredPlot.identifier = @"X Squared Plot";
    CPTMutableLineStyle *ls1 = [CPTMutableLineStyle lineStyle];
    ls1.lineWidth = 1.0f;
    ls1.lineColor = [CPTColor redColor];
    xSquaredPlot.dataLineStyle = ls1;
    xSquaredPlot.dataSource = self;
    [graph addPlot:xSquaredPlot];
    
    CPTPlotSymbol *greenCirclePlotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    greenCirclePlotSymbol.fill = [CPTFill fillWithColor:[CPTColor greenColor]];
    greenCirclePlotSymbol.size = CGSizeMake(2.0, 2.0);
    xSquaredPlot.plotSymbol = greenCirclePlotSymbol;  
    
    CPTScatterPlot *xInversePlot = [[CPTScatterPlot alloc] initWithFrame:graph.defaultPlotSpace.accessibilityFrame];
    
    xInversePlot.identifier = @"X Inverse Plot";
    CPTMutableLineStyle *ls2 = [CPTMutableLineStyle lineStyle];
    ls2.lineWidth = 1.0f;
    ls2.lineColor = [CPTColor blueColor];
    xInversePlot.dataLineStyle = ls2;
    xInversePlot.dataSource = self;
    [graph addPlot:xInversePlot];  
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return 51;
}

//график
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    double val = (index/5.0)-5;
    if(fieldEnum == CPTScatterPlotFieldX)
        return [NSNumber numberWithDouble:val];
    else
    {
        return [NSNumber numberWithDouble:(1+pow(val, 3.0))/(pow(val,2.0))];
    }       
}


@end
