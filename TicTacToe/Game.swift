class Game {
    
    private var occupatedPositions = Set<Position>()
    
    func play(_ position: Position) -> Status {
        if occupatedPositions.contains(position) {
            return Status.positionAlreadyPlayed
        }
        
        occupatedPositions.insert(position)
        return Status.positionTaken
    }
    
    func nextPlayer() -> Player {
        return Player.x
    }
}
