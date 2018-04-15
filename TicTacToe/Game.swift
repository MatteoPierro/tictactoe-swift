class Game {
    
    private var occupiedPositions = [Position: Player]()
    private var lastPlayer: Player! = nil
    
    func play(_ position: Position) -> Status {
        if isPositionAlreadyPlayed(position) {
            return Status.positionAlreadyPlayed
        }
        
        lastPlayer = nextPlayer()
        occupy(position, from: lastPlayer)
        
        if hasWon(lastPlayer) {
            return lastPlayer == Player.x
                ? Status.xWon
                : Status.oWon
        }

        return isDraw()
            ? Status.draw
            : Status.positionTaken
    }
    
    func nextPlayer() -> Player {
        return lastPlayer == Player.x
            ? Player.o
            : Player.x
    }
    
    private func isPositionAlreadyPlayed(_ position: Position) -> Bool {
        return occupiedPositions.keys.contains(position)
    }

    private func occupy(_ position: Position, from: Player) {
        occupiedPositions[position] = from
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
