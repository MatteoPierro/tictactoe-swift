class Game {
    
    func play(_ position: Position) -> Status {
        return Status.POSITION_ALREADY_PLAYED
    }
    
    func nextPlayer() -> Player {
        return Player.X
    }
}
