//
//  Grid.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const KeyRowTop;
extern NSString *const KeyRowMiddle;
extern NSString *const KeyRowBottom;
extern NSString *const KeyRowLeft;
extern NSString *const KeyRowCenter;
extern NSString *const KeyRowRight;
extern NSString *const KeyRowDiagonal1;
extern NSString *const KeyRowDiagonal2;

@class SymbolCell;

@interface Grid : NSObject

@property (nonatomic, readonly)  NSArray *allCells;

- (instancetype)initWithCells:(NSArray *)cellsArray;
- (void)create;

- (NSArray *)rowsForCellAtIndex:(NSInteger)idx;
- (NSArray *)cellsForRow:(NSString *)rowKey;

- (SymbolCell *)center;

- (SymbolCell *)topLeftCorner;
- (SymbolCell *)topRightCorner;
- (SymbolCell *)bottomLeftCorner;
- (SymbolCell *)bottomRightCorner;

-(SymbolCell *)topEdge;
-(SymbolCell *)leftEdge;
-(SymbolCell *)rightEdge;
-(SymbolCell *)bottomEdge;

- (BOOL)isTopLeftCorner:(SymbolCell *)cell;
- (BOOL)isTopRightCorner:(SymbolCell *)cell;
- (BOOL)isBottomLeftCorner:(SymbolCell *)cell;
- (BOOL)isBottomRightCorner:(SymbolCell *)cell;

- (BOOL)isTopEdge:(SymbolCell *)cell;
- (BOOL)isBottomEdge:(SymbolCell *)cell;
- (BOOL)isLeftEdge:(SymbolCell *)cell;
- (BOOL)isRightEdge:(SymbolCell *)cell;

- (SymbolCell *)leftCornerToEdge:(SymbolCell *)cell;
- (SymbolCell *)rightCornerToEdge:(SymbolCell *)cell;
- (SymbolCell *)topCornerToEdge:(SymbolCell *)cell;
- (SymbolCell *)bottomCornerToEdge:(SymbolCell *)cell;

- (SymbolCell *)oppositeCorner:(SymbolCell *)cell;
- (SymbolCell *)oppositeEdge:(SymbolCell *)cell;

- (BOOL)isCorner:(SymbolCell *)cell;
- (BOOL)isCenter:(SymbolCell *)cell;
- (BOOL)isEdge:(SymbolCell *)cell;

@end
