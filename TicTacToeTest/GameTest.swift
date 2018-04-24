import XCTest

class GameTest: XCTestCase {

    private var game: Game!

    override func setUp() {
        super.setUp()
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

    /// X' O' X'
    /// X' O' O'
    /// O' X' X'
    func testTheGameIsADrawWhenAllNineSquaresAreFilledAndNeitherPlayerHasThreeInARow() {
        game.play(x: [.topLeft, .topRight, .centerLeft, .bottomMiddle, .bottomRight],
                  o: [.topMiddle, .centerMiddle, .centerRight, .bottomLeft])

        XCTAssertEqual(game.status, .draw)
    }

    /// X' X' X' ---> win
    /// O'
    /// O'
    func testXWinsTakingAllTheTopRow() {
        game.play(x: [.topLeft, .topMiddle, .topRight],
                  o: [.centerLeft, .bottomLeft])

        XCTAssertEqual(game.status, .xWon)
    }

    /// O' O' O' ---> win
    /// X' X'
    /// X'
    func testOWinsTakingAllTheTopRow() {
        game.play(x: [.bottomLeft, .centerLeft, .centerMiddle],
                  o: [.topLeft, .topMiddle, .topRight])

        XCTAssertEqual(game.status, .oWon)
    }

    /// O'
    /// X' X' X' ---> win
    /// O'
    func testXWinsTakingAllTheCenterRow() {
        game.play(x: [.centerLeft, .centerMiddle, .centerRight],
                  o: [.topLeft, .bottomLeft])

        XCTAssertEqual(game.status, .xWon)
    }

    /// X'
    /// O' O' O' ---> win
    /// X' X'
    func testOWinsTakingAllTheCenterRow() {
        game.play(x: [.bottomMiddle, .topLeft, .bottomLeft],
                  o: [.centerLeft, .centerMiddle, .centerRight])

        XCTAssertEqual(game.status, .oWon)
    }

    /// O'
    /// O'
    /// X' X' X' ---> win
    func testXWinsTakingAllTheBottomRow() {
        game.play(x: [.bottomLeft, .bottomMiddle, .bottomRight],
                  o: [.topLeft, .centerLeft])

        XCTAssertEqual(game.status, .xWon)
    }

    /// X' X'
    /// X'
    /// O' O' O' ---> win
    func testOWinsTakingAllTheBottomRow() {
        game.play(x: [.topMiddle, .topLeft, .centerLeft],
                  o: [.bottomLeft, .bottomMiddle, .bottomRight])

        XCTAssertEqual(game.status, .oWon)
    }

    /// X'
    /// X' O'
    /// X' O'
    func testXWinsTakingAllTheLeftColumn() {
        game.play(x: [.bottomLeft, .centerLeft, .topLeft],
                  o: [.bottomMiddle, .centerMiddle])

        XCTAssertEqual(game.status, .xWon)
    }

    /// O' X' X'
    /// O'
    /// O' X'
    func testOWinsTakingAllTheLeftColumn() {
        game.play(x: [.topMiddle, .bottomMiddle, .topRight],
                  o: [.bottomLeft, .centerLeft, .topLeft])

        XCTAssertEqual(game.status, .oWon)
    }

    ///    X'
    ///    X' O'
    ///    X' O'
    func testXWinsTakingAllTheMiddleColumn() {
        game.play(x: [.bottomMiddle, .centerMiddle, .topMiddle],
                  o: [.bottomRight, .centerRight])

        XCTAssertEqual(game.status, .xWon)
    }

    /// X' O'
    ///    O' X'
    ///    O' X'
    func testOWinsTakingAllTheMiddleColumn() {
        game.play(x: [.topLeft, .bottomRight, .centerRight],
                  o: [.bottomMiddle, .centerMiddle, .topMiddle])

        XCTAssertEqual(game.status, .oWon)
    }

    ///    O' X'
    ///    O' X'
    ///       X'
    func testXWinsTakingAllTheRightColumn() {
        game.play(x: [.bottomRight, .centerRight, .topRight],
                  o: [.centerMiddle, .topMiddle])

        XCTAssertEqual(game.status, .xWon)
    }

    /// X' X' O'
    ///    X' O'
    ///       O'
    func testOWinsTakingAllTheRightColumn() {
        game.play(x: [.topLeft, .centerMiddle, .topMiddle],
                  o: [.bottomRight, .centerRight, .topRight])

        XCTAssertEqual(game.status, .oWon)
    }

    ///  X' O'
    ///     X' O'
    ///        X'
    func testXWinsTakingAllTheDiagonalStartingFromTopLeft() {
        game.play(x: [.topLeft, .centerMiddle, .bottomRight],
                  o: [.topMiddle, .centerRight])

        XCTAssertEqual(game.status, .xWon)
    }

    ///  O' X'
    ///  X' O' X'
    ///        O'
    func testOWinsTakingAllTheDiagonalStartingFromTopLeft() {
        game.play(x: [.centerLeft, .topMiddle, .centerRight],
                  o: [.topLeft, .centerMiddle, .bottomRight])

        XCTAssertEqual(game.status, .oWon)
    }

    ///     O' X'
    ///     X' O'
    ///  X'
    func testXWinsTakingAllTheDiagonalStartingFromTopRight() {
        game.play(x: [.topRight, .centerMiddle, .bottomLeft],
                  o: [.topMiddle, .centerRight])

        XCTAssertEqual(game.status, .xWon)
    }

    ///  X' X' O'
    ///     O' X'
    ///  O'
    func testOWinsTakingAllTheDiagonalStartingFromTopRight() {
        game.play(x: [.topLeft, .topMiddle, .centerRight],
                  o: [.topRight, .centerMiddle, .bottomLeft])

        XCTAssertEqual(game.status, .oWon)
    }

    func testNotPermitFurtherPlayAfterGameIsWon() {
        game.play(x: [.topRight, .centerMiddle, .bottomLeft],
                  o: [.topMiddle, .centerRight, .bottomMiddle])

        XCTAssertEqual(game.status, .xWon)
    }
}

extension Game {
    func play(x: [Position], o: [Position]) {
        zip(x, o).forEach(play)
        
        if x.count > o.count, let xLastMove = x.last {
            play(xLastMove)
        }
    }

    func play(x: Position, o: Position) {
        play(x)
        play(o)
    }
}
