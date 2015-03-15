//
//  NSIndexPath+Compare.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/13/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "NSIndexPath+Compare.h"
#import <UIKit/UIKit.h>

@implementation NSIndexPath (Compare)

-(BOOL)equal:(NSIndexPath *)otherObject
{
    return ((self.row == otherObject.row) && (self.section == otherObject.section));
}

NSIndexPath * location(NSInteger row, NSInteger col)
{
    return [NSIndexPath indexPathForRow:row
                              inSection:col];
}

@end
