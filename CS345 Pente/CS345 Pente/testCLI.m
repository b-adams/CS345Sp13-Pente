#import "testCLI.h"
#import <Foundation/Foundation.h>
#import "CSPGollumInTheCloset.h"
#import "CSPMove.h"
// TODO: Add -makeMoveForPlayer:atX:andY: factory method to Gollum

CSPPlayerID getPlayer(char playerLetter);
int getCoordinate(int coordValue, char coordName);
id<CSPMoveInterface> getMove();

void runCLI()
{
    id<CSPPenteGameModelInterface> theGame=nil;
    theGame = [[CSPGollumInTheCloset alloc] init];
    do
    {
        id<CSPMoveInterface> theMove = nil;
        do {
            theMove = getMove();
            printf("Checking if %s is a legal move...\n",
                   [[theMove description] UTF8String]);
        } while (![theGame isLegalMove:theMove]);
        
        [theGame makeMove:theMove];
        printf("%s", [[theGame description] UTF8String]);
    } while([theGame gameOverState]==CSPGO_GameNotOver);
    printf("Game over!\n");
}

id<CSPMoveInterface> getMove()
{
    printf("Enter a move in the format:\nP X Y\nWhere P is the player letter (W or B)\nand X,Y are coordinates 0-18\n");
    char playerLetter;
    int x, y;
    scanf(" %c %d %d", &playerLetter, &x, &y);
    CSPPlayerID thePlayer = getPlayer(playerLetter);
    x = getCoordinate(x, 'X');
    y = getCoordinate(y, 'Y');
    return [CSPMove moveWithPlayer:thePlayer atX:x andY:y];
}

CSPPlayerID getPlayer(char playerLetter)
{
    while(playerLetter!='W' && playerLetter!='B')
    {
        printf("%c is not a valid player letter\n", playerLetter);
        printf("Please enter W or B:");
        scanf(" %c", &playerLetter);
    }
    switch(playerLetter)
    {
        case 'W': return CSPID_PlayerWhite;
        case 'B': return CSPID_PlayerBlack;
        default: return CSPID_NOBODY;
    }
}

int getCoordinate(int coordValue, char coordName)
{
    while(coordValue < 0 || coordValue > 18)
    {
        printf("%d is not a valid coordinate\n", coordValue);
        printf("Please enter a valid %c coordinate (0-18):", coordName);
        scanf(" %d", &coordValue);
    }
    return coordValue;
}