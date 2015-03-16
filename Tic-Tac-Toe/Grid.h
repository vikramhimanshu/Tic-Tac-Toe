//
//  Grid.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GridProtocol.h"

extern NSString *const KeyRowTop;
extern NSString *const KeyRowMiddle;
extern NSString *const KeyRowBottom;
extern NSString *const KeyRowLeft;
extern NSString *const KeyRowCenter;
extern NSString *const KeyRowRight;
extern NSString *const KeyRowDiagonal1;
extern NSString *const KeyRowDiagonal2;

@class SymbolCell;

@interface Grid : NSObject <GridProtocol>

@property (nonatomic, readonly)  NSArray *allCells;

- (instancetype)initWithCells:(NSArray *)cellsArray;
- (void)create;

@end
