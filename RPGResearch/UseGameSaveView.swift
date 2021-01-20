//
//  UseGameSaveView.swift
//  RPGResearch
//
//  Created by User08 on 2021/1/12.
//

import SwiftUI

struct UseGameSaveView: View {
    @EnvironmentObject var GameDataBase:PlayGameDataBase
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct UseGameSaveView_Previews: PreviewProvider {
    static var previews: some View {
        UseGameSaveView().environmentObject(PlayGameDataBase())//GameDataBase: PlayGameDataBase())
    }
}
