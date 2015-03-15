//
//  Player.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Symbol.h"

@class SymbolCell;
@class Player;
@class Game;

@protocol  PlayerProtocol;

@protocol PlayerDelegate <NSObject>

- (void)player:(id <PlayerProtocol>)player willMakeMove:(SymbolCell *)move;
- (SymbolCell *)lastMoveInGame;

@end

@protocol PlayerProtocol <NSObject>

@required
- (void)takeTurn;
- (void)setSymbol:(Symbol)symbol;
- (Symbol)symbol;
- (void)setDelegate:(id<PlayerDelegate>)delegate;
- (id<PlayerDelegate>)delegate;

@end

@interface Player : NSObject

@end
