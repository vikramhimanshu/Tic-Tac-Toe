//
//  Board.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/13/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Symbol.h"

@class BoardView;
@class Player;
@class SymbolCell;

@protocol BoardDelegate <NSObject>

- (void)boardWillChangeWithMove:(SymbolCell *)move;
- (void)boardDidChangeWithMove:(SymbolCell *)move;
- (void)boardDidDetectWinInRow:(NSString *)winningRow forSymbol:(Symbol)symbol;
- (void)boardDidDetectDraw;

@optional
- (void)boardDidDetectForkInRows:(NSArray *)winningRows forSymbol:(Symbol)symbol;
- (void)boardDidDetectBlockInRows:(NSArray *)winningRows forSymbol:(Symbol)symbol;
- (void)boardDidCompleteCheckWithAvailableMoves:(NSArray *)availableMoves;

@end

@interface Board : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) id <BoardDelegate> delegate;

@property (nonatomic, strong, readonly) NSArray *allCells;

- (instancetype)initWithBoardView:(BoardView *)boardView;

- (void)display;
- (void)markCell:(SymbolCell *)cell withSymbol:(Symbol)symbol;

- (NSInteger)numberOfRows;
- (NSInteger)numberOfColumns;

@end

