//
//  IntAxisValueFormatter.m
//  ChartsDemo
//  Copyright © 2016 dcg. All rights reserved.
//

#import "IntAxisValueFormatter.h"

@implementation IntAxisValueFormatter
{
}

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    return [NSString stringWithFormat:@"%.1f%%", value];// [@((NSInteger)value) stringValue];
}

@end
