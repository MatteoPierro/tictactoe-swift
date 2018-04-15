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
}
