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
        let status = game.play(Position.topLeft)
        
        XCTAssertEqual(status, Status.positionAlreadyPlayed)
    }
    
    func testPlayersCanTakeANotPlayedPosition() {
        game.play(Position.topLeft)
        let status = game.play(Position.topMiddle)
        
        XCTAssertEqual(status, Status.positionTaken)
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
        let state = game.play(Position.bottomRight)
        
        XCTAssertEqual(state, Status.draw)
    }
    
    // X X X ---> win
    // O
    // O
    func _testXWinsTakingAllTheTopRow() {
        game.play(Position.topLeft)
        game.play(Position.centerLeft)
        game.play(Position.topMiddle)
        game.play(Position.bottomLeft)
        let state = game.play(Position.topRight)
        
        XCTAssertEqual(state, Status.xWon)
    }
}
