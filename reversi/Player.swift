//
//  Player.swift
//  reversi
//
//  Created by eric liu on 2023-09-17.
//  Edited Sept. 18th (Edward)
//


import Foundation
let WHITE = 1
let BLACK = -1
let EMPTY = 0


class Player{
    /// -1 is Black
    /// 1 is White
    var colour:Int = 0
    /// The score of the player
    var score:Int = 0
    
    init(colour:Int){
        self.colour = colour
    }
    
    /// Edward
    /// This returns a list of squares where there is a potential move
    /// [(x,y),(x,y) ....]
    func givePotientialMove(board:GameBoard)->[(Int,Int)]{
        var numOfAvailMove:Int = 0
        var arr = [(Int,Int)]()
        let n:Int = 8
        for row in 0..<n{
            for col in 0..<n{
                if (board.currentBoard[row][col] == EMPTY){
                    if checkLegalInDirection(board: board,n: n,row: row,col: col,deltaRow: -1,deltaCol: -1), checkLegalInDirection(board: board,n: n,row: row,col: col,deltaRow: -1,deltaCol: 0), checkLegalInDirection(board: board,n: n,row: row,col: col,deltaRow: -1,deltaCol: 1), checkLegalInDirection(board: board,n: n,row: row,col: col,deltaRow: 0,deltaCol: -1), checkLegalInDirection(board: board,n: n,row: row,col: col,deltaRow: 0,deltaCol: 1), checkLegalInDirection(board: board,n: n,row: row,col: col,deltaRow: 1,deltaCol: -1), checkLegalInDirection(board: board,n: n,row: row,col: col,deltaRow: 1,deltaCol: 0), checkLegalInDirection(board: board,n: n,row: row,col: col,deltaRow: 1,deltaCol: 1) {
                        arr[numOfAvailMove] = (row,col)
                        numOfAvailMove+=1
                    }
                }
            }
        }
        
        
        return arr
    }
    
    func checkLegalInDirection(board:GameBoard, n:Int, row:Int, col:Int, deltaRow:Int, deltaCol:Int) -> Bool{
        var isLegal:Bool = false
        var numOfDelta:Int = 1
        if (!positionInBounds(n: n,row: row,col: col) || !positionInBounds(n: n,row: row+deltaRow,col: col+deltaCol)){
            isLegal = false
        }
        if (colour == WHITE){
            if (board.currentBoard[row+deltaRow][col+deltaCol] != BLACK ){
                isLegal = false
            } else{
                while(positionInBounds(n: n,row: row+numOfDelta*deltaRow,col: col+numOfDelta*deltaCol) && board.currentBoard[row+numOfDelta*deltaRow][col+numOfDelta*deltaCol] == BLACK ){
                    //it should first check one increment, which based on above condition, should always have B
                    //we check the next within the while loop so it doesn't conflict with looping condition
                    numOfDelta += 1 //so first increment delta
                    if (positionInBounds(n: n,row: row+numOfDelta*deltaRow,col: col+numOfDelta*deltaCol) && board.currentBoard[row+numOfDelta*deltaRow][col+numOfDelta*deltaCol] == BLACK ){
                        continue
                    } else if (positionInBounds(n: n,row: row+numOfDelta*deltaRow,col: col+numOfDelta*deltaCol) && board.currentBoard[row+numOfDelta*deltaRow][col+numOfDelta*deltaCol] == EMPTY ){
                        //this means it reached blank first so not legal move
                        isLegal = false
                        break
                    } else if (positionInBounds(n: n,row: row+numOfDelta*deltaRow,col: col+numOfDelta*deltaCol) && board.currentBoard[row+numOfDelta*deltaRow][col+numOfDelta*deltaCol] == WHITE){//supposedly is white
                        isLegal = true
                        break
                    }
                    
                    
                }
                
                
            }
        } else {
            if (board.currentBoard[row+deltaRow][col+deltaCol] != WHITE){
                isLegal = false
            } else{//while it is still white or when it reaches blank but not change colour
                while(positionInBounds(n: n,row: row+numOfDelta*deltaRow,col: col+numOfDelta*deltaCol) && board.currentBoard[row+numOfDelta*deltaRow][col+numOfDelta*deltaCol] == WHITE){
                    //it should first check one increment, which based on above condition, should always have B
                    //we check the next within the while loop so it doesn't conflict with looping condition
                    numOfDelta+=1 //so first increment delta
                    if (positionInBounds(n: n,row: row+numOfDelta*deltaRow,col: col+numOfDelta*deltaCol) && board.currentBoard[row+numOfDelta*deltaRow][col+numOfDelta*deltaCol] == WHITE){
                        continue
                    } else if (positionInBounds(n: n,row: row+numOfDelta*deltaRow,col: col+numOfDelta*deltaCol) && board.currentBoard[row+numOfDelta*deltaRow][col+numOfDelta*deltaCol] == EMPTY){
                        //this means it reached blank first
                        isLegal = false
                        break
                    } else if (positionInBounds(n: n,row: row+numOfDelta*deltaRow,col: col+numOfDelta*deltaCol) && board.currentBoard[row+numOfDelta*deltaRow][col+numOfDelta*deltaCol] == BLACK){//supposedly is black
                        isLegal = true
                    }
                    
                    
                }
            }
            
            
        }
        return isLegal
    }
    func positionInBounds(n:Int,row:Int,col:Int) -> Bool{
        if (row < n && col < n && row >= 0 && col >= 0){
            return true
        } else {
            return false
        }
    }
    /// Tiffany
    /// This sweeps the board to check the score this player
    
    func checkScore(board: GameBoard) -> Int {
        var playerScore = 0
        
        for row in 0..<board.currentBoard.count {
            for col in 0..<board.currentBoard[row].count {
                if board.currentBoard[row][col] == colour {
                    playerScore += 1
                }
            }
        }
        
        score = playerScore
        return playerScore
    }
}


