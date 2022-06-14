//
//  main.swift
//  TicTacToe
//
//  Created by Mahasvan on 14/06/22.
//

import Foundation


func clearScreen () {
    print("\003[2J\003[H")
}

clearScreen()
print("Welcome to TicTacToe")
print("Press enter to start the game")
let _ = readLine(strippingNewline: false)

var ttt = TicTacToe(board_size: 3, mode: "hard")

while true {
    clearScreen()
    ttt.printBoard()
    print("Enter your move - row,col: ")
    let choice: String = readLine(strippingNewline: true)!
    print(choice)
    if choice == "exit" {
        break
    }
    let userInputArray = choice.components(separatedBy: ",")
    if ttt.checkPlacement(row: Int(userInputArray[0])!, column: Int(userInputArray[1])!) {
        let _ = ttt.placePlayerPiece(row: Int(userInputArray[0])!, column: Int(userInputArray[1])!)
    } else {
        print("Invalid placement!")
        continue
    }
    
    clearScreen()
    if ttt.checkGameOver() != "NotOver" {
        ttt.printBoard()
        print(ttt.checkGameOver())
        break
    } else {
        let _ = ttt.calcBotMove(autoPlace: true)
        ttt.printBoard()
        if ttt.checkGameOver() != "NotOver" {
            print(ttt.checkGameOver())
        }
    }
}
