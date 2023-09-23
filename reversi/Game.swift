//
//  Game.swift
//  reversi
//
//  Created by eric liu on 2023-09-17.
//

import Foundation

class Game{
    var board = GameBoard()
    var timePerMove:Double = 30
    let p1 = Player(colour:-1)
    let p2 = Player(colour:1)
    var activePlayer:Player
    
    init(){
        self.activePlayer = p1
    }
    
    init(timePerMove:Double){
        self.activePlayer = p1
    }
    /// Terrisa
    /// Checks if the one player has won the game
    func checkWin()->Bool{
        
        var p1AvaliableMove = p1.givePotientialMove(board: board).count
        if p1AvaliableMove != 0 {
            return false
        }
        
        var p2AvaliableMove = p2.givePotientialMove(board: board).count
        if p2AvaliableMove != 0 {
            return false
        }
        
        return true
    }
    
    /// Eric
    /// End a Players turn if they run out of time on their turn and plays a random move
    /// this function should be called when a player times out
    func timeOut()->Void{
        let moves = activePlayer.givePotientialMove(board: board);
        let a = Int.random(in: 0..<moves.count)
        board.update(move: [moves[a].0,moves[a].1], color: activePlayer.colour)
    }
    
}
