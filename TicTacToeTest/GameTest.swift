import XCTest

class GameTest: XCTestCase {

    func testXAlwaysGoesFirst() {
        let game = Game()
        
        XCTAssertEqual(game.nextPlayer(), Player.x)
    }
    
    func testPlayersCannotPlayOnAPlayedPosition() {
        let game = Game()
        
        game.play(Position.topLeft)
        let status = game.play(Position.topLeft)
        
        XCTAssertEqual(status, Status.positionAlreadyPlayed)
    }
}
