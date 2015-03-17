//
//  Grid.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GridProtocol.h"

@class SymbolCell;

@interface Grid : NSObject <GridProtocol>

@property (nonatomic, readonly)  NSArray *allCells;

- (instancetype)initWithCells:(NSArray *)cellsArray;
- (void)create;

@end
