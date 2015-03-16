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

static const NSInteger kSymbolX = 1;
static const NSInteger kSymbolO = 2;

@interface ViewController () <GameDelegate>

@property (nonatomic,weak) IBOutlet BoardView *boardView;
@property Board *boardViewDelegateDatasource;
@property GameSession *gameSession;

//Initial view
@property (weak, nonatomic) IBOutlet UIView *initialView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

//game view
@property (weak, nonatomic) IBOutlet UILabel *computerSymbolLabel;

@end

@implementation ViewController
{
    Symbol _userSymbol;
    Symbol _computerSymbol;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.boardViewDelegateDatasource = [[Board alloc] initWithBoardView:self.boardView];
    self.boardView.delegate = self.boardViewDelegateDatasource;
    self.boardView.dataSource = self.boardViewDelegateDatasource;

    [self updateComputerSymbolLabel];
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

#pragma mark Storyboard Actions

- (IBAction)newGame:(UIButton *)btn
{
    [self.gameSession newGame];    
}

- (IBAction)startGame:(id)sender {
    [self setup];
    
    [UIView animateWithDuration:4.0 delay:0.2
         usingSpringWithDamping:0.6 initialSpringVelocity:0.5
                        options:UIViewAnimationOptionShowHideTransitionViews
                     animations:^{
                         CGRect exitFrame = self.initialView.bounds;
                         exitFrame.origin.y = -CGRectGetHeight(self.initialView.bounds)*2;
                         self.initialView.frame = exitFrame;
                     }
                     completion:^(BOOL finished) {
                         [self.gameSession newGame];
                     }];
}

- (IBAction)symbolSelected:(UIButton *)sender {
    
    [self resetSelection];
    switch (sender.tag) {
        case kSymbolO:
            _userSymbol = SymbolO;
            _computerSymbol = SymbolX;
            break;
        case kSymbolX:
            _computerSymbol = SymbolO;
            _userSymbol = SymbolX;
            break;
    }
    [sender setSelected:YES];
    self.startButton.enabled = YES;
    [self updateComputerSymbolLabel];
}

- (void)updateComputerSymbolLabel
{
    if (_computerSymbol == SymbolO) {
        self.computerSymbolLabel.text = @"O";
    } else if (_computerSymbol == SymbolX) {
        self.computerSymbolLabel.text = @"X";
    } else {
        self.computerSymbolLabel.text = @"";
    }
}

- (void)setup
{
    HumanPlayer *human = [[HumanPlayer alloc] init];
    human.symbol = _userSymbol;
    
    TicTacToeStrategy *statergy = [[TicTacToeStrategy alloc] initWithBoard:self.boardViewDelegateDatasource];
    ComputerPlayer *computer = [[ComputerPlayer alloc] initWithStrategy:statergy];
    computer.symbol = _computerSymbol;
    [statergy setPlayerSymbols:human.symbol mySymbol:computer.symbol];
    
    Game *game = [[Game alloc] initWithComputerPlayer:computer andHuman:human];
    [game setBoard:self.boardViewDelegateDatasource];
    
    self.gameSession = [[GameSession alloc] initWithGame:game];
    self.gameSession.delegate = self;
}

- (void)resetSelection
{
    UIButton *buttonX = (UIButton *)[self.initialView viewWithTag:kSymbolX];
    [buttonX setSelected:NO];
    UIButton *buttonO = (UIButton *)[self.initialView viewWithTag:kSymbolO];
    [buttonO setSelected:NO];
}

-(void)dealloc
{
    self.boardViewDelegateDatasource = nil;
    self.boardView.delegate = nil;
    self.boardView.dataSource = nil;
}

@end
