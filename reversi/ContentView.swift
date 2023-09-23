//
//  ContentView.swift
//  reversi
//
//  Created by eric liu on 2023-09-16.
//

import SwiftUI

/// This is  where the app view is defined
/// kdajsflaksdjflaskdjflk
/// lalallaallala
/// test 2
struct ContentView: View {
    @State var time:Int = 10
    @State var unlimitedtime = false
    @State var gamestarted:Bool = false
    @State var runningGame = Game()
    var body: some View {
        if gamestarted{
            GameBoardView(game:runningGame)
        }
        else{
            MenuView(time:$time,unlimitedtime: $unlimitedtime,gamestarted: $gamestarted)
        }
    }
}

#Preview {
    ContentView()
}
