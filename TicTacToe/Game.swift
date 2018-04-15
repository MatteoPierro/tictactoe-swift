class Game {
    
    private var occupatedPositions = [Position: Player]()
    private var currentPlayer: Player! = nil
    
    func play(_ position: Position) -> Status {
        if occupatedPositions.keys.contains(position) {
            return Status.positionAlreadyPlayed
        }
        
        currentPlayer = nextPlayer()
        occupatedPositions[position] = currentPlayer
        
        let winningSequence: Set = [Position.topLeft, Position.topMiddle, Position.topRight]
        let positionsOccupatedByX = occupatedPositions.filter { $0.value == Player.x}.keys
        if winningSequence.isSubset(of: positionsOccupatedByX) {
            return Status.xWon
        }

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
