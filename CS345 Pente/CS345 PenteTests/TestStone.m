/**
 @file TestStone.m
 @brief Part of CS345 Pente
 @author Bryant Adams
 @date 3/15/13
 @copyright GNU Public License v3 or later, 2013
 @version 1.0
*/

    // Class under test
#import "CSPStone.h"

    // Collaborators
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
 @brief For testing Stone
 */
@interface TestStone : SenTestCase
@end

@implementation TestStone
{
    // test fixture ivars go here
    CSPStone *sut;
    id<CSPMoveInterface> placement;
    CSPStone * buddy;
}

- (void)setUp
{
    [super setUp];
    placement = [CSPMove moveWithPlayer:CSPID_PlayerBlack
                                    atX:3 andY:4];
    sut = [[CSPStone alloc] initWithPlacement:placement];
    buddy = [[CSPStone alloc] initWithPlacement:placement];
}

- (void)tearDown
{
    placement=nil;
    sut=nil;
    [super tearDown];
}

#pragma mark Tests

- (void)testDumbInitYieldsNil
{
    sut = [[CSPStone alloc] init];
    assertThat(sut, is(equalTo(nil)));
}
- (void)testNilInitYieldsNil
{
    sut = [[CSPStone alloc] initWithPlacement:nil];
    assertThat(sut, is(equalTo(nil)));
}
- (void)testStoneInitStoresPlacement
{
    assertThat(sut, isNot(equalTo(nil)));
    assertThat([sut placement], isNot(equalTo(nil)));
}
-(void)testNewStoneHasNoNeighbors
{
    assertThatUnsignedInteger([sut neighborCount], is(@0));
}
-(void)testAddingNeighborToNewStoneMakesNeighborSetNonempty
{

    [sut setNeighborTo:buddy
           inDirection:CSDID_SouthEast];

    assertThatUnsignedInteger([sut neighborCount], is(@1));
}
-(void)testAddingNeighborLeavesAddedNeighborInRightDirection
{
    [sut setNeighborTo:buddy
           inDirection:CSDID_SouthEast];

    assertThat([sut neighborInDirection:CSDID_SouthEast],
               is(buddy));
}
-(void)testRemovingNeighborClearsDirection
{
    [sut setNeighborTo:nil
           inDirection:CSDID_SouthEast];

    assertThat([sut neighborInDirection:CSDID_SouthEast],
               is(equalTo(nil)));
}
-(void)testRemovingNeighborReducesCount
{
    [sut setNeighborTo:nil
           inDirection:CSDID_SouthEast];
    
    assertThatUnsignedInteger([sut neighborCount], is(@0));
}

-(void)testNewStoneHasNoChainToSE
{
    assertThatUnsignedInteger([sut chainLengthIn:CSDID_SouthEast], is(@0));
}
-(void)testAddingSEStoneIncreasesSEChainToOne
{
    [sut setNeighborTo:buddy
           inDirection:CSDID_SouthEast];
    assertThatUnsignedInteger([sut chainLengthIn:CSDID_SouthEast], is(@1));
}
-(void)testAddingSEStoneWithSENeighborIncreasesSEChainToTwo
{
    CSPStone * buddybuddy = [[CSPStone alloc] initWithPlacement:placement];
    [buddy setNeighborTo:buddybuddy
             inDirection:CSDID_SouthEast];
    [sut setNeighborTo:buddy
           inDirection:CSDID_SouthEast];
    assertThatUnsignedInteger([sut chainLengthIn:CSDID_SouthEast], is(@2));
}
-(void)testNewStoneHasMaxChainOfOne
{
    assertThatUnsignedInteger([sut longestChainLength], is(@1));
}
-(void)testAddingSEStoneIncreasesMaxChainToTwo
{
    [sut setNeighborTo:buddy
           inDirection:CSDID_SouthEast];
    assertThatUnsignedInteger([sut longestChainLength], is(@2));
}
-(void)testAddingWrongColorExtraSEStoneLeavesMaxChainAtTwo
{
    id<CSPMoveInterface> whitePlacement;
    whitePlacement = [[CSPMove alloc] initWithPlayer:CSPID_PlayerWhite
                                                 atX:2 andY:3];
    CSPStone *buddybuddy = [[CSPStone alloc] initWithPlacement:whitePlacement];
    [sut setNeighborTo:buddy
           inDirection:CSDID_SouthEast];
    [buddy setNeighborTo:buddybuddy
             inDirection:CSDID_SouthEast];
    assertThatUnsignedInteger([sut longestChainLength], is(@2));
}

-(void)testNewStoneBookendsNothing
{
    assertThat([sut bookendedStones], is(empty()));
}

-(void)testNewStoneBookendsNothingToTheSE
{
    assertThat([sut bookendedStonesIn:CSDID_SouthEast], is(empty()));
}

-(void)testStoneWithSEBookendKnowsItHasSECapture
{
    id<CSPMoveInterface> whitePlacement;
    whitePlacement = [[CSPMove alloc] initWithPlayer:CSPID_PlayerWhite
                                                 atX:2 andY:3];
    CSPStone *theBookend = [[CSPStone alloc] initWithPlacement:placement];
    CSPStone *captiveOne = [[CSPStone alloc] initWithPlacement:whitePlacement];
    CSPStone *captiveTwo = [[CSPStone alloc] initWithPlacement:whitePlacement];
    [sut setNeighborTo:captiveOne inDirection:CSDID_SouthEast];
    [captiveOne setNeighborTo:captiveTwo inDirection:CSDID_SouthEast];
    [captiveTwo setNeighborTo:theBookend inDirection:CSDID_SouthEast];

    assertThat([sut bookendedStonesIn:CSDID_SouthEast], isNot(empty()));
}

-(void)testStoneWithSEBookendKnowsItHasCaptures
{
    id<CSPMoveInterface> whitePlacement;
    whitePlacement = [[CSPMove alloc] initWithPlayer:CSPID_PlayerWhite
                                                 atX:2 andY:3];
    CSPStone *theBookend = [[CSPStone alloc] initWithPlacement:placement];
    CSPStone *captiveOne = [[CSPStone alloc] initWithPlacement:whitePlacement];
    CSPStone *captiveTwo = [[CSPStone alloc] initWithPlacement:whitePlacement];
    [sut setNeighborTo:captiveOne inDirection:CSDID_SouthEast];
    [captiveOne setNeighborTo:captiveTwo inDirection:CSDID_SouthEast];
    [captiveTwo setNeighborTo:theBookend inDirection:CSDID_SouthEast];

    assertThat([sut bookendedStones], isNot(empty()));
}

-(void)testStoneWithNWBookendKnowsItHasCaptures
{
    id<CSPMoveInterface> whitePlacement;
    whitePlacement = [[CSPMove alloc] initWithPlayer:CSPID_PlayerWhite
                                                 atX:2 andY:3];
    CSPStone *theBookend = [[CSPStone alloc] initWithPlacement:placement];
    CSPStone *captiveOne = [[CSPStone alloc] initWithPlacement:whitePlacement];
    CSPStone *captiveTwo = [[CSPStone alloc] initWithPlacement:whitePlacement];
    [sut setNeighborTo:captiveOne inDirection:CSDID_NorthWest];
    [captiveOne setNeighborTo:captiveTwo inDirection:CSDID_NorthWest];
    [captiveTwo setNeighborTo:theBookend inDirection:CSDID_NorthWest];

    assertThat([sut bookendedStones], isNot(empty()));
}

-(void)testStoneWithNWBookendKnowsWhichCapturesItHas
{
    id<CSPMoveInterface> whitePlacement;
    whitePlacement = [[CSPMove alloc] initWithPlayer:CSPID_PlayerWhite
                                                 atX:2 andY:3];
    CSPStone *theBookend = [[CSPStone alloc] initWithPlacement:placement];
    CSPStone *captiveOne = [[CSPStone alloc] initWithPlacement:whitePlacement];
    CSPStone *captiveTwo = [[CSPStone alloc] initWithPlacement:whitePlacement];
    [sut setNeighborTo:captiveOne inDirection:CSDID_NorthWest];
    [captiveOne setNeighborTo:captiveTwo inDirection:CSDID_NorthWest];
    [captiveTwo setNeighborTo:theBookend inDirection:CSDID_NorthWest];

    assertThat([sut bookendedStones], containsInAnyOrder(captiveOne, captiveTwo, nil));
}

#pragma mark Helper methods

@end
