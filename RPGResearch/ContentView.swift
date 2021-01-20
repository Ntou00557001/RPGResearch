//
//  ContentView.swift
//  RPGResearch
//
//  Created by User10 on 2020/12/31.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var GameDataBase:PlayGameDataBase
    var body: some View {
        NavigationView{
            StartGameView()//=GameDataBase: self._GameDataBase)
        }
    }
}

struct StartGameView: View{
    @EnvironmentObject var GameDataBase:PlayGameDataBase
    var body: some View{
        VStack{
            NavigationLink(destination:GameHomeView()/*GameDataBase: self.GameDataBase)*/){
                    Text("開始遊戲")
            }
                    //NavigationLink(destination: SignInView())
            Text("登入")
        //}
        }
    }
}

struct GameHomeView:View {
    @EnvironmentObject var GameDataBase:PlayGameDataBase
    var body: some View{
        VStack{
            /*NavigationLink(destination: CreateGameWorldView()){
                Text("創建新遊戲")
            }
            NavigationLink(destination: UseGameSaveView()){
                Text("讀取存檔")
            }*/
            NavigationLink(destination: CreateGameWorldView()){
                Text("進行隨機部隊戰鬥模擬")
            }
            NavigationLink(destination: UseGameModelView()){
                Text("檢視模組")
            }
        }
    }
    
    /*init(GameDataBase:PlayGameDataBase){
        self.GameDataBase = GameDataBase
        self.GameDataBase.PlayerDataBase.append(PresetData().PlayerPresetData)
    }*/
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(PlayGameDataBase())//GameDataBase: PlayGameDataBase())
    }
}
