class Game {
    
    private var occupatedPositions = Set<Position>()
    private var currentPlayer: Player? = nil
    
    func play(_ position: Position) -> Status {
        if occupatedPositions.contains(position) {
            return Status.positionAlreadyPlayed
        }
        
        currentPlayer = nextPlayer()
        occupatedPositions.insert(position)
        return Status.positionTaken
    }
    
    func nextPlayer() -> Player {
        if currentPlayer?.hashValue == Player.x.hashValue {
            return Player.o
        }
        
        return Player.x
    }
}
