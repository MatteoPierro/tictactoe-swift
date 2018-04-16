import XCTest

class GameTest: XCTestCase {

    var game: Game!

    override func setUp() {
        game = Game()
    }

    func testXAlwaysGoesFirst() {
        XCTAssertEqual(game.nextPlayer, .x)
    }

    func testPlayersCannotPlayOnAPlayedPosition() {
        game.play(.topLeft)
        game.play(.topLeft)

        XCTAssertEqual(game.status, .positionAlreadyPlayed)
    }

    func testPlayersCanTakeANotPlayedPosition() {
        game.play(.topLeft)
        game.play(.topMiddle)

        XCTAssertEqual(game.status, .positionTaken)
    }

    func testPlayersAlternatePlacingXandO() {
        game.play(.topLeft)

        XCTAssertEqual(game.nextPlayer, .o)
    }

    // X' O' X'
    // X' O' O'
    // O' X' X'
    func testTheGameIsADrawWhenAllNineSquaresAreFilledAndNeitherPlayerHasThreeInARow() {
        game.play(.topLeft)
        game.play(.topMiddle)
        game.play(.topRight)
        game.play(.centerMiddle)
        game.play(.centerLeft)
        game.play(.centerRight)
        game.play(.bottomMiddle)
        game.play(.bottomLeft)
        game.play(.bottomRight)

        XCTAssertEqual(game.status, .draw)
    }

    // X' X' X' ---> win
    // O'
    // O'
    func testXWinsTakingAllTheTopRow() {
        game.play(.topLeft)
        game.play(.centerLeft)
        game.play(.topMiddle)
        game.play(.bottomLeft)
        game.play(.topRight)

        XCTAssertEqual(game.status, .xWon)
    }

    // O' O' O' ---> win
    // X' X'
    // X'
    func testOWinsTakingAllTheTopRow() {
        game.play(.bottomLeft)
        game.play(.topLeft)
        game.play(.centerLeft)
        game.play(.topMiddle)
        game.play(.centerMiddle)
        game.play(.topRight)

        XCTAssertEqual(game.status, .oWon)
    }

    // O'
    // X' X' X' ---> win
    // O'
    func testXWinsTakingAllTheCenterRow() {
        game.play(.centerLeft)
        game.play(.topLeft)
        game.play(.centerMiddle)
        game.play(.bottomLeft)
        game.play(.centerRight)

        XCTAssertEqual(game.status, .xWon)
    }

    // X'
    // O' O' O' ---> win
    // X' X'
    func testOWinsTakingAllTheCenterRow() {
        game.play(.bottomMiddle)
        game.play(.centerLeft)
        game.play(.topLeft)
        game.play(.centerMiddle)
        game.play(.bottomLeft)
        game.play(.centerRight)

        XCTAssertEqual(game.status, .oWon)
    }

    // O'
    // O'
    // X' X' X' ---> win
    func testXWinsTakingAllTheBottomRow() {
        game.play(.bottomLeft)
        game.play(.topLeft)
        game.play(.bottomMiddle)
        game.play(.centerLeft)
        game.play(.bottomRight)

        XCTAssertEqual(game.status, .xWon)
    }

    // X' X'
    // X'
    // O' O' O' ---> win
    func testOWinsTakingAllTheBottomRow() {
        game.play(.topMiddle)
        game.play(.bottomLeft)
        game.play(.topLeft)
        game.play(.bottomMiddle)
        game.play(.centerLeft)
        game.play(.bottomRight)

        XCTAssertEqual(game.status, .oWon)
    }

    // X'
    // X' O'
    // X' O'
    func testXWinsTakingAllTheLeftColumn() {
        game.play(.bottomLeft)
        game.play(.bottomMiddle)
        game.play(.centerLeft)
        game.play(.centerMiddle)
        game.play(.topLeft)

        XCTAssertEqual(game.status, .xWon)
    }

    // O' X' X'
    // O'
    // O' X'
    func testOWinsTakingAllTheLeftColumn() {
        game.play(.topMiddle)
        game.play(.bottomLeft)
        game.play(.bottomMiddle)
        game.play(.centerLeft)
        game.play(.topRight)
        game.play(.topLeft)

        XCTAssertEqual(game.status, .oWon)
    }

    //    X'
    //    X' O'
    //    X' O'
    func testXWinsTakingAllTheMiddleColumn() {
        game.play(.bottomMiddle)
        game.play(.bottomRight)
        game.play(.centerMiddle)
        game.play(.centerRight)
        game.play(.topMiddle)

        XCTAssertEqual(game.status, .xWon)
    }

    // X' O'
    //    O' X'
    //    O' X'
    func testOWinsTakingAllTheMiddleColumn() {
        game.play(.topLeft)
        game.play(.bottomMiddle)
        game.play(.bottomRight)
        game.play(.centerMiddle)
        game.play(.centerRight)
        game.play(.topMiddle)

        XCTAssertEqual(game.status, .oWon)
    }

    //    O' X'
    //    O' X'
    //       X'
    func testXWinsTakingAllTheRightColumn() {
        game.play(.bottomRight)
        game.play(.centerMiddle)
        game.play(.centerRight)
        game.play(.topMiddle)
        game.play(.topRight)

        XCTAssertEqual(game.status, .xWon)
    }

    // X' X' O'
    //    X' O'
    //       O'
    func testOWinsTakingAllTheRightColumn() {
        game.play(.topLeft)
        game.play(.bottomRight)
        game.play(.centerMiddle)
        game.play(.centerRight)
        game.play(.topMiddle)
        game.play(.topRight)

        XCTAssertEqual(game.status, .oWon)
    }

    //  X' O'
    //     X' O'
    //        X'
    func testXWinsTakingAllTheDiagonalStartingFromTopLeft() {
        game.play(.topLeft)
        game.play(.topMiddle)
        game.play(.centerMiddle)
        game.play(.centerRight)
        game.play(.bottomRight)

        XCTAssertEqual(game.status, .xWon)
    }

    //  O' X'
    //  X' O' X'
    //        O'
    func testOWinsTakingAllTheDiagonalStartingFromTopLeft() {
        game.play(.centerLeft)
        game.play(.topLeft)
        game.play(.topMiddle)
        game.play(.centerMiddle)
        game.play(.centerRight)
        game.play(.bottomRight)

        XCTAssertEqual(game.status, .oWon)
    }

    //     O' X'
    //     X' O'
    //  X'
    func testXWinsTakingAllTheDiagonalStartingFromTopRight() {
        game.play(.topRight)
        game.play(.topMiddle)
        game.play(.centerMiddle)
        game.play(.centerRight)
        game.play(.bottomLeft)

        XCTAssertEqual(game.status, .xWon)
    }

    //  X' X' O'
    //     O' X'
    //  O'
    func testOWinsTakingAllTheDiagonalStartingFromTopRight() {
        game.play(.topLeft)
        game.play(.topRight)
        game.play(.topMiddle)
        game.play(.centerMiddle)
        game.play(.centerRight)
        game.play(.bottomLeft)

        XCTAssertEqual(game.status, .oWon)
    }

    func testNotPermitFurtherPlayAfterGameIsWon() {
        game.play(.topRight)
        game.play(.topMiddle)
        game.play(.centerMiddle)
        game.play(.centerRight)
        game.play(.bottomLeft)
        game.play(.bottomMiddle)

        XCTAssertEqual(game.status, .xWon)
    }
}
