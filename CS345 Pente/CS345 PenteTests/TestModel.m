/**
 @file TestModel.m
 @brief Part of CS345 Pente
 @author Bryant Adams
 @date 3/15/13
 @copyright GNU Public License v3 or later, 2013
 @version 0.1
*/

    // Class under test
#import "CSPGollumInTheCloset.h"

    // Collaborators
#import "CSPPenteGameModelInterface.h"
#import "CSPMove.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

// Comment the next two lines to disable OCHamcrest (for test assertions)
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

// Comment the next two lines to disable OCMockito (for mock objects)
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

/**
 @brief For testing Gollum in the Closet model
 */
@interface TestModel : SenTestCase
@end

@implementation TestModel
{
    // test fixture ivars go here
    id<CSPPenteGameModelInterface> sut;
}

- (void)setUp
{
    [super setUp];
    sut = [[CSPGollumInTheCloset alloc] init];
    
}

- (void)tearDown
{
    sut = nil;
    [super tearDown];
}

#pragma mark Tests

- (void)testBoardSizeIsReasonable
{
    // given
    // when
    NSUInteger boardsize = [sut boardWidth];
    // then
    assertThatUnsignedInteger(boardsize, is(closeTo(19, 5)));
}

- (void)testWhitesSecondMoveIsAllowedRightOfCenterSeven
{
    // given
    [self makeMoveFor:CSPID_PlayerWhite atX:9 andY:9];
    [self makeMoveFor:CSPID_PlayerBlack atX:7 andY:8];
    // when
    // then
    [self testMoveFor:CSPID_PlayerWhite atX:13 andY:9 isLegal:YES];
}

- (void)testWhitesSecondMoveIsAllowedLeftOfCenterSeven
{
    // given
    [self makeMoveFor:CSPID_PlayerWhite atX:9 andY:9];
    [self makeMoveFor:CSPID_PlayerBlack atX:7 andY:8];
    // when
    // then
    [self testMoveFor:CSPID_PlayerWhite atX:4 andY:9 isLegal:YES];
}

- (void)testWhitesSecondMoveIsAllowedAboveOfCenterSeven
{
    // given
    [self makeMoveFor:CSPID_PlayerWhite atX:9 andY:9];
    [self makeMoveFor:CSPID_PlayerBlack atX:7 andY:8];
    // when
    // then
    [self testMoveFor:CSPID_PlayerWhite atX:9 andY:13 isLegal:YES];
}

- (void)testWhitesSecondMoveIsAllowedBelowCenterSeven
{
    // given
    [self makeMoveFor:CSPID_PlayerWhite atX:9 andY:9];
    [self makeMoveFor:CSPID_PlayerBlack atX:7 andY:8];
    // when
    // then
    [self testMoveFor:CSPID_PlayerWhite atX:9 andY:4 isLegal:YES];
}

- (void)testWhitesSecondMoveIsRestrictedInsideCenterSeven
{
    // given
    [self makeMoveFor:CSPID_PlayerWhite atX:9 andY:9];
    [self makeMoveFor:CSPID_PlayerBlack atX:7 andY:8];
    // when
    // then
    [self testMoveFor:CSPID_PlayerWhite atX:9 andY:12 isLegal:NO];
}

- (void)testBlackDoesNotMoveFirst
{
    // given
    // when
    // then
    [self testMoveFor:CSPID_PlayerBlack atX:9 andY:9 isLegal:NO];
}
- (void)testWhiteDoesMoveFirst
{
    // given
    // when
    // then
    [self testMoveFor:CSPID_PlayerWhite atX:9 andY:9 isLegal:YES];
}

- (void)testBlackDoesMoveSecond
{
    // given
    [self makeMoveFor:CSPID_PlayerWhite atX:9 andY:8];
    // when
    // then
    [self testMoveFor:CSPID_PlayerBlack atX:9 andY:9 isLegal:YES];
}
- (void)testWhiteDoesNotMoveSecond
{
    // given
    [self makeMoveFor:CSPID_PlayerBlack atX:7 andY:8];
    // when
    // then
    [self testMoveFor:CSPID_PlayerWhite atX:9 andY:9 isLegal:NO];
}

- (void)testCannotImmediatelyRepeatAMove
{
    // given
    [self makeMoveFor:CSPID_PlayerBlack atX:7 andY:8];
    // when
    // then
    [self testMoveFor:CSPID_PlayerBlack atX:7 andY:8 isLegal:NO];
}

- (void)testCannotPlaceOnPreviousStone
{
    // given
    [self makeMoveFor:CSPID_PlayerWhite atX:7 andY:8];
    [self makeMoveFor:CSPID_PlayerBlack atX:6 andY:8];
    [self makeMoveFor:CSPID_PlayerWhite atX:5 andY:8];
    [self makeMoveFor:CSPID_PlayerBlack atX:4 andY:8];
    // when
    // then
    [self testMoveFor:CSPID_PlayerWhite atX:7 andY:8 isLegal:NO];
}
- (void)testGameBeginsWithNobodyHavingWon
{
    // given
    // when
    // then
    assertThatUnsignedInteger([sut gameOverState], is(equalToInt(CSPGO_GameNotOver)));
}
- (void)testChainSizeStartsAtOne
{
    // given
    [self makeMoveFor:CSPID_PlayerWhite atX:7 andY:8];
    
    // when
    NSUInteger chainSize =[sut longestChainForStoneAt:[CSPLocation coordinateWithX:7 andY:8]];
    
    // then
    assertThatUnsignedInteger(chainSize, is(equalToInt(1)));
}
- (void)testChainSizeIncreasesWithAdjacentPlacement
{
    // given
    [self makeMoveFor:CSPID_PlayerWhite atX:7 andY:8];
    [self makeMoveFor:CSPID_PlayerWhite atX:8 andY:8];
    
    // when
    NSUInteger chainSize =[sut longestChainForStoneAt:[CSPLocation coordinateWithX:7 andY:8]];
    
    // then
    assertThatUnsignedInteger(chainSize, is(equalToInt(2)));
}

- (void)testCapturingClearsLocation
{
    // given
    [self makeMoveFor:CSPID_PlayerBlack atX:6 andY:8];
    [self makeMoveFor:CSPID_PlayerWhite atX:7 andY:8];
    [self makeMoveFor:CSPID_PlayerWhite atX:8 andY:8];
    // when
    [self makeMoveFor:CSPID_PlayerBlack atX:9 andY:8]; //Capture!
    
    // then
    [self testMoveFor:CSPID_PlayerWhite atX:7 andY:8 isLegal:YES];
}

- (void)testInitialCapturesAreZero
{
    assertThatUnsignedInteger([sut capturesByPlayer:CSPID_PlayerBlack],
                              is(@0));
}

- (void)testCapturingIncreasesCaptureCount
{
    // given
    [self makeMoveFor:CSPID_PlayerBlack atX:6 andY:8];
    [self makeMoveFor:CSPID_PlayerWhite atX:7 andY:8];
    [self makeMoveFor:CSPID_PlayerWhite atX:8 andY:8];
    // when
    [self makeMoveFor:CSPID_PlayerBlack atX:9 andY:8]; //Capture!
    
    // then
    assertThatUnsignedInteger([sut capturesByPlayer:CSPID_PlayerBlack],
                              is(@2));
}
- (void)testBoardWidthIsNineteen
{
    // then
    assertThatUnsignedInteger([sut boardWidth], is(@19));
}
- (void)testCaptureReducesChainLength
{
    // given
    [self makeMoveFor:CSPID_PlayerWhite atX:7 andY:8];
    [self makeMoveFor:CSPID_PlayerWhite atX:8 andY:8];
    [self makeMoveFor:CSPID_PlayerWhite atX:9 andY:8];
    [self makeMoveFor:CSPID_PlayerWhite atX:8 andY:9];
    [self makeMoveFor:CSPID_PlayerBlack atX:8 andY:10];
    CSPLocation* place = [CSPLocation coordinateWithX:7 andY:8];
    NSUInteger chainSize =[sut longestChainForStoneAt:place];
    assertThatUnsignedInteger(chainSize, is(equalToInt(3)));

    // when
    [self makeMoveFor:CSPID_PlayerBlack atX:8 andY:7]; //Capture!
    
    // then
    chainSize =[sut longestChainForStoneAt:place];
    assertThatUnsignedInteger(chainSize, is(equalToInt(1)));
}

- (void)testFifthWhiteInARowSetsGameoverForWhite
{
    // given
    [self makeMoveFor:CSPID_PlayerWhite atX:2 andY:8];
    [self makeMoveFor:CSPID_PlayerWhite atX:3 andY:8];
    [self makeMoveFor:CSPID_PlayerWhite atX:4 andY:8];
    [self makeMoveFor:CSPID_PlayerWhite atX:5 andY:8];
    assertThatInt([sut gameOverState], is(equalToInt(CSPGO_GameNotOver)));
    
    // when
    [self makeMoveFor:CSPID_PlayerWhite atX:6 andY:8]; //GameOver!

    // then
    assertThatInt([sut gameOverState], is(equalToInt(CSPGO_WhiteWins)));
    
}
- (void)testCompletingFiveBlackInARowSetsSetsGameoverForWhite
{
    // given
    [self makeMoveFor:CSPID_PlayerBlack atX:2 andY:8];
    [self makeMoveFor:CSPID_PlayerBlack atX:3 andY:8];
    [self makeMoveFor:CSPID_PlayerBlack atX:5 andY:8];
    [self makeMoveFor:CSPID_PlayerBlack atX:6 andY:8];
    assertThatInt([sut gameOverState], is(equalToInt(CSPGO_GameNotOver)));
    
    // when
    [self makeMoveFor:CSPID_PlayerBlack atX:4 andY:8];//GameOver!
    assertThatUnsignedInteger([sut longestChainForStoneAt:[CSPLocation coordinateWithX:4 andY:8]], is(@5));
    
    // then
    assertThatInt([sut gameOverState], is(equalToInt(CSPGO_BlackWins)));
    
}
- (void)testOverkillWinIsStillAWin
{
    // given
    [self makeMoveFor:CSPID_PlayerBlack atX:1 andY:8];
    [self makeMoveFor:CSPID_PlayerBlack atX:2 andY:8];
    [self makeMoveFor:CSPID_PlayerBlack atX:3 andY:8];
    //    [self makeMoveFor:CSPID_PlayerBlack atX:4 andY:8];
    [self makeMoveFor:CSPID_PlayerBlack atX:5 andY:8];
    [self makeMoveFor:CSPID_PlayerBlack atX:6 andY:8];
    [self makeMoveFor:CSPID_PlayerBlack atX:7 andY:8];
    
    //    [self makeMoveFor:CSPID_PlayerBlack atX:4 andY:8];
    [self makeMoveFor:CSPID_PlayerBlack atX:4 andY:9];
    [self makeMoveFor:CSPID_PlayerBlack atX:4 andY:10];
    [self makeMoveFor:CSPID_PlayerBlack atX:4 andY:11];
    [self makeMoveFor:CSPID_PlayerBlack atX:4 andY:12];
    
    assertThatInt([sut gameOverState], is(equalToInt(CSPGO_GameNotOver)));
    
    // when
    [self makeMoveFor:CSPID_PlayerBlack atX:4 andY:8];//GameOver two ways!
    assertThatUnsignedInteger([sut longestChainForStoneAt:[CSPLocation coordinateWithX:4 andY:8]], is(@7));
    
    // then
    assertThatInt([sut gameOverState], is(equalToInt(CSPGO_BlackWins)));
}
-(void)testThatCapturesCanLeadToAWin
{
    // given
    [self makeMoveFor:CSPID_PlayerBlack atX:7 andY:9];
    [self makeMoveFor:CSPID_PlayerBlack atX:8 andY:9];

    [self makeMoveFor:CSPID_PlayerBlack atX:7 andY:10];
    [self makeMoveFor:CSPID_PlayerBlack atX:8 andY:11];

    [self makeMoveFor:CSPID_PlayerBlack atX:9 andY:10];
    [self makeMoveFor:CSPID_PlayerBlack atX:9 andY:11];

    [self makeMoveFor:CSPID_PlayerBlack atX:10 andY:11];
    [self makeMoveFor:CSPID_PlayerBlack atX:11 andY:10];

    [self makeMoveFor:CSPID_PlayerBlack atX:10 andY:9];
    [self makeMoveFor:CSPID_PlayerBlack atX:11 andY:9];

    [self makeMoveFor:CSPID_PlayerWhite atX:6 andY:9];
    assertThatUnsignedInteger([sut capturesByPlayer:CSPID_PlayerWhite], is(@0));

    [self makeMoveFor:CSPID_PlayerWhite atX:12 andY:9];
    assertThatUnsignedInteger([sut capturesByPlayer:CSPID_PlayerWhite], is(@0));

    [self makeMoveFor:CSPID_PlayerWhite atX:9 andY:12];
    assertThatUnsignedInteger([sut capturesByPlayer:CSPID_PlayerWhite], is(@4));
    assertThatInt([sut gameOverState], is(equalToInt(CSPGO_GameNotOver)));

    // when
    [self makeMoveFor:CSPID_PlayerWhite atX:9 andY:9];
    assertThatUnsignedInteger([sut capturesByPlayer:CSPID_PlayerWhite], is(@10));
    
    // then
    assertThatInt([sut gameOverState], is(equalToInt(CSPGO_WhiteWins)));
}

#pragma mark Helper Methods

-(void) makeMoveFor:(CSPPlayerID)player atX:(int)x andY:(int)y
{
    CSPMove* theMove = [CSPMove moveWithPlayer:player
                                           atX:x
                                          andY:y];
    [sut makeMove:theMove];
}
-(void) testMoveFor:(CSPPlayerID)player
                atX:(int)x andY:(int)y
            isLegal:(BOOL) legality;
{
    CSPMove* theMove = [CSPMove moveWithPlayer:player
                                           atX:x
                                          andY:y];
    assertThatBool([sut isLegalMove:theMove], is(equalToBool(legality)));

}
@end
