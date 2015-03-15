//
//  GameSession.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Game;
@protocol PlayerProtocol;

@interface GameSession : NSObject

@property id <PlayerProtocol> lastWinner;

- (instancetype)initWithGame:(Game *)game;
- (void)newGame;
- (void)quit;

@end
