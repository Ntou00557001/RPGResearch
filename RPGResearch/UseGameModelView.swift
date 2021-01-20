//
//  UseGameModelView.swift
//  RPGResearch
//
//  Created by User08 on 2021/1/12.
//

import SwiftUI

struct UseGameModelView: View {
    @EnvironmentObject var GameDataBase:PlayGameDataBase
    var body: some View {
        ForEach(GameDataBase.ModelDataBase,id: \.self.Name){GameModel in
            ScrollView{
                HStack{
                    NavigationLink(destination: ModelShowView(GameDataBase: self.GameDataBase,ModelDataBase: GameModel)){
                        Text("\(GameModel.Name)")
                    }
                    
                    if(GameModel.ModelStatus == ModelStatus.Off){
                        Text("(未啟用)")
                        Spacer()
                        Button("啟用"){
                            GameDataBase.OnOrOffModel(ModelName: GameModel.Name)
                        }
                    }
                    else{
                        Text("(已啟用)")
                        Spacer()
                        Button("停用"){
                            GameDataBase.OnOrOffModel(ModelName: GameModel.Name)
                        }
                    }
                }
            }
        }
    }
}

struct ModelShowView:View{
    @ObservedObject var GameDataBase:PlayGameDataBase
    @State var ModelDataBase:Model
    var body: some View {
        VStack{
            List{
                GeometryReader{
                    geometry in
                    Text("武器庫").frame(width:geometry.size.width,height: geometry.size.height, alignment: .center).clipped().background(Color(red:0.8,green:0.8,blue:0.8))
                }
                if(ModelDataBase.WeaponLibrary != nil){
                    ForEach(ModelDataBase.WeaponLibrary!,id: \.self.Name){GameModel in
                        HStack{
                            Text("\(GameModel.Name)")
                        }
                    }
                }
                GeometryReader{
                    geometry in
                    Text("防具庫").frame(width:geometry.size.width,height: geometry.size.height, alignment: .center).clipped().background(Color(red:0.8,green:0.8,blue:0.8))
                }
                if(ModelDataBase.ArmorLibrary != nil){
                    ForEach(ModelDataBase.ArmorLibrary!,id: \.self.Name){GameModel in
                        HStack{
                            Text("\(GameModel.Name)")
                        }
                    }
                }
                GeometryReader{
                    geometry in
                    Text("載具庫").frame(width:geometry.size.width,height: geometry.size.height, alignment: .center).clipped().background(Color(red:0.8,green:0.8,blue:0.8))
                }
                if(ModelDataBase.VehicleLibrary != nil){
                    ForEach(ModelDataBase.VehicleLibrary!,id: \.self.Name){GameModel in
                        HStack{
                            Text("\(GameModel.Name)")
                        }
                    }
                }
                GeometryReader{
                    geometry in
                    Text("NPC庫").frame(width:geometry.size.width,height: geometry.size.height, alignment: .center).clipped().background(Color(red:0.8,green:0.8,blue:0.8))
                }
                if(ModelDataBase.NPCLibrary != nil){
                    ForEach(ModelDataBase.NPCLibrary!,id: \.self.Name){GameModel in
                        HStack{
                            Text("\(GameModel.Name)")
                        }
                    }
                }
            }
        }.navigationTitle("\(ModelDataBase.Name)")
    }
}

struct UseGameModelView_Previews: PreviewProvider {
    static var previews: some View {
        UseGameModelView().environmentObject(PlayGameDataBase())//GameDataBase: PlayGameDataBase())
    }
}
