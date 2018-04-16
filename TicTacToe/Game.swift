class Game {
    
    private var occupiedPositions = [Position: Player]()
    private var lastPlayer: Player! = nil
    private var status: Status = Status.started
    
    func play(_ position: Position) {
        if isOver() {
            return
        }

        if isPositionAlreadyPlayed(position) {
            status = Status.positionAlreadyPlayed
            return
        }
        
        lastPlayer = nextPlayer()
        occupy(position, from: lastPlayer)
        
        if hasWon(lastPlayer) {
            status = lastPlayer == Player.x
                ? Status.xWon
                : Status.oWon

            return
        }

        status = isDraw()
            ? Status.draw
            : Status.positionTaken
    }
    
    func nextPlayer() -> Player {
        return lastPlayer == Player.x
            ? Player.o
            : Player.x
    }
    
    func currentStatus() -> Status {
        return status
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
        let winningSequences: Set<Set> = [
            [Position.topLeft, Position.topMiddle, Position.topRight],
            [Position.centerLeft, Position.centerMiddle, Position.centerRight],
            [Position.bottomLeft, Position.bottomMiddle, Position.bottomRight],
            [Position.topLeft, Position.centerLeft, Position.bottomLeft],
            [Position.topMiddle, Position.centerMiddle, Position.bottomMiddle],
            [Position.topRight, Position.centerRight, Position.bottomRight],
            [Position.topLeft, Position.centerMiddle, Position.bottomRight],
            [Position.topRight, Position.centerMiddle, Position.bottomLeft]
        ]
        
        let occupiedPositions = occupiedPositionsBy(player!)
        
        return winningSequences.first(where: { isWinningSequence(occupiedPositions, winningSequence: $0) }) != nil
    }

    private func isWinningSequence(_ occupiedPositions: Set<Position>, winningSequence: Set<Position>) -> Bool {
        return winningSequence.isSubset(of: occupiedPositions)
    }

    private func isDraw() -> Bool {
        return occupiedPositions.count == 9;
    }
    
    private func isOver() -> Bool {
        return [Status.draw, Status.xWon, Status.oWon].contains(status)
    }
}
