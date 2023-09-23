//
//  GameBoard.swift
//  reversi
//
//  Created by eric liu on 2023-09-17.
//

import Foundation

struct GameBoard{
    /// This stores the current state of the board
    /// Note that:
    ///     0 is no piece,
    ///     -1 is Black,
    ///     1 is White,
    var currentBoard:[[Int]] = Array(repeating:(Array(repeating:0,count:8)),count:8)
    
    init(){
        self.currentBoard[3][3] = 1
        self.currentBoard[4][3] = -1
        self.currentBoard[3][4] = -1
        self.currentBoard[4][4] = 1
    }
    
    /// Alysa
    /// This updates the gameboard
    mutating func update(move: [Int], color: Int)-> Bool{
        if checkValid(row:move[0],col:move[1],colour:color){
            flip(row:move[0],col:move[1],color:color)
            placeMove(move:move,color:color)
            return true
        } else {
            return false
        }
    }

    mutating func placeMove(move: [Int], color: Int) -> Void{
        var x = move[0]
        var y = move[1]
        currentBoard[x][y] = color
    }

    /// Stephanie
    /// This check if a move is valid
    
    // Check if outside of board
    func positionInBounds(row: Int, col: Int) -> Bool {
        let n = 8
        return row >= 0 && row < n && col >= 0 && col < n
    }

    // Check if it could move in a certain direction
    func checkLegalInDirection(row: Int, col: Int, colour: Int, deltaRow: Int, deltaCol: Int) -> Bool {
        // 0 means empty, -1 means black, 1 means white
        
        if currentBoard[row][col] == 0 {
            let newRow = row + deltaRow
            let newCol = col + deltaCol
            print("4")
            if positionInBounds( row: newRow, col: newCol) && currentBoard[newRow][newCol] == -colour {
                var rowIndex = newRow + deltaRow
                var colIndex = newCol + deltaCol
                print("5")
                while positionInBounds( row: rowIndex, col: colIndex) && currentBoard[rowIndex][colIndex] == -colour {
                    rowIndex += deltaRow
                    colIndex += deltaCol
                    print("6")
                }
                
                if positionInBounds(row: rowIndex, col: colIndex) && currentBoard[rowIndex][colIndex] == colour {
                    print("7")
                    return true
                }
            }
        }
        return false
    }

    // Check if legal move
    func checkValid(row: Int, col: Int, colour: Int) -> Bool {
        let n = 8
        let directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
        
        for direction in directions {
            let (deltaRow, deltaCol) = direction
            if checkLegalInDirection(row: row, col: col, colour: colour, deltaRow: deltaRow, deltaCol: deltaCol) {
                return true
            }
        }
        
        return false
    }
    
    
    /// Serena
    /// This updates the
    mutating func flip(
        row: Int,
        col: Int,
        color: Int
    ) {
        print("INNN")
        let deltaRow = [-1, -1, -1, 0, 0, 1, 1, 1]
        let deltaCol = [-1, 0, 1, -1, 1, -1, 0, 1]
        
        var oppositeColor = -1
        
        if color == 1 {
            oppositeColor = -1
        } else {
            oppositeColor = 1
        }
        
        
        for i in 0..<8 {
            var actualRow = row + deltaRow[i]
            var actualCol = col + deltaCol[i]
            
            if checkLegalInDirection(row:row, col:col, colour:color, deltaRow:deltaRow[i], deltaCol:deltaCol[i]) {
                print("3")
                while currentBoard[actualRow][actualCol] == oppositeColor && positionInBounds( row:actualRow, col:actualCol) {
                    currentBoard[actualRow][actualCol] = color
                    actualRow += deltaRow[i]
                    actualCol += deltaCol[i]
                }
            }
        }
    }
}
