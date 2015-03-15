//
//  Board.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/13/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GridProtocol.h"
#import "Grid.h"
#import "Symbol.h"

@class BoardView;
@class Player;
@class SymbolCell;

@protocol BoardProtocol <NSObject>

- (void)boardWillChangeWithMove:(SymbolCell *)move;
- (void)boardDidChangeWithMove:(SymbolCell *)move;

@end

@interface Board : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, GridProtocol>

@property (nonatomic, weak) id <BoardProtocol> delegate;

@property (nonatomic, strong, readonly) NSArray *allCells;

- (instancetype)initWithBoardView:(BoardView *)boardView;

- (void)display;
- (void)markCell:(SymbolCell *)cell withSymbol:(Symbol)symbol;

+ (NSInteger)numberOfRows;
+ (NSInteger)numberOfColumns;

@end

