//
//  CreateGameWorldView.swift
//  RPGResearch
//
//  Created by User08 on 2021/1/12.
//

import SwiftUI

struct CreateGameWorldView: View {
    @EnvironmentObject var GameDataBase:PlayGameDataBase
    @State var WarViewArray = [ShowWarView]() //? = nil
    //@State var NewEditData:GameWorld = GameWorld(from: Decoder)
    @State var WarString = [[String]]()
    var body: some View {
        VStack{
            Button("D"){
                Add()
            }
            ScrollView{
                ForEach(0..<WarViewArray.endIndex,id:\.self){
                    N in
                    NavigationLink(destination: ShowWarString(WarString: WarString[N])){
                        WarViewArray[N].onReceive(Timer.publish(every: 0.0001, on: .main, in: .common).autoconnect(), perform: { _ in WarString[N] = WarViewArray[N].getS()})
                    }
                }
            }
        }
        //WarView(GameDataBase: GameDataBase)
        /*HStack{
            Text("input World Name:")
            //TextField("World1",text:$NewEditData.Name)
        }*/
    }
    
    func Add(){
        let SNPC:[NPC] = GameDataBase.ModelDataBase[0].NPCLibrary!
        var ANPCRN = [NPC]()
        var ID:Int
        for _ in 0..<100{
            ID = Int.random(in: 0..<SNPC.endIndex)
            ANPCRN.append(SNPC[ID])
        }
        
        var BNPCRN = [NPC]()
        for _ in 0..<100{
            ID = Int.random(in: 0..<SNPC.endIndex)
            BNPCRN.append(SNPC[ID])
        }
        let AForce = Force(id:-1,Name:"AA",image:"AA",NPCForce:ANPCRN)
        let BForce = Force(id:-1,Name:"AA",image:"AA",NPCForce:BNPCRN)
        
        //let SWar = War(AForce:AForce,BForce:BForce)
        //SWar.WarState()
        self.WarViewArray.append(ShowWarView(GameDataBase:GameDataBase,AF:AForce,BF: BForce))
        WarString.append(WarViewArray[WarViewArray.endIndex-1].getS())
    }
}

struct setGameWorld: View{
    @EnvironmentObject var GameDataBase:PlayGameDataBase
    @State var setWorldData:GameWorld
    var body: some View{
        Text("")
    }
    /*init(){
        self.setWorldData = GameWorld(Name: "未命名的世界", creatData:Date(),GameData: GameData(money: 100, MapData: Map(id: -1, Name: "測試地圖")))
    }*/
}

struct ShowWarString: View {
    @State var WarString:[String]
    var body: some View{
        VStack{
            ScrollView{
                ForEach(0..<WarString.endIndex,id:\.self){
                    N in
                    Text(WarString[N])
                }
            }
        }
    }
}

struct ShowWarView :View{
    @EnvironmentObject var GameDataBase:PlayGameDataBase
    @ObservedObject var SWar:War
    @State var ANPCArray = [NPC]()
    @State var BNPCArray = [NPC]()
    @State var ShowTurn = 0
    @State var WarString = [String]()
    
    var body: some View{
        VStack{
            HStack{
                Text("我方：\(self.SWar.AForce.Name) 人數：\(self.SWar.ANPC.endIndex)")
                Spacer()
            }
            HStack{
                Text("敵方：\(self.SWar.BForce.Name) 人數：\(self.SWar.BNPC.endIndex)")
                Spacer()
            }
            HStack{
                Text("金錢：\(self.SWar.SUMAMoney) 經驗：\(self.SWar.SUMAEX)")
                Spacer()
            }
            HStack{
                if(ShowTurn >= 0 && ShowTurn<43200){
                    Text("戰鬥經過了\(ShowTurn)秒").onReceive(Timer.publish(every: 0.0001, on: .main, in: .common).autoconnect(), perform: { _ in
                            if(ShowTurn<43200){
                                self.SWar.NewBattle()
                                WarString = self.SWar.giveS()
                                ShowTurn = self.SWar.TurnO
                            }
                        })
                }else if(ShowTurn == -1){
                    Text("戰鬥失敗")
                }else if(ShowTurn == -2){
                    Text("戰鬥勝利")
                }
                
                Spacer()
            }
        }.padding().border(Color.blue, width: 5)
    }
    
    init(GameDataBase:PlayGameDataBase,WarA:War){
        self.SWar = WarA;
        self.SWar.WarState()
    }
    
    init(GameDataBase:PlayGameDataBase,AF:Force,BF:Force){
        self.SWar = War(AForce:AF,BForce:BF)
        self.SWar.WarState()
    }
    
    init(GameDataBase:PlayGameDataBase){
        //self.GameDataBase = GameDataBase
        let SNPC:[NPC] = GameDataBase.ModelDataBase[0].NPCLibrary!
        var ANPCRN = [NPC]()
        var ID:Int
        for _ in 0..<100{
            ID = Int.random(in: 0..<SNPC.endIndex)
            ANPCRN.append(SNPC[ID])
        }
        
        var BNPCRN = [NPC]()
        for _ in 0..<100{
            ID = Int.random(in: 0..<SNPC.endIndex)
            BNPCRN.append(SNPC[ID])
        }
        let AForce = Force(id:-1,Name:"AA",image:"AA",NPCForce:ANPCRN)
        let BForce = Force(id:-1,Name:"AA",image:"AA",NPCForce:BNPCRN)
        //let AForce = Force(id:-1,Name:"AA",image:"AA",NPCForce:[SNPC[3],SNPC[0]])
        //let BForce = Force(id:-1,Name:"AA",image:"AA",NPCForce:[SNPC[1],SNPC[1]])
        self.SWar = War(AForce:AForce,BForce:BForce)
        self.SWar.WarState()
    }
    
    func getS()->[String]{
        return self.SWar.giveS()
    }
}

struct WarView:View {
    @EnvironmentObject var GameDataBase:PlayGameDataBase
    @ObservedObject var SWar:War
    @State var ANPCArray = [NPC]()
    @State var BNPCArray = [NPC]()
    @State var ShowTurn = 0
    @State var AMoney = 0
    @State var AEx = 0
    @State var BMoney = 0
    @State var BEx = 0

    var body: some View {
        VStack{
            HStack{
                ScrollView{
                    Text("我方人員剩餘：\(ANPCArray.endIndex)")
                    ForEach(0..<ANPCArray.endIndex,id:\.self){
                        SWNPC in
                        HStack{
                            Text("\(ANPCArray[SWNPC].Name)")
                            Text("\(ANPCArray[SWNPC].RoleAttributes.Health.NowHealth)")
                            //Text("\(SWar.ANPC[SWNPC].position)")
                            
                        }
                    }
                }
                Spacer()
                ScrollView{
                    Text("敵方人員剩餘：\(BNPCArray.endIndex)")
                    ForEach(0..<BNPCArray.endIndex,id:\.self){
                        SWNPC in
                        HStack{
                            Text("\(BNPCArray[SWNPC].Name)")
                            Text("\(BNPCArray[SWNPC].RoleAttributes.Health.NowHealth)")
                            //Text("\(SWar.BNPC[SWNPC].position)")
                        }
                    }
                }
            }
            /*Button("pa"){
                //self.SWar.BUN()
                //self.SWar.WarState()
                //SWar.NewBattle()
            }*/
            Text("\(ShowTurn)").onReceive(Timer.publish(every: 0.0001, on: .main, in: .common).autoconnect(), perform: { _ in
                if(ShowTurn<43200){
                    self.SWar.NewBattle()
                    ShowTurn = self.SWar.TurnO
                }
            })
            
            Text("A\(AMoney)").onReceive(Timer.publish(every: 0.0001, on: .main, in: .common).autoconnect(), perform: { _ in
                AMoney = self.SWar.SUMAMoney
            })
            Text("AE\(AEx)").onReceive(Timer.publish(every: 0.0001, on: .main, in: .common).autoconnect(), perform: { _ in
                AEx = self.SWar.SUMAEX
            })
            Text("B\(BMoney)").onReceive(Timer.publish(every: 0.0001, on: .main, in: .common).autoconnect(), perform: { _ in
                BMoney = self.SWar.SUMBMoney
            })
            Text("BE\(BEx)").onReceive(Timer.publish(every: 0.0001, on: .main, in: .common).autoconnect(), perform: { _ in
                BEx = self.SWar.SUMBEX
            })
            
        }.onAppear(perform: {
            ANPCArray.removeAll()
            for I in 0..<self.SWar.ANPC.endIndex{
                ANPCArray.append(self.SWar.ANPC[I].NPC)
            }
            BNPCArray.removeAll()
            for I in 0..<self.SWar.BNPC.endIndex{
                BNPCArray.append(self.SWar.BNPC[I].NPC)
            }
        }).onChange(of: self.SWar.ANPC.endIndex, perform: { value in
            ANPCArray.removeAll()
            for I in 0..<self.SWar.ANPC.endIndex{
                ANPCArray.append(self.SWar.ANPC[I].NPC)
            }
        }).onChange(of: self.SWar.BNPC.endIndex, perform: { value in
            BNPCArray.removeAll()
            for I in 0..<self.SWar.BNPC.endIndex{
                BNPCArray.append(self.SWar.BNPC[I].NPC)
            }
        })
    }
    
    init(GameDataBase:PlayGameDataBase){
        //self.GameDataBase = GameDataBase
        let SNPC:[NPC] = GameDataBase.ModelDataBase[0].NPCLibrary!
        var ANPCRN = [NPC]()
        var ID:Int
        for _ in 0..<100{
            ID = Int.random(in: 0..<SNPC.endIndex)
            ANPCRN.append(SNPC[ID])
        }
        
        var BNPCRN = [NPC]()
        for _ in 0..<100{
            ID = Int.random(in: 0..<SNPC.endIndex)
            BNPCRN.append(SNPC[ID])
        }
        let AForce = Force(id:-1,Name:"AA",image:"AA",NPCForce:ANPCRN)
        let BForce = Force(id:-1,Name:"AA",image:"AA",NPCForce:BNPCRN)
        //let AForce = Force(id:-1,Name:"AA",image:"AA",NPCForce:[SNPC[3],SNPC[0]])
        //let BForce = Force(id:-1,Name:"AA",image:"AA",NPCForce:[SNPC[1],SNPC[1]])
        self.SWar = War(AForce:AForce,BForce:BForce)
        self.SWar.WarState()
    }
}

struct CreateGameWorldView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGameWorldView().environmentObject(PlayGameDataBase())//GameDataBase: PlayGameDataBase())
    }
}
