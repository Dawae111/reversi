//
//  GameBoardView.swift
//  reversi
//
//  Created by eric liu on 2023-09-17.
//



import SwiftUI

struct GameBoardView: View {
    @State var board: GameBoard
    @State var game:Game
    
    init(game:Game){
        self.board = game.board
        self.game = game
        _selectedTheme = State(initialValue: brownTheme)
    }
    
    let brownTheme: [Color] =
    [Color(UIColor(red: 0xcb / 255.0, green: 0xa4 / 255.0, blue: 0x70 / 255.0, alpha: 1.0)),
     Color(UIColor(red: 0xe4 / 255.0, green: 0xc8 / 255.0, blue: 0xa9 / 255.0, alpha: 1.0)),
     Color(UIColor(red: 0x83 / 255.0, green: 0x5f / 255.0, blue: 0x2e / 255.0, alpha: 1.0))]
    
    let greenTheme: [Color] =
    [Color(red: 0xA9 / 255.0, green: 0xE1 / 255.0, blue: 0xB9 / 255.0),
     Color(red: 0x76 / 255.0, green: 0xC3 / 255.0, blue: 0x8C / 255.0),
     Color(red: 0x4C / 255.0, green: 0x9E / 255.0, blue: 0x81 / 255.0)]
    
    
    let grayTheme: [Color] =
    [Color(red: 248/255.0, green: 249/255.0, blue: 253/255.0),
     Color(red: 248/255.0, green: 249/255.0, blue: 253/255.0),
     Color.black]
    
    let whiteTheme: [Color] =
    [Color.white, Color.white, Color.black]
    
    
    @State private var selectedTheme: [Color]
    @State var count: Int = 0;
    
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .ignoresSafeArea(.all)
            VStack{
            HStack() {
                Image("player2")
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .offset(x:-80)
                VStack(alignment: .leading){
                    Text("YuCheng")
                        .font(.title)
                    Text("Score:65")
                        .font(.subheadline)
                }
                .offset(x:-80)
            }
            VStack (spacing: 0) {
                ForEach(0..<8, id: \.self) { row in
                    HStack (spacing: 0) {
                        ForEach(0..<8, id: \.self) { column in
                            ZStack {
                                Rectangle()
                                    .frame(width: 39.8, height: 39.8)
                                    .foregroundColor((row + column).isMultiple(of: 2) ? selectedTheme[0]:selectedTheme[1])
                                    .border(Color.black, width: 0.2)
                                if board.currentBoard[row][column] == -1 {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                        .shadow(color: .black, radius: 1, x: 0, y: 1)
                                } else if board.currentBoard[row][column] == 1 {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2, x: 0, y: 1)
                                }
                            }
                            .onTapGesture {
                                if board.update(move: [row, column], color: game.activePlayer.colour){
                                    if game.activePlayer.colour == game.p1.colour {
                                        game.activePlayer = game.p2
                                    }
                                    else{
                                        game.activePlayer = game.p1
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .background(RoundedRectangle(cornerRadius: 0.5)
                .stroke(selectedTheme[2], lineWidth: 10))
            .padding()
            HStack() {
                VStack(alignment: .trailing){
                    Text("David")
                        .font(.title)
                    Text("Score:-1")
                        .font(.subheadline)
                }
                .offset(x:90)
                Image("player1")
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .offset(x:90)
            }
            Picker("Select Theme", selection: $selectedTheme) {
                Text("Brown").tag(brownTheme)
                Text("Green").tag(greenTheme)
                Text("Grey").tag(grayTheme)
                Text("White").tag(whiteTheme)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
    }
}


