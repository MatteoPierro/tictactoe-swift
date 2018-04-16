class Game {

    private var occupiedPositions = [Position: Player]()
    private var lastPlayer: Player! = nil
    private var status: Status = .started

    func play(_ position: Position) {
        if isOver() {
            return
        }

        if isPositionAlreadyPlayed(position) {
            status = .positionAlreadyPlayed
            return
        }

        lastPlayer = nextPlayer()
        occupy(position, from: lastPlayer)

        if hasWon(lastPlayer) {
            status = lastPlayer == .x
                ? .xWon
                : .oWon

            return
        }

        status = isDraw()
            ? .draw
            : .positionTaken
    }

    func nextPlayer() -> Player {
        return lastPlayer == .x
            ? .o
            : .x
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
        let winningSequences: Set<Set<Position>> = [
            [.topLeft, .topMiddle, .topRight],
            [.centerLeft, .centerMiddle, .centerRight],
            [.bottomLeft, .bottomMiddle, .bottomRight],
            [.topLeft, .centerLeft, .bottomLeft],
            [.topMiddle, .centerMiddle, .bottomMiddle],
            [.topRight, .centerRight, .bottomRight],
            [.topLeft, .centerMiddle, .bottomRight],
            [.topRight, .centerMiddle, .bottomLeft]
        ]

        let occupiedPositions = occupiedPositionsBy(player!)

        return winningSequences.first(where: { isWinningSequence(occupiedPositions, winningSequence: $0) }) != nil
    }

    private func isWinningSequence(_ occupiedPositions: Set<Position>, winningSequence: Set<Position>) -> Bool {
        return winningSequence.isSubset(of: occupiedPositions)
    }

    private func isDraw() -> Bool {
        return occupiedPositions.count == 9
    }

    private func isOver() -> Bool {
        return [.draw, .xWon, .oWon].contains(status)
    }
}
