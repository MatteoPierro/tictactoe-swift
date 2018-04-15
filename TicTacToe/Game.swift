class Game {
    
    private var occupiedPositions = [Position: Player]()
    private var currentPlayer: Player! = nil
    
    func play(_ position: Position) -> Status {
        if isPositionAlreadyPlayed(position) {
            return Status.positionAlreadyPlayed
        }
        
        currentPlayer = nextPlayer()
        occupiedPositions[position] = currentPlayer
        
        if hasWon(currentPlayer) {
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
    
    private func isPositionAlreadyPlayed(_ position: Position) -> Bool {
        return occupiedPositions.keys.contains(position)
    }

    private func occupiedPositionsBy(_ player: Player) -> Set<Position> {
        return Set(occupiedPositions.filter { $0.value == player}.keys)
    }

    private func hasWon(_ player: Player!) -> Bool {
        let winningSequence: Set = [Position.topLeft, Position.topMiddle, Position.topRight]
        return winningSequence.isSubset(of: occupiedPositionsBy(player!))
    }

    private func isDraw() -> Bool {
        return occupiedPositions.count == 9;
    }
}
