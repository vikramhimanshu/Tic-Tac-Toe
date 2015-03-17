//
//  Board+Grid.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/17/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "Board.h"
#import "GridProtocol.h"

@class Grid;
@interface Board (Grid) <GridProtocol>

@property (nonatomic, strong) Grid *gameGrid;

@end
