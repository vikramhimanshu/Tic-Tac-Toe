//
//  BoardProtocol.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/15/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SymbolCell;

@protocol GridProtocol <NSObject>

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
