//
//  CreatePlayersView.swift
//  RPGResearch
//
//  Created by User10 on 2020/12/31.
//

import SwiftUI

struct CreatePlayersView: View {
    @EnvironmentObject var GameDataBase:PlayGameDataBase
    var body: some View {
        Text("Hello, World!")
    }
}

struct CreateFroce: View{
    @EnvironmentObject var GameDataBase:PlayGameDataBase
    var body: some View{
        VStack{
            HStack{
                Text("選擇指揮官")
                
            }
            
        }
    }
}

struct SelectBoss: View{
    @EnvironmentObject var GameDataBase:PlayGameDataBase
    var body: some View{
        VStack{
            ScrollView{
                Text("指揮官：\(GameDataBase.ModelDataBase[0].NPCLibrary![10].Name)")
                ForEach(0..<GameDataBase.ModelDataBase[0].NPCLibrary![10].RoleAttributes.Skill!.endIndex){N in
                    Text("技能名：\(GameDataBase.ModelDataBase[0].NPCLibrary![10].RoleAttributes.Skill![N].Name)")
                    Text("技能描述：\(GameDataBase.ModelDataBase[0].NPCLibrary![10].RoleAttributes.Skill![N].SkillDescription)")
                }
                Text("指揮官：\(GameDataBase.ModelDataBase[0].NPCLibrary![12].Name)")
                ForEach(0..<GameDataBase.ModelDataBase[0].NPCLibrary![12].RoleAttributes.Skill!.endIndex){N in
                    Text("技能名：\(GameDataBase.ModelDataBase[0].NPCLibrary![12].RoleAttributes.Skill![N].Name)")
                    Text("技能描述：\(GameDataBase.ModelDataBase[0].NPCLibrary![12].RoleAttributes.Skill![N].SkillDescription)")
                }
                Text("指揮官：\(GameDataBase.ModelDataBase[0].NPCLibrary![13].Name)")
                ForEach(0..<GameDataBase.ModelDataBase[0].NPCLibrary![13].RoleAttributes.Skill!.endIndex){N in
                    Text("技能名：\(GameDataBase.ModelDataBase[0].NPCLibrary![13].RoleAttributes.Skill![N].Name)")
                    Text("技能描述：\(GameDataBase.ModelDataBase[0].NPCLibrary![13].RoleAttributes.Skill![N].SkillDescription)")
                }
                Text("指揮官：\(GameDataBase.ModelDataBase[0].NPCLibrary![14].Name)")
                ForEach(0..<GameDataBase.ModelDataBase[0].NPCLibrary![14].RoleAttributes.Skill!.endIndex){N in
                    Text("技能名：\(GameDataBase.ModelDataBase[0].NPCLibrary![14].RoleAttributes.Skill![N].Name)")
                    Text("技能描述：\(GameDataBase.ModelDataBase[0].NPCLibrary![14].RoleAttributes.Skill![N].SkillDescription)")
                }
            }
        }
    }
    
}

struct CreatePlayersView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlayersView().environmentObject(PlayGameDataBase())//GameDataBase: PlayGameDataBase())
    }
}
