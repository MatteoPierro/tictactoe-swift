import XCTest

class GameTest: XCTestCase {
    
    var game: Game!
    
    override func setUp() {
        game = Game()
    }

    func testXAlwaysGoesFirst() {
        XCTAssertEqual(game.nextPlayer(), Player.x)
    }
    
    func testPlayersCannotPlayOnAPlayedPosition() {
        game.play(Position.topLeft)
        game.play(Position.topLeft)
        
        XCTAssertEqual(game.currentStatus(), Status.positionAlreadyPlayed)
    }
    
    func testPlayersCanTakeANotPlayedPosition() {
        game.play(Position.topLeft)
        game.play(Position.topMiddle)
        
        XCTAssertEqual(game.currentStatus(), Status.positionTaken)
    }
    
    func testPlayersAlternatePlacingXandO() {
        game.play(Position.topLeft)
        
        XCTAssertEqual(game.nextPlayer(), Player.o)
    }
    
    // X' O' X'
    // X' O' O'
    // O' X' X'
    func testTheGameIsADrawWhenAllNineSquaresAreFilledAndNeitherPlayerHasThreeInARow() {
        game.play(Position.topLeft)
        game.play(Position.topMiddle)
        game.play(Position.topRight)
        game.play(Position.centerMiddle)
        game.play(Position.centerLeft)
        game.play(Position.centerRight)
        game.play(Position.bottomMiddle)
        game.play(Position.bottomLeft)
        game.play(Position.bottomRight)
        
        XCTAssertEqual(game.currentStatus(), Status.draw)
    }
    
    // X' X' X' ---> win
    // O'
    // O'
    func testXWinsTakingAllTheTopRow() {
        game.play(Position.topLeft)
        game.play(Position.centerLeft)
        game.play(Position.topMiddle)
        game.play(Position.bottomLeft)
        game.play(Position.topRight)
        
        XCTAssertEqual(game.currentStatus(), Status.xWon)
    }

    // O' O' O' ---> win
    // X' X'
    // X'
    func testOWinsTakingAllTheTopRow() {
        game.play(Position.bottomLeft)
        game.play(Position.topLeft)
        game.play(Position.centerLeft)
        game.play(Position.topMiddle)
        game.play(Position.centerMiddle)
        game.play(Position.topRight)

        XCTAssertEqual(game.currentStatus(), Status.oWon)
    }
    
    // O'
    // X' X' X' ---> win
    // O'
    func testXWinsTakingAllTheCenterRow() {
        game.play(Position.centerLeft)
        game.play(Position.topLeft)
        game.play(Position.centerMiddle)
        game.play(Position.bottomLeft)
        game.play(Position.centerRight)
        
        XCTAssertEqual(game.currentStatus(), Status.xWon)
    }
    
    // X'
    // O' O' O' ---> win
    // X' X'
    func testOWinsTakingAllTheCenterRow() {
        game.play(Position.bottomMiddle)
        game.play(Position.centerLeft)
        game.play(Position.topLeft)
        game.play(Position.centerMiddle)
        game.play(Position.bottomLeft)
        game.play(Position.centerRight)
        
        XCTAssertEqual(game.currentStatus(), Status.oWon)
    }
    
    // O'
    // O'
    // X' X' X' ---> win
    func testXWinsTakingAllTheBottomRow() {
        game.play(Position.bottomLeft)
        game.play(Position.topLeft)
        game.play(Position.bottomMiddle)
        game.play(Position.centerLeft)
        game.play(Position.bottomRight)
        
        XCTAssertEqual(game.currentStatus(), Status.xWon)
    }
    
    // X' X'
    // X'
    // O' O' O' ---> win
    func testOWinsTakingAllTheBottomRow() {
        game.play(Position.topMiddle)
        game.play(Position.bottomLeft)
        game.play(Position.topLeft)
        game.play(Position.bottomMiddle)
        game.play(Position.centerLeft)
        game.play(Position.bottomRight)
        
        XCTAssertEqual(game.currentStatus(), Status.oWon)
    }
    
    // X'
    // X' O'
    // X' O'
    func testXWinsTakingAllTheLeftColumn() {
        game.play(Position.bottomLeft)
        game.play(Position.bottomMiddle)
        game.play(Position.centerLeft)
        game.play(Position.centerMiddle)
        game.play(Position.topLeft)
        
        XCTAssertEqual(game.currentStatus(), Status.xWon)
    }
    
    // O' X' X'
    // O'
    // O' X'
    func testOWinsTakingAllTheLeftColumn() {
        game.play(Position.topMiddle)
        game.play(Position.bottomLeft)
        game.play(Position.bottomMiddle)
        game.play(Position.centerLeft)
        game.play(Position.topRight)
        game.play(Position.topLeft)
        
        XCTAssertEqual(game.currentStatus(), Status.oWon)
    }
    
    //    X'
    //    X' O'
    //    X' O'
    func testXWinsTakingAllTheMiddleColumn() {
        game.play(Position.bottomMiddle)
        game.play(Position.bottomRight)
        game.play(Position.centerMiddle)
        game.play(Position.centerRight)
        game.play(Position.topMiddle)
        
        XCTAssertEqual(game.currentStatus(), Status.xWon)
    }
    
    // X' O'
    //    O' X'
    //    O' X'
    func testOWinsTakingAllTheMiddleColumn() {
        game.play(Position.topLeft)
        game.play(Position.bottomMiddle)
        game.play(Position.bottomRight)
        game.play(Position.centerMiddle)
        game.play(Position.centerRight)
        game.play(Position.topMiddle)
        
        XCTAssertEqual(game.currentStatus(), Status.oWon)
    }

    //    O' X'
    //    O' X'
    //       X'
    func testXWinsTakingAllTheRightColumn() {
        game.play(Position.bottomRight)
        game.play(Position.centerMiddle)
        game.play(Position.centerRight)
        game.play(Position.topMiddle)
        game.play(Position.topRight)

        XCTAssertEqual(game.currentStatus(), Status.xWon)
    }

    // X' X' O'
    //    X' O'
    //       O'
    func testOWinsTakingAllTheRightColumn() {
        game.play(Position.topLeft)
        game.play(Position.bottomRight)
        game.play(Position.centerMiddle)
        game.play(Position.centerRight)
        game.play(Position.topMiddle)
        game.play(Position.topRight)
        
        XCTAssertEqual(game.currentStatus(), Status.oWon)
    }

    //  X' O'
    //     X' O'
    //        X'
    func testXWinsTakingAllTheDiagonalStartingFromTopLeft() {
        game.play(Position.topLeft)
        game.play(Position.topMiddle)
        game.play(Position.centerMiddle)
        game.play(Position.centerRight)
        game.play(Position.bottomRight)

        XCTAssertEqual(game.currentStatus(), Status.xWon)
    }

    //  O' X'
    //  X' O' X'
    //        O'
    func testOWinsTakingAllTheDiagonalStartingFromTopLeft() {
        game.play(Position.centerLeft)
        game.play(Position.topLeft)
        game.play(Position.topMiddle)
        game.play(Position.centerMiddle)
        game.play(Position.centerRight)
        game.play(Position.bottomRight)

        XCTAssertEqual(game.currentStatus(), Status.oWon)
    }
    
    //     O' X'
    //     X' O'
    //  X'
    func testXWinsTakingAllTheDiagonalStartingFromTopRight() {
        game.play(Position.topRight)
        game.play(Position.topMiddle)
        game.play(Position.centerMiddle)
        game.play(Position.centerRight)
        game.play(Position.bottomLeft)
        
        XCTAssertEqual(game.currentStatus(), Status.xWon)
    }
    
    //  X' X' O'
    //     O' X'
    //  O'
    func testOWinsTakingAllTheDiagonalStartingFromTopRight() {
        game.play(Position.topLeft)
        game.play(Position.topRight)
        game.play(Position.topMiddle)
        game.play(Position.centerMiddle)
        game.play(Position.centerRight)
        game.play(Position.bottomLeft)
        
        XCTAssertEqual(game.currentStatus(), Status.oWon)
    }
    
    func testNotPermitFurtherPlayAfterGameIsWon() {
        game.play(Position.topRight)
        game.play(Position.topMiddle)
        game.play(Position.centerMiddle)
        game.play(Position.centerRight)
        game.play(Position.bottomLeft)
        game.play(Position.bottomMiddle)
        
        XCTAssertEqual(game.currentStatus(), Status.xWon)
    }
}
