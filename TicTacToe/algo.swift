class TicTacToe {
    var board = [[String]]()
    var boardSize = 0
    var gameMode = ""
    var playerPiece = "ｘ"
    var botPiece = "ｏ"
    let space = "　"
    let hyphen = "ー"
    let pipe = "｜"
    
    
    init (board_size: Int, mode: String) {
        self.boardSize = board_size
        self.gameMode = mode
        generateBoard()  
    }
    
    func generateBoard () {
        for i in 0...boardSize-1 {
            // we make individual rows
            board.append([String]())
            for _ in 0...boardSize-1 {
                // we make individual squares
                board[i].append(self.space)
            }
        }
        
    }
    
    func printBoard () {
        // we make a new array of strings to store the formatted rows
        var newArray = [String]()
        let joiner = "\n" + String.init(repeating: self.hyphen, count: 2*self.boardSize-1) + "\n"
        for row in self.board {
            newArray.append(row.joined(separator: self.pipe))
        }
        print(newArray.joined(separator: joiner))
    }
    
    func unoccupiedPlaces () -> [[Int]] {
        var freePlaces = [[Int]]()
        
        for rowID in 0...boardSize-1 {
            for colID in 0...boardSize-1 {
                if self.board[rowID][colID] == self.space {
                    freePlaces.append([rowID, colID])
                }
            }
        }
        return freePlaces
    }
    
    func checkPlacement (row: Int, column: Int) -> Bool {
        if self.unoccupiedPlaces().firstIndex(of: [row, column]) != nil {
            return true
        } else {
            return false
        }
        
    }
    
    func placePiece(row: Int, column: Int, piece: String) {
        if checkPlacement(row: row, column: column) == true {
            self.board[row][column] = piece
        }
    }
    
    func placePlayerPiece(row: Int, column: Int) -> Bool {
        if checkPlacement(row: row, column: column) != true {
            return false
        }
        else {
            self.placePiece(row: row, column: column, piece: self.playerPiece)
            return true
        }
    }
    
    func placeBotPiece(row: Int, column: Int) -> Bool {
        if checkPlacement(row: row, column: column) != true {
            return false
        } else {
            self.placePiece(row: row, column: column, piece: self.botPiece)
            return true
        }
    }
    
    func checkRowOccurrences (row: Int, occurrence: String) -> [[Int]] {
        var occurrences = [[Int]]()
        if row >= self.boardSize || row < 0 {
            return []
        }
        
        for columnIndex in 0...self.boardSize-1 {
            if self.board[row][columnIndex] == occurrence {
                occurrences.append([row, columnIndex])
            }
        }
        return occurrences
    }
    
    func checkColumnOccurrences (column: Int, occurrence: String) -> [[Int]] {
        var occurrences = [[Int]]()
        if column >= self.boardSize || column < 0 {
            return []
        }
        
        for rowIndex in 0...self.boardSize-1 {
            if self.board[rowIndex][column] == occurrence {
                occurrences.append([rowIndex, column])
            }
        }
        return occurrences
    }
    
    func checkDiag1Occurrences (occurrence: String) -> [[Int]] {
        var occurrences = [[Int]]()
        for i in 0...self.boardSize-1 {
            if self.board[i][i] == occurrence {
                occurrences.append([i, i])
            }
        }
        return occurrences
    }
    
    func checkDiag2Occurrences (occurrence: String) -> [[Int]] {
        var occurrences = [[Int]]()
        for i in 0...self.boardSize-1 {
            if self.board[i][self.boardSize-i-1] == occurrence {
                occurrences.append([i, self.boardSize-i-1])
            }
        }
        return occurrences
    }
    
    func movesPreventingPlayerWin()  -> [[Int]] {
        var plausibleMoves = [[Int]]()
        
        // first we look at the rows
        for row in 0...self.boardSize-1 {
            if self.checkRowOccurrences(row: row, occurrence: self.playerPiece).count == self.boardSize-1 {
                // we look for the rows with one free space, and the rest are occupied by the player
                // then append the positions to the plausibleMoves array
                plausibleMoves.append(contentsOf: checkRowOccurrences(row: row, occurrence: self.space))
            }
        }
        
        // next we look at the columns
        for column in 0...self.boardSize-1 {
            if self.checkColumnOccurrences(column: column, occurrence: self.playerPiece).count == self.boardSize-1 {
                // we look for columns with one free space, and the rest occupied by the player
                // then append the positions to the plausibleMoves array
                
                plausibleMoves.append(contentsOf: checkColumnOccurrences(column: column, occurrence: self.space))
            }
        }
        
        // diagonal 1
        if checkDiag1Occurrences(occurrence: self.playerPiece).count == boardSize-1 {
            plausibleMoves.append(contentsOf: checkDiag1Occurrences(occurrence: self.space))
        }
        // diag 2
        if checkDiag2Occurrences(occurrence: self.playerPiece).count == boardSize-1 {
            plausibleMoves.append(contentsOf: checkDiag2Occurrences(occurrence: self.space))
        }
        return plausibleMoves
    }
    
    func movesForBotWin () -> [[Int]] {
        var plausibleMoves = [[Int]]()
        
        // first we look at the rows
        for row in 0...self.boardSize-1 {
            if self.checkRowOccurrences(row: row, occurrence: self.botPiece).count == self.boardSize-1 {
                // we look for the rows with one free space, and the rest are occupied by the bot
                // then append the positions to the plausibleMoves array
                plausibleMoves.append(contentsOf: checkRowOccurrences(row: row, occurrence: self.space))
            }
        }
        
        // next we look at the columns
        for column in 0...self.boardSize-1 {
            if self.checkColumnOccurrences(column: column, occurrence: self.botPiece).count == self.boardSize-1 {
                // we look for columns with one free space, and the rest occupied by the player
                // then append the positions to the plausibleMoves array
                
                plausibleMoves.append(contentsOf: checkColumnOccurrences(column: column, occurrence: self.space))
            }
        }
        
        // diagonal 1
        if checkDiag1Occurrences(occurrence: self.botPiece).count == boardSize-1 {
            plausibleMoves.append(contentsOf: checkDiag1Occurrences(occurrence: self.space))
        }
        // diag 2
        if checkDiag2Occurrences(occurrence: self.botPiece).count == boardSize-1 {
            plausibleMoves.append(contentsOf: checkDiag2Occurrences(occurrence: self.space))
        }
        return plausibleMoves
    }
    
    
    func calcBotMove (autoPlace: Bool = true) -> [Int] {
        var plausibleMoves = [[Int]]()
        var move = [Int]()
        
        if self.gameMode.lowercased() == "easy" {
            plausibleMoves = self.unoccupiedPlaces()
        } else if self.gameMode.lowercased() == "normal" {
            plausibleMoves = self.movesPreventingPlayerWin()
        } else {
            // Mode is set to "hard"
            print("Moves Preventing Player Win", self.movesPreventingPlayerWin())
            print("Moves For Bot Win", self.movesForBotWin())
            print("Unoccupied Places", self.unoccupiedPlaces())
            if self.movesForBotWin() != [] {
                plausibleMoves = self.movesForBotWin()
            } else if self.movesPreventingPlayerWin() != [] {
                plausibleMoves = self.movesPreventingPlayerWin()
            } else {
                plausibleMoves = self.unoccupiedPlaces()
            }
        }
        
        if autoPlace {
            // if autoPlace is true, we place the piece
            
            if let finalMove = plausibleMoves.randomElement() {
                _ = self.placeBotPiece(row: finalMove[0], column: finalMove[1])
                move = finalMove
            } else if let finalMove = self.unoccupiedPlaces().randomElement() {
                _ = self.placeBotPiece(row: finalMove[0], column: finalMove[1])
                move = finalMove
            }
            
        } else {
            if let finalMove = plausibleMoves.randomElement() {
                move = finalMove
            }
        }
        
        return move
    }
    
    func checkWin(piece: String) -> Bool {
        // check rows
        for row in 0...self.boardSize-1 {
            if self.checkRowOccurrences(row: row, occurrence: piece).count == self.boardSize {
                return true
            }
        }
        
        // check columns
        for column in 0...self.boardSize-1 {
            if self.checkColumnOccurrences(column: column, occurrence: piece).count == self.boardSize {
                return true
            }
        }
        
        // check diagonals
        if checkDiag1Occurrences(occurrence:piece).count == self.boardSize || checkDiag2Occurrences(occurrence: piece).count == self.boardSize {
            return true
        }
        
        // none of the cases returned true, which means the player didnt win yet.
        return false
    }
    
    func checkDraw () -> Bool {
        if unoccupiedPlaces() == [] {
            return true
        } else {
            return false
        }
        
    }
    
    func checkGameOver() -> String {
        if self.checkWin(piece: self.playerPiece) {
            return "You Win!"
        } else if checkWin(piece: self.botPiece) {
            return "You Lose :("
        } else if self.checkDraw() {
            return "It's a Draw."
        } else {
            return "NotOver"
        }
        
    }
}
