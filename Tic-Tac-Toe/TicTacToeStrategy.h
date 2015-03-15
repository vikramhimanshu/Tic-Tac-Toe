//
//  TicTacToeStrategy.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SymbolCell;
@class Board;

@interface TicTacToeStrategy : NSObject

- (instancetype)initWithBoard:(Board *)board;
- (SymbolCell *)nextMoveForCurrentOpponentMove:(SymbolCell *)cell;

@end
