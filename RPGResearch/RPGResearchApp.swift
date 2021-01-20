//
//  RPGResearchApp.swift
//  RPGResearch
//
//  Created by User10 on 2020/12/31.
//

import SwiftUI

@main
struct RPGResearchApp: App {
    let GameDataBase = PlayGameDataBase()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(GameDataBase)
        }
    }
}
