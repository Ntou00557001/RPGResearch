//
//  TestWar.swift
//  RPGResearch
//
//  Created by User08 on 2021/1/13.
//

import SwiftUI

struct TestWar: View {
    var WarTT:War
    var body: some View {
        HStack{
            VStack{
                List{
                    ForEach(WarTT.AForce.NPCForce,id:\.self.id) { (Nm) in
                        HStack{
                            Text(Nm.Name)
                        }
                    }
                }
            }
            VStack{
                List{
                    ForEach(WarTT.BForce.NPCForce,id:\.self.id) { (Nm) in
                        HStack{
                            Text(Nm.Name)
                        }
                    }
                }
            }
        }
    }
}

struct TestWar_Previews: PreviewProvider {
    static var previews: some View {
        TestWar(WarTT:War(AForce:TestDataBase().ForceM[0],BForce: TestDataBase().ForceM[1]))
    }
}


