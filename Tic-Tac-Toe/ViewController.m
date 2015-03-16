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

@interface ViewController () <GameDelegate>

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
    HumanPlayer *human = [[HumanPlayer alloc] init];
    human.symbol = SymbolX;
    
    TicTacToeStrategy *statergy = [[TicTacToeStrategy alloc] initWithBoard:self.boardViewDelegateDatasource];
    ComputerPlayer *computer = [[ComputerPlayer alloc] initWithStrategy:statergy];
    computer.symbol = SymbolO;
    [statergy setPlayerSymbols:human.symbol mySymbol:computer.symbol];
    
    Game *game = [[Game alloc] initWithComputerPlayer:computer andHuman:human];
    [game setBoard:self.boardViewDelegateDatasource];
    
    self.gameSession = [[GameSession alloc] initWithGame:game];
    self.gameSession.delegate = self;
    [self.gameSession newGame];
}

#pragma mark GameDelegate

-(void)game:(Game *)game didEndWithStatus:(GameStatus)status winner:(id<PlayerProtocol>)player
{
    [self showAlertForStatus:status winner:player];
}

- (void)showAlertForStatus:(GameStatus)status winner:(id<PlayerProtocol>)player
{
    NSString *winnerTitle = nil;
    if (status == GameWin) {
        if ([player isKindOfClass:[ComputerPlayer class]]) {
            winnerTitle = @"I Win!";
        } else {
            winnerTitle = @"You Win!";
        }
    } else {
        winnerTitle = @"Game Draw, Try Again!";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:winnerTitle
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"ok"
                                          otherButtonTitles:nil];
    [alert show];
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
