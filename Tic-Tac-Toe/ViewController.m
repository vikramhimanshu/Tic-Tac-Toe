//
//  ViewController.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/13/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "ViewController.h"
#import "Board.h"
#import "BoardView.h"

#import "GameSession.h"
#import "Game.h"
#import "ComputerPlayer.h"
#import "HumanPlayer.h"

#import "Symbol.h"
#import "TicTacToeStrategy.h"

@interface ViewController ()

@property (nonatomic,weak) IBOutlet BoardView *boardView;
@property Board *boardViewDelegateDatasource;
@property GameSession *gameSession;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.boardViewDelegateDatasource = [[Board alloc] initWithBoardView:self.boardView];
    self.boardView.delegate = self.boardViewDelegateDatasource;
    self.boardView.dataSource = self.boardViewDelegateDatasource;
}

- (void)viewWillAppear:(BOOL)animated
{
    TicTacToeStrategy *statergy = [[TicTacToeStrategy alloc] initWithBoard:self.boardViewDelegateDatasource];
    ComputerPlayer *player1 = [[ComputerPlayer alloc] initWithStrategy:statergy];
    player1.symbol = SymbolO;
    
    HumanPlayer *player2 = [[HumanPlayer alloc] init];
    player2.symbol = SymbolX;
    
    Game *game = [[Game alloc] initWithComputerPlayer:player1 andHuman:player2];
    [game setBoard:self.boardViewDelegateDatasource];
    
    self.gameSession = [[GameSession alloc] initWithGame:game];
    [self.gameSession newGame];
}

- (IBAction)newGame:(UIButton *)btn
{
    [self.gameSession newGame];    
}

-(void)dealloc
{
    self.boardViewDelegateDatasource = nil;
    self.boardView.delegate = nil;
    self.boardView.dataSource = nil;
}

@end
