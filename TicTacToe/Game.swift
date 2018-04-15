class Game {
    
    private var occupatedPositions = Set<Position>()
    private var currentPlayer: Player! = nil
    
    func play(_ position: Position) -> Status {
        if occupatedPositions.contains(position) {
            return Status.positionAlreadyPlayed
        }
        
        currentPlayer = nextPlayer()
        occupatedPositions.insert(position)
        
        return isDraw()
            ? Status.draw
            : Status.positionTaken
    }
    
    func nextPlayer() -> Player {
        return currentPlayer == Player.x
            ? Player.o
            : Player.x
    }
    
    private func isDraw() -> Bool {
        return occupatedPositions.count == 9;
    }
}
