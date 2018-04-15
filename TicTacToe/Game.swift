class Game {
    
    func play(_ position: Position) -> Status {
        return Status.positionAlreadyPlayed
    }
    
    func nextPlayer() -> Player {
        return Player.x
    }
}
