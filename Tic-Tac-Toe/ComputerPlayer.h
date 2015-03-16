//
//  ComputerPlayer.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "Player.h"

@class TicTacToeStrategy;

@interface ComputerPlayer : NSObject <PlayerProtocol>

- (instancetype)initWithStrategy:(TicTacToeStrategy *)strategy;

- (void)cleanup;

@end
