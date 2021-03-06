class Game {

    private var occupiedPositions = [Position: Player]()
    private var lastPlayer: Player?
    private (set) var status: Status = .started

    func play(_ position: Position) {
        if isOver {
            return
        }

        if isPositionAlreadyPlayed(position) {
            status = .positionAlreadyPlayed
            return
        }

        lastPlayer = nextPlayer
        guard let lastPlayer = lastPlayer else { return }
        occupy(position, from: lastPlayer)

        if hasWon(lastPlayer) {
            status = isLastPlayerX ? .xWon : .oWon
            return
        }

        status = isDraw ? .draw : .positionTaken
    }

    var nextPlayer: Player {
        return isLastPlayerX ? .o : .x
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

    private func hasWon(_ player: Player) -> Bool {
        let winningPositions: Set<Set<Position>> = [
            [.topLeft, .topMiddle, .topRight],
            [.centerLeft, .centerMiddle, .centerRight],
            [.bottomLeft, .bottomMiddle, .bottomRight],
            [.topLeft, .centerLeft, .bottomLeft],
            [.topMiddle, .centerMiddle, .bottomMiddle],
            [.topRight, .centerRight, .bottomRight],
            [.topLeft, .centerMiddle, .bottomRight],
            [.topRight, .centerMiddle, .bottomLeft]
        ]

        let occupiedPositions = occupiedPositionsBy(player)

        return winningPositions.first { isWinningPosition(occupiedPositions, winningPosition: $0) } != nil
    }

    private func isWinningPosition(_ occupiedPositions: Set<Position>, winningPosition: Set<Position>) -> Bool {
        return winningPosition.isSubset(of: occupiedPositions)
    }

    private var isDraw: Bool {
        return occupiedPositions.count == 9
    }

    private var isOver: Bool {
        return [.draw, .xWon, .oWon].contains(status)
    }

    private var isLastPlayerX: Bool {
        return lastPlayer == .x
    }
}
