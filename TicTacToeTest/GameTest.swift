import XCTest

class GameTest: XCTestCase {

    func testXAlwaysGoesFirst() {
        let game = Game()
        
        XCTAssertEqual(game.nextPlayer(), Player.X)
    }
    
    func testPlayersCannotPlayOnAPlayedPosition() {
        let game = Game()
        
        game.play(Position.TOP_LEFT)
        let status = game.play(Position.TOP_LEFT)
        
        XCTAssertEqual(status, Status.POSITION_ALREADY_PLAYED)
    }
}
