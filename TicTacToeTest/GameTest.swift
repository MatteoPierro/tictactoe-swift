import XCTest

class GameTest: XCTestCase {

    func testXAlwaysGoesFirst() {
        let game = Game()
        
        XCTAssertEqual(game.nextPlayer(), Player.X)
    }
    
}
