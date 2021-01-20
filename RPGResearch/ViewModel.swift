//
//  ViewModel.swift
//  RPGResearch
//
//  Created by User10 on 2020/12/31.
//

import SwiftUI

func ModelId(inputId:Int)->Int{
    return inputId+1000000
}

class PlayGameDataBase:ObservableObject{
    @AppStorage("PlayerDataBase") var SavePlayerDataBase: Data?
    @AppStorage("GameWorldDataBase") var SaveGameWorldDataBase: Data?
    @AppStorage("ModelDataBase") var SaveModelDataBase: Data?
    
    @Published var PlayerDataBase = [Player]() {
        didSet{
            let encoder = JSONEncoder()
            do{
                let data = try encoder.encode(PlayerDataBase)
                SavePlayerDataBase = data
            }
            catch {
                
            }
        }
    }
    @Published var GameWorldDataBase = [GameWorld]() {
        didSet{
            let encoder = JSONEncoder()
            do{
                let data = try encoder.encode(GameWorldDataBase)
                SaveGameWorldDataBase = data
            }
            catch {
                
            }
        }
    }
    @Published var ModelDataBase = [Model]() {
        didSet{
            let encoder = JSONEncoder()
            do{
                let data = try encoder.encode(ModelDataBase)
                SaveModelDataBase = data
            }
            catch {
                
            }
        }
    }
    var Anti_Conflict_ModelId:Int = 0
    
    init(){
        if let SavePlayerDataBase = SavePlayerDataBase{
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Player].self, from: SavePlayerDataBase){
                PlayerDataBase = decodedData
            }
        }
        if let SaveGameWorldDataBase = SaveGameWorldDataBase{
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([GameWorld].self, from: SaveGameWorldDataBase){
                GameWorldDataBase = decodedData
            }
        }
        if let SaveGameWorldDataBase = SaveModelDataBase{
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Model].self, from: SaveGameWorldDataBase){
                ModelDataBase = decodedData
            }
        }
        ModelPackageData()
    }
    
    func LoadModel(LoadModelJSON:String){
        let LoadModelJSONObj = "\(LoadModelJSON)".data(using: .utf8)!
        let decoder = JSONDecoder()
        let product = try? decoder.decode(Model.self,from:LoadModelJSONObj)
        ModelDataBase[ModelDataBase.endIndex] = product!
    }
    
    func LoadModelPackage(LoadModelJSONPackage:String){
        let LoadModelJSONObj = "\(LoadModelJSONPackage)".data(using: .utf8)!
        let decoder = JSONDecoder()
        let product = try? decoder.decode([Model].self,from:LoadModelJSONObj)
        if(product != nil){
            ModelDataBase.append(contentsOf: product!)
        }else {
            print("載入模組包失敗！")
        }
    }
    
    func ModelPackageData(){
        //ModelDataBase.removeAll()
        //ModelDataBase.append(0,Model(id: -1, Name: "初始模組", image: "初始模組"))
        ModelDataBase.insert(Model(id: -1, Name: "初始模組", image: "初始模組"), at: 0)
        ModelDataBase[0].WeaponLibrary =
            [Weapon(id: -1, Name: "劍", image: "劍", WeaponType: .Power, Attack: 10, ArmorPiercing: 2, AttackSpeed: 1, AttackRange: 1,HitProbability: 100, Weight: 1, moneyValue: 100),
             Weapon(id: -2, Name: "鋼劍", image: "鋼劍", WeaponType: .Power, Attack: 30, ArmorPiercing: 3, AttackSpeed: 1, AttackRange: 1,HitProbability: 100, Weight: 1, moneyValue: 100),
             Weapon(id: -3, Name: "弓", image: "弓", WeaponType: .NoPower, Attack: 10, ArmorPiercing: 5, AttackSpeed: 1, AttackRange: 200,HitProbability: 100, Weight: 1, moneyValue: 100),
             Weapon(id: -4, Name: "弩", image: "弩", WeaponType: .NoPower, Attack: 30, ArmorPiercing: 20, AttackSpeed: 1, AttackRange: 200,HitProbability: 100, Weight: 1, moneyValue: 100),
             Weapon(id: -5, Name: "彈弓", image: "彈弓", WeaponType: .NoPower, Attack: 10, ArmorPiercing: 5, AttackSpeed:3, AttackRange: 100,HitProbability: 100, Weight: 1, moneyValue: 100),
             Weapon(id: -6, Name: "長矛", image: "長矛", WeaponType: .Power, Attack: 10, ArmorPiercing: 5, AttackSpeed: 1, AttackRange: 4,HitProbability: 100, Weight: 1, moneyValue: 100),
             Weapon(id: -7, Name: "投石機", image: "投石機", WeaponType: .NoPower, Attack: 2000, ArmorPiercing: 30, AttackSpeed: 1, AttackRange: 500,HitProbability: 100, Weight: 100, moneyValue: 100),
             Weapon(id: -8, Name: "巨弩", image: "巨弩", WeaponType: .NoPower, Attack: 1000, ArmorPiercing: 50, AttackSpeed: 1, AttackRange: 500,HitProbability: 100, Weight: 100, moneyValue: 100)]
        ModelDataBase[0].ArmorLibrary =
            [Armor(id: -1, Name: "皮革甲", image: "皮革甲", MaxDefense: 2, MinDefense: 0, Weight: 1, moneyValue: 20),
             Armor(id: -2, Name: "硬木片甲", image: "硬木片甲", MaxDefense: 3, MinDefense: 0, Weight: 5, moneyValue: 30),
             Armor(id: -3, Name: "鐵片甲", image: "鐵片甲", MaxDefense: 5, MinDefense: 0, Weight: 10, moneyValue: 50),
             Armor(id: -4, Name: "板甲", image: "板甲", MaxDefense: 10, MinDefense: 1, Weight: 20, moneyValue: 100)]
        ModelDataBase[0].VehicleLibrary = [Vehicle(id: -1, Name: "馬", image: "馬", MovingSpeed: 12, LoadWeight: 100, moneyValue: 50), Vehicle(id: -2, Name: "馬車", image: "馬車", MovingSpeed: 24, LoadWeight: 200, moneyValue: 100)]
        ModelDataBase[0].SkillLibrary = [
            Skill(id: -1, Name: "常態軍隊訓練", SkillDescription: "平時訓練軍隊的力氣，使士兵力氣在戰鬥時有所增加，每一等加一點", SkillLevel: 1, SkillMaxLevel: 100, GetSkill: 50, UpLevelNeedSkillPoint: 10, UpLevelSkillPointGrowthRatio: 50, SkillType: .CompanionPower, SkillEffect: 1, LevelGiveEffect: 1),
            Skill(id: -2, Name: "特化敏捷訓練", SkillDescription: "平時訓練軍隊的反應能力，使士兵敏捷在戰鬥時有所增加，每一等加一點", SkillLevel: 1, SkillMaxLevel: 100, GetSkill: 50, UpLevelNeedSkillPoint: 10, UpLevelSkillPointGrowthRatio: 50, SkillType: .CompanionAgile, SkillEffect: 1, LevelGiveEffect: 1),
            Skill(id: -3, Name: "教學", SkillDescription: "平時給軍隊學習時間，使士兵智力在戰鬥時有所增加，每一等加一點", SkillLevel: 1, SkillMaxLevel: 100, GetSkill: 50, UpLevelNeedSkillPoint: 10, UpLevelSkillPointGrowthRatio: 50, SkillType: .CompanionIntellect, SkillEffect: 1, LevelGiveEffect: 1),
            Skill(id: -4, Name: "力量訓練", SkillDescription: "平時訓練自己的力氣，使自己的力氣有所增加，每一等加一點", SkillLevel: 1, SkillMaxLevel: 100, GetSkill: 20, UpLevelNeedSkillPoint: 10, UpLevelSkillPointGrowthRatio: 50, SkillType: .Power, SkillEffect: 1, LevelGiveEffect: 1),
            Skill(id: -5, Name: "敏捷訓練", SkillDescription: "平時訓練自己的反應能力，使自己的敏捷有所增加，每一等加一點", SkillLevel: 1, SkillMaxLevel: 100, GetSkill: 20, UpLevelNeedSkillPoint: 10, UpLevelSkillPointGrowthRatio: 50, SkillType: .Agile, SkillEffect: 1, LevelGiveEffect: 1),
            Skill(id: -6, Name: "自學", SkillDescription: "平時自己學習，使自己的智力有所增加，每一等加一點", SkillLevel: 1, SkillMaxLevel: 100, GetSkill: 20, UpLevelNeedSkillPoint: 10, UpLevelSkillPointGrowthRatio: 50, SkillType: .Intellect, SkillEffect: 1, LevelGiveEffect: 1),
            Skill(id: -7, Name: "學習能力", SkillDescription: "學習如何獲取經驗，使自己的經驗獲取量有所增加，每一等加10點", SkillLevel: 1, SkillMaxLevel: 100, GetSkill: 25, UpLevelNeedSkillPoint: 20, UpLevelSkillPointGrowthRatio: 50, SkillType: .GetExperience, SkillEffect: 10, LevelGiveEffect: 1)
            
        ]
        ModelDataBase[0].NPCLibrary = [
            NPC(id: -1, Name: "劍士", image: "劍士", RoleAttributes: RoleAttributes(Level:PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[0], SecondaryWeapon: nil, Armor: nil, Vehicle: nil)), Camp: .My, GiveExperience: 10, GiveMoney: 5),
        NPC(id: -2, Name: "輕甲劍士", image: "輕甲劍士", RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: ModelDataBase[0].WeaponLibrary?[0], SecondaryWeapon: nil, Armor: self.ModelDataBase[0].ArmorLibrary?[0], Vehicle: nil)), Camp: .My, GiveExperience: 100, GiveMoney: 10),
        NPC(id: -3, Name: "中甲劍士", image: "中甲劍士", RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[1], SecondaryWeapon: nil, Armor: self.ModelDataBase[0].ArmorLibrary?[2], Vehicle: nil)), Camp: .My, GiveExperience: 150, GiveMoney: 20),
           NPC(id: -4, Name: "重甲劍士", image: "重甲劍士", RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[1], SecondaryWeapon: nil, Armor: self.ModelDataBase[0].ArmorLibrary?[3], Vehicle: nil)), Camp: .My, GiveExperience: 500, GiveMoney: 100),
           NPC(id: -5, Name: "騎士", image: "騎士",RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[1], SecondaryWeapon: nil, Armor: self.ModelDataBase[0].ArmorLibrary?[2], Vehicle: self.ModelDataBase[0].VehicleLibrary?[0])), Camp: .My, GiveExperience: 250, GiveMoney: 50),
           NPC(id: -6, Name: "戰車", image: "戰車", RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[5], SecondaryWeapon: nil, Armor: self.ModelDataBase[0].ArmorLibrary?[0], Vehicle: self.ModelDataBase[0].VehicleLibrary?[1])), Camp: .My, GiveExperience: 300, GiveMoney: 60),
           NPC(id: -7, Name: "重騎士", image: "重騎士", RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[5], SecondaryWeapon: nil, Armor: self.ModelDataBase[0].ArmorLibrary?[3], Vehicle: self.ModelDataBase[0].VehicleLibrary?[0])), Camp: .My, GiveExperience: 550, GiveMoney: 200),
           NPC(id: -8, Name: "長矛兵", image: "長矛兵", RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[5], SecondaryWeapon: nil, Armor: self.ModelDataBase[0].ArmorLibrary?[0], Vehicle: nil)), Camp: .My, GiveExperience: 200, GiveMoney: 20),
           NPC(id: -9, Name: "弓箭手", image: "弓箭手", RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[2], SecondaryWeapon: nil, Armor: self.ModelDataBase[0].ArmorLibrary?[0], Vehicle: nil)), Camp: .My, GiveExperience: 150, GiveMoney: 20),
           NPC(id: -10, Name: "弩手", image: "弩手", RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[3], SecondaryWeapon: nil, Armor: self.ModelDataBase[0].ArmorLibrary?[0], Vehicle: nil)), Camp: .My, GiveExperience: 250, GiveMoney: 50),
            NPC(id: -11, Name: "指揮官", image: "指揮官", RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[1], SecondaryWeapon: nil, Armor: self.ModelDataBase[0].ArmorLibrary?[0], Vehicle: nil),Skill:[self.ModelDataBase[0].SkillLibrary![0]]), Camp: .My, GiveExperience: 100, GiveMoney: 1000),
            NPC(id: -12, Name: "投石車", image: "投石車", RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[6], SecondaryWeapon: nil, Armor: nil, Vehicle: nil),Skill:[self.ModelDataBase[0].SkillLibrary![0]]), Camp: .My, GiveExperience: 100, GiveMoney: 500),
            NPC(id: -13, Name: "獵人指揮官", image: "獵人指揮官", RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[2], SecondaryWeapon: nil, Armor: nil, Vehicle: nil),Skill:[self.ModelDataBase[0].SkillLibrary![1]]), Camp: .My, GiveExperience: 100, GiveMoney: 2000),
            NPC(id: -14, Name: "學者指揮官", image: "學者指揮官", RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[0], SecondaryWeapon: nil, Armor: nil, Vehicle: nil),Skill:[self.ModelDataBase[0].SkillLibrary![2]]), Camp: .My, GiveExperience: 100, GiveMoney: 2000),
            NPC(id: -15, Name: "菁英指揮官", image: "菁英指揮官", RoleAttributes: RoleAttributes(Level: PresetData().LevelPresetData, Health: PresetData().HealthPresetData, Power: 20, Intellect: 10, Agile: 20, Equipment: Equipment(PrimaryWeapon: self.ModelDataBase[0].WeaponLibrary?[1], SecondaryWeapon: nil, Armor: nil, Vehicle: nil),Skill:[self.ModelDataBase[0].SkillLibrary![0],self.ModelDataBase[0].SkillLibrary![1]]), Camp: .My, GiveExperience: 100, GiveMoney: 5000)]
        ModelDataBase[0].BuildingLibrary = [Building(id: -1, Name: "酒館", Level: 1, UpLevelMoney: 100, giveMoney: 100, MaintenanceCost: 0)]
        let MNPC = ModelDataBase[0].NPCLibrary;
        ModelDataBase[0].ForceLibrary = [Force(id: -1, Name: "盜賊團", image: "盜賊團", TeamLeader: self.ModelDataBase[0].NPCLibrary![10], NPCForce: [MNPC![0],MNPC![0],MNPC![0],MNPC![0],MNPC![0]])]
        
    }
    
    func OnOrOffModel(ModelName:String){
        for FindModel in 0..<ModelDataBase.endIndex{
            if(ModelDataBase[FindModel].Name == ModelName){
                if(ModelDataBase[FindModel].ModelStatus == ModelStatus.On){
                    ModelDataBase[FindModel].ModelStatus = ModelStatus.Off
                }else{
                    ModelDataBase[FindModel].ModelStatus = ModelStatus.On
                }
                break
            }
        }
    }
}

class PresetData{
    var PlayerPresetData:Player
    var GameWorldPresetData:GameWorld
    var LevelPresetData:Level
    var HealthPresetData:Health
    var RoleAttributesPreseData:RoleAttributes
    var NPCModePresetData:NPC
    
    init(){
        self.PlayerPresetData = Player(Name: "訪客", password: "0000", image: "訪客", Birthday: Date())
        self.GameWorldPresetData = GameWorld(Name: "World1", creatData: Date(), GameData: nil)
        self.LevelPresetData = Level(Level: 0, NowExperience: 0, initialLevelUpExperience: 10, LevelUpExperienceGrowthRatio: 1.5, LevelGivePoint: 3,LevelGiveSkillPoint:10, IntellectAddition: 1, LevelGiveHealthPoint: 10, LevelGiveHealthGrowthRatio: 0, AttributePoint: 0, SkillPoint: 0)
        self.HealthPresetData = Health(NowHealth: 100, MaxHealth: 100, PowerAddition: 10)
        self.RoleAttributesPreseData = RoleAttributes(Level: self.LevelPresetData, Health: self.HealthPresetData, Power: 10, Intellect: 10, Agile: 10, Equipment: Equipment())
        self.NPCModePresetData = NPC(id: -1, Name: "模型人", image: "模型人", RoleAttributes: self.RoleAttributesPreseData, Camp: .My, GiveExperience: 0, GiveMoney: 0)
    }
}

enum UseWeapon {
    case NPCPrimaryWeapon
    case NPCSecondaryWeapon
    case VehiclePrimaryWeapon
    case VehicleSecondaryWeapon
}

enum UseWeapon2{
    case PrimaryWeapon
    case SecondaryWeapon
}
//前後 上下 左右
enum Direction{
    case forward
    case backward
    case up
    case down
    case left
    case right
}

enum Direction1D{
    case forward
    case backward
}

class NPCObj{
    var NPC:NPC
    var PrimaryWeapon:Weapon? = nil
    var SecondaryWeapon:Weapon? = nil
    var position:Double
    var BossBuffer:Int
    var captainBuffer = [0,0,0]
    
    init(NPC:NPC){
        self.NPC = NPC
        self.position = 0
        self.BossBuffer = 0
        EqWeapon()
    }
    
    init(NPC:NPC,BossBuffer:Int){
        self.NPC = NPC
        self.position = 0
        self.BossBuffer = BossBuffer
        EqWeapon()
    }
    
    func EqWeapon(){
        if(NPC.RoleAttributes.Equipment.Vehicle?.PrimaryWeapon != nil && NPC.RoleAttributes.Equipment.Vehicle?.SecondaryWeapon != nil){
            self.PrimaryWeapon = NPC.RoleAttributes.Equipment.Vehicle?.PrimaryWeapon
            self.SecondaryWeapon = NPC.RoleAttributes.Equipment.Vehicle?.SecondaryWeapon
        }else{
            self.PrimaryWeapon = NPC.RoleAttributes.Equipment.PrimaryWeapon
            self.SecondaryWeapon = NPC.RoleAttributes.Equipment.SecondaryWeapon
        }
    }
    
    func getHP() -> Int {
        return self.NPC.RoleAttributes.Health.NowHealth
    }
    
    func addHP(InputH:Int){
        self.NPC.RoleAttributes.Health.NowHealth += InputH
    }
    
    func returnNPC() -> NPC {
        return self.NPC
    }
    
    func setPosition(InPosition:Double){
        self.position = InPosition
    }
    
    func returnPosition()->Double{
        return self.position
    }
    
    func returnAttackTimes(UseWeapon:UseWeapon2)->Int{
        var ReturnInt = 0.0
        switch(UseWeapon){
        case .PrimaryWeapon:
            ReturnInt = self.PrimaryWeapon?.AttackSpeed ?? 0
        case .SecondaryWeapon:
            ReturnInt = self.SecondaryWeapon?.AttackSpeed ?? 0
        }
        return Int(ReturnInt)
    }
    
    func NPCAttackRange(UseWeapon:UseWeapon2)->Int{
        var ReturnInt = 0
        switch(UseWeapon){
        case .PrimaryWeapon:
            ReturnInt = self.PrimaryWeapon!.AttackRange
        case .SecondaryWeapon:
            ReturnInt = self.SecondaryWeapon!.AttackRange
        }
        return ReturnInt
    }
    
    func AttackB(B:NPC,AttackRange:Int,UseWeapon:UseWeapon2)->Int{
        var Aattack:Int = 0
        var AArmorPiercing = 0
        var BDefense:Double = 0
        switch(UseWeapon){
        case .PrimaryWeapon:
            Aattack = UserAttackWeapon(self.PrimaryWeapon,self.NPC.RoleAttributes)
            AArmorPiercing = self.PrimaryWeapon!.ArmorPiercing
            if(AttackRange > self.PrimaryWeapon!.AttackRange){ return -1}
        case .SecondaryWeapon:
            Aattack = UserAttackWeapon(self.SecondaryWeapon,self.NPC.RoleAttributes)
            AArmorPiercing = self.SecondaryWeapon!.ArmorPiercing
            if(AttackRange > self.SecondaryWeapon!.AttackRange){ return -1}
        }
        if(B.RoleAttributes.Equipment.Vehicle?.Armor != nil){
            BDefense = RealUserDefense(UserArmor: (B.RoleAttributes.Equipment.Vehicle?.Armor)!)*Double((B.RoleAttributes.Agile+1)/100)
        }else if(B.RoleAttributes.Equipment.Armor != nil){
            BDefense = RealUserDefense(UserArmor: B.RoleAttributes.Equipment.Armor!)*Double((B.RoleAttributes.Agile+1)/100)
        }else{
            BDefense = 0
        }
        let DefenseEffect = (Double(AArmorPiercing)-(Double(BDefense)*0.99))/Double(AArmorPiercing)
        var AattackHurt = Int(Double(Aattack)*DefenseEffect)
        if(AattackHurt < 0){AattackHurt = 0}
        return AattackHurt
    }
    
    func UserAttackWeapon(_ UserWeapon:Weapon?,_ UserAttributes:RoleAttributes)->Int{
        var UserPower = 0
        if(UserWeapon == nil){
            return 0
        }else if(UserWeapon!.WeaponType == .Power){
            UserPower =  UserAttributes.Power + RealPower(NPCAttributes: UserAttributes)
            return Int(Double(UserWeapon!.Attack)*(log(Double(UserPower)/Double(10))+1.0))
        }else{
            return UserWeapon!.Attack
        }
    }
    
    func RealUserDefense(UserArmor:Armor)->Double{
        return Double.random(in: Double(UserArmor.MinDefense)...Double(UserArmor.MaxDefense))
    }
    
    func RealPower(NPCAttributes:RoleAttributes)->Int{
        var returnPower:Int = 0
        if(NPCAttributes.Skill != nil){
            if(NPCAttributes.Skill![0].SkillType == .Power){
                returnPower = NPCAttributes.Skill![0].SkillEffect*NPCAttributes.Skill![0].LevelGiveEffect*NPCAttributes.Skill![0].SkillLevel
            }
        }
        if(NPCAttributes.UseMaterial != nil){
            for FindPower in 0..<NPCAttributes.UseMaterial!.endIndex{
                if(NPCAttributes.UseMaterial![FindPower].Power > 0){
                    if(NPCAttributes.UseMaterial![FindPower].Duration > 0){
                        returnPower = returnPower + NPCAttributes.UseMaterial![FindPower].Power
                        break
                    }
                }
            }
        }
        return returnPower+BossBuffer
    }
    
    func SelectTarget(Target:[Int],TargetForce:[NPCObj]) -> Int{
        var MinDefense:Int = Int.max
        var TargetNumber:Int = 0
        for T in 0..<Target.endIndex{
            if(TargetForce[Target[T]].NPC.RoleAttributes.Equipment.Vehicle?.Armor != nil){
                if((TargetForce[Target[T]].NPC.RoleAttributes.Equipment.Vehicle?.Armor!.MaxDefense)! < MinDefense){
                    MinDefense = (TargetForce[Target[T]].NPC.RoleAttributes.Equipment.Vehicle?.Armor!.MaxDefense)!
                    TargetNumber = Target[T]
                    
                }
                //print("VD\(TargetNumber) \((TargetForce[Target[T]].NPC.RoleAttributes.Equipment.Vehicle?.Armor!.MaxDefense)!) \(MinDefense)")
            }else if(TargetForce[Target[T]].NPC.RoleAttributes.Equipment.Armor != nil){
                if(TargetForce[Target[T]].NPC.RoleAttributes.Equipment.Armor!.MaxDefense < MinDefense){
                    MinDefense = TargetForce[Target[T]].NPC.RoleAttributes.Equipment.Armor!.MaxDefense
                    TargetNumber = Target[T]
                }
                //print("ED\(TargetNumber) \(TargetForce[Target[T]].NPC.RoleAttributes.Equipment.Armor!.MaxDefense) \(MinDefense)")
            }else{
                TargetNumber = Target[T]
                //print("N\(TargetNumber) \(MinDefense) \(0)")
                MinDefense = 0
            }
        }
        return TargetNumber
    }
    
    func giveEx(inGiveEX:Int){
        let RgiveEx = Int(self.NPC.RoleAttributes.Level.IntellectAddition * Double(self.NPC.RoleAttributes.Intellect) * Double(inGiveEX))
        var nowEx = self.NPC.RoleAttributes.Level.NowExperience + RgiveEx
        var NowL = self.NPC.RoleAttributes.Level.Level
        let UpLR = self.NPC.RoleAttributes.Level.LevelUpExperienceGrowthRatio
        let iUpLEx = self.NPC.RoleAttributes.Level.initialLevelUpExperience
        while nowEx > Int(Double(NowL)*UpLR*Double(iUpLEx)){
            nowEx = nowEx - Int(Double(NowL)*UpLR*Double(iUpLEx))
            NowL = NowL + 1
            self.NPC.RoleAttributes.Level.AttributePoint = self.NPC.RoleAttributes.Level.AttributePoint + self.NPC.RoleAttributes.Level.LevelGivePoint
            self.NPC.RoleAttributes.Level.SkillPoint = self.NPC.RoleAttributes.Level.AttributePoint + self.NPC.RoleAttributes.Level.LevelGiveSkillPoint
            self.NPC.RoleAttributes.Health.MaxHealth = self.NPC.RoleAttributes.Health.MaxHealth + Int(Double(self.NPC.RoleAttributes.Level.LevelGiveHealthPoint) * self.NPC.RoleAttributes.Level.LevelGiveHealthGrowthRatio * Double(NowL))
        }
        self.NPC.RoleAttributes.Level.NowExperience = nowEx
        self.NPC.RoleAttributes.Level.Level = NowL
    }
    
    func UpLevel(inUpLevel:Int){
        
    }
}

class CreateWarMap{
    var MinPosition:Double
    var MaxPosition:Double
    
    init(MinPosition:Double,MaxPosition:Double){
        var T = 0.0
        self.MinPosition = MinPosition
        self.MaxPosition = MaxPosition
        if(self.MinPosition > self.MaxPosition){
            T = self.MinPosition
            self.MinPosition = self.MaxPosition
            self.MaxPosition = T
        }
    }
    
    func NPCGo(NPC:NPCObj,NNPC:[NPCObj],Direction:Direction1D)->Double{
        var addValue:Int = 1
        var GoPosition = 0.0
        
        switch Direction {
            case .forward:addValue = 1
            case .backward:addValue = -1
        }
        
        if(NPC.NPC.RoleAttributes.Equipment.Vehicle != nil){
            GoPosition = NPC.position + NPC.NPC.RoleAttributes.Equipment.Vehicle!.MovingSpeed*Double(addValue)
        }else{
            GoPosition = NPC.position + 6*Double(addValue)
        }
        for LoopT in 0..<NNPC.endIndex{
            if(NNPC[LoopT].NPC.RoleAttributes.Health.NowHealth > 0){
                if(Direction == .forward){
                    if(NNPC[LoopT].position <=  GoPosition){
                        GoPosition = NNPC[LoopT].position - 1
                    }
                    //print("\(NNPC[LoopT]) ++ \(NPC.position)")
                }else if(Direction == .backward){
                    if(NNPC[LoopT].position >=  GoPosition){
                        GoPosition = NNPC[LoopT].position + 1
                    }
                    //print("\(NNPC[LoopT]) ++ \(NPC.position)")
                }
            }
        }
        return GoPosition
    }
    
    func NPCDetectClosestNPC(NPC:NPCObj,NNPC:[NPCObj])->Int{
        var ClosestBNPCNumber = -1
        var MinDistance = self.MaxPosition - self.MinPosition
        for LoopT in 0..<NNPC.endIndex{
            if(ABDistance(NPCA: NPC, NPCB: NNPC[LoopT]) < MinDistance && NNPC[LoopT].getHP() > 0){
                MinDistance = ABDistance(NPCA: NPC, NPCB: NNPC[LoopT])
                ClosestBNPCNumber = LoopT
            }
        }
        //print("BNPC => \(ClosestBNPCNumber)")
        return ClosestBNPCNumber
    }
    
    func NPCDetectClosestNPCArray(NPC:NPCObj,NNPC:[NPCObj])->[Int]{
        var ClosestBNPCNumber = [Int]()
        var MinDistance = self.MaxPosition - self.MinPosition
        for LoopT in 0..<NNPC.endIndex{
            if(ABDistance(NPCA: NPC, NPCB: NNPC[LoopT]) <= MinDistance && NNPC[LoopT].getHP() > 0){
                MinDistance = ABDistance(NPCA: NPC, NPCB: NNPC[LoopT])
            }
        }
        for LoopT in 0..<NNPC.endIndex{
            if(ABDistance(NPCA: NPC, NPCB: NNPC[LoopT]) <= MinDistance && NNPC[LoopT].getHP() > 0){
                ClosestBNPCNumber.append(LoopT)
            }
        }
        //print("BNPC => \(ClosestBNPCNumber)")
        return ClosestBNPCNumber
    }
    
    func NPCSelectRecentAimsNPC(NPC:NPCObj,NNPC:[NPCObj])->Int{
        var ClosestBNPCNumber = -1
        var MinDistance = self.MaxPosition - self.MinPosition
        var MinDefense:Int = Int.max
        for LoopT in 0..<NNPC.endIndex{
            if(NNPC[LoopT].getHP() > 0){
                if(ABDistance(NPCA: NPC, NPCB: NNPC[LoopT]) < MinDistance){
                    MinDistance = ABDistance(NPCA: NPC, NPCB: NNPC[LoopT])
                    ClosestBNPCNumber = LoopT
                }else if(ABDistance(NPCA: NPC, NPCB: NNPC[LoopT]) == MinDistance){
                    if(NNPC[LoopT].NPC.RoleAttributes.Equipment.Vehicle?.Armor != nil){
                        if(MinDefense > (NNPC[LoopT].NPC.RoleAttributes.Equipment.Vehicle?.Armor!.MaxDefense)!){
                            MinDefense = (NNPC[LoopT].NPC.RoleAttributes.Equipment.Vehicle?.Armor!.MaxDefense)!
                            ClosestBNPCNumber = LoopT
                        }
                    }else if(NNPC[LoopT].NPC.RoleAttributes.Equipment.Armor != nil){
                        if(MinDefense > (NNPC[LoopT].NPC.RoleAttributes.Equipment.Armor!.MaxDefense)){
                            MinDefense = (NNPC[LoopT].NPC.RoleAttributes.Equipment.Armor!.MaxDefense)
                            ClosestBNPCNumber = LoopT
                        }
                    }else{
                        MinDefense = 0
                        ClosestBNPCNumber = LoopT
                    }
                }
            }
        }
        //print("BNPC => \(ClosestBNPCNumber)")
        return ClosestBNPCNumber
    }
    
    func ABDistance(NPCA:NPCObj,NPCB:NPCObj) -> Double {
        return fabs(NPCA.position - NPCB.position)
    }
}

class War:ObservableObject{
    @Published var AForce:Force
    @Published var BForce:Force
    @Published var ANPC = [NPCObj]()
    @Published var BNPC = [NPCObj]()
    @Published var WarMap:CreateWarMap
    @Published var TurnO:Int = 0
    var MaxValue = 10000.0
    var MinValue = 0.0
    var SUMAEX = 0
    var SUMAMoney = 0
    var SUMBEX = 0
    var SUMBMoney = 0
    var StringArray = [String]()
    
    init(){
        self.AForce = Force(id:-1,Name:"AA",image:"AA",NPCForce:[])
        self.BForce = Force(id:-1,Name:"AA",image:"AA",NPCForce:[])
        self.WarMap = CreateWarMap(MinPosition: MinValue, MaxPosition: MaxValue)
        for LoopCreate in 0..<AForce.NPCForce.endIndex{
            self.ANPC.append(NPCObj(NPC: AForce.NPCForce[LoopCreate]))
            self.ANPC[LoopCreate].position = MinValue
            print("A\(LoopCreate)Ok")
        }
        for LoopCreate in 0..<BForce.NPCForce.endIndex{
            self.BNPC.append(NPCObj(NPC: BForce.NPCForce[LoopCreate]))
            self.BNPC[LoopCreate].position = MaxValue
            print("B\(LoopCreate)Ok")
        }
    }
    
    init(AForce:Force,BForce:Force){
        self.AForce = AForce
        self.BForce = BForce
        self.WarMap = CreateWarMap(MinPosition: MinValue, MaxPosition: MaxValue)
        self.ANPC = []
        self.BNPC = []
    }
    
    func WarState(){
        var LoopMax = 0
        for LoopCreate in 0..<AForce.NPCForce.endIndex{
            if(AForce.TeamLeader != nil){
                if(AForce.TeamLeader?.RoleAttributes.Skill != nil){
                    for I in 0..<(AForce.TeamLeader?.RoleAttributes.Skill!.endIndex)!{
                        if(AForce.TeamLeader?.RoleAttributes.Skill![I].SkillType == .CompanionPower){
                            let BufferValue = (AForce.TeamLeader?.RoleAttributes.Skill![I].SkillEffect)!
                            let BufferLevel = AForce.TeamLeader?.RoleAttributes.Skill![I].SkillLevel
                            let BufferAdd = (AForce.TeamLeader?.RoleAttributes.Skill![I].LevelGiveEffect)!
                            let SumBufferValue = BufferValue*BufferLevel!*BufferAdd
                            self.ANPC.append(NPCObj(NPC: AForce.NPCForce[LoopCreate],BossBuffer: SumBufferValue))
                            break
                        }
                    }
                }
            }else{
                self.ANPC.append(NPCObj(NPC: AForce.NPCForce[LoopCreate]))
            }
            self.ANPC[LoopCreate].position = MinValue
            print("A\(LoopCreate)Ok\(AForce.NPCForce.endIndex)")
        }
        for LoopCreate in 0..<BForce.NPCForce.endIndex{
            if(BForce.TeamLeader != nil){
                if(BForce.TeamLeader?.RoleAttributes.Skill != nil){
                    for I in 0..<(BForce.TeamLeader?.RoleAttributes.Skill!.endIndex)!{
                        if(BForce.TeamLeader?.RoleAttributes.Skill![I].SkillType == .CompanionPower){
                            let BufferValue = (BForce.TeamLeader?.RoleAttributes.Skill![I].SkillEffect)!
                            let BufferLevel = BForce.TeamLeader?.RoleAttributes.Skill![I].SkillLevel
                            let BufferAdd = (BForce.TeamLeader?.RoleAttributes.Skill![I].LevelGiveEffect)!
                            let SumBufferValue = BufferValue*BufferLevel!*BufferAdd
                            self.ANPC.append(NPCObj(NPC: BForce.NPCForce[LoopCreate],BossBuffer: SumBufferValue))
                            break
                        }
                    }
                }
            }else{
                self.BNPC.append(NPCObj(NPC: BForce.NPCForce[LoopCreate]))
            }
            self.BNPC[LoopCreate].position = MaxValue
            print("B\(LoopCreate)Ok\(BForce.NPCForce.endIndex)")
        }
        if(AForce.NPCForce.endIndex > BForce.NPCForce.endIndex){
            LoopMax = AForce.NPCForce.endIndex
        }else{
            LoopMax = BForce.NPCForce.endIndex
        }
        for LoopMove in 0..<LoopMax{
            if(LoopMove < AForce.NPCForce.endIndex){
                ANPC[LoopMove].position = WarMap.NPCGo(NPC: ANPC[LoopMove], NNPC: BNPC, Direction: .forward)
            }
            if(LoopMove < BForce.NPCForce.endIndex){
                BNPC[LoopMove].position = WarMap.NPCGo(NPC: BNPC[LoopMove], NNPC: ANPC, Direction: .backward)
            }
        }
    }
    
    func BUN(){
        var AttackTrunTime = 43200
        while(ANPC.endIndex > 0 && BNPC.endIndex > 0 && AttackTrunTime > 0){
            NewBattle()
            AttackTrunTime = AttackTrunTime-1
        }
    }
    
    func NewBattle(){
        if(ANPC.endIndex <= 0){
            TurnO = -1
            SUMAEX = 0
            SUMAMoney = 0
            return
        }else if(BNPC.endIndex <= 0){
            TurnO = -2
            SUMBEX = 0
            SUMBMoney = 0
            return
        }
        var TargetId:Int
        var Target:NPCObj
        var AToTarget:Int
        var HurtValue:Int
        for LoopAttack in 0..<ANPC.endIndex{
            if(ANPC[LoopAttack].PrimaryWeapon != nil){
                for _ in 0..<Int(ANPC[LoopAttack].PrimaryWeapon!.AttackSpeed){
                    TargetId = WarMap.NPCSelectRecentAimsNPC(NPC: ANPC[LoopAttack], NNPC: BNPC)
                    if(TargetId >= 0){
                        Target = BNPC[TargetId]
                        AToTarget = Int(WarMap.ABDistance(NPCA: ANPC[LoopAttack], NPCB: Target))
                        HurtValue = (ANPC[LoopAttack].AttackB(B: Target.NPC, AttackRange: AToTarget, UseWeapon: .PrimaryWeapon))
                        if(HurtValue >= 0){
                            BNPC[TargetId].addHP(InputH: -1*HurtValue)
                            //StringArray.append("第\(TurnO)秒\(ANPC[LoopAttack].NPC.Name)\(LoopAttack)用\(String(describing: ANPC[LoopAttack].PrimaryWeapon?.Name))攻擊了\(BNPC[TargetId].NPC.Name) 造成\(HurtValue)點傷害")
                            if(BNPC[TargetId].getHP() <= 0){
                                StringArray.append("第\(TurnO)秒 我方的\(ANPC[LoopAttack].NPC.Name)用\(ANPC[LoopAttack].PrimaryWeapon?.Name ?? "Nil") 造成\(HurtValue)點傷害殺死 敵方的\(BNPC[TargetId].NPC.Name)")
                            }
                        }else{
                            ANPC[LoopAttack].position = WarMap.NPCGo(NPC: ANPC[LoopAttack], NNPC: BNPC, Direction: .forward)
                        }
                    }
                }
                //print("AAttackB\(TargetId) Hurt\(HurtValue)")
            }
            if(ANPC[LoopAttack].SecondaryWeapon != nil){
                for _ in 0..<Int(ANPC[LoopAttack].SecondaryWeapon!.AttackSpeed){
                    TargetId = WarMap.NPCSelectRecentAimsNPC(NPC: ANPC[LoopAttack], NNPC: BNPC)
                    if(TargetId >= 0){
                        Target = BNPC[TargetId]
                        AToTarget = Int(WarMap.ABDistance(NPCA: ANPC[LoopAttack], NPCB: Target))
                        HurtValue = (ANPC[LoopAttack].AttackB(B: Target.NPC, AttackRange: AToTarget, UseWeapon: .PrimaryWeapon))
                        if(HurtValue >= 0){
                            BNPC[TargetId].addHP(InputH: -1*(HurtValue))
                            //StringArray.append("第\(TurnO)秒\(ANPC[LoopAttack].NPC.Name)\(LoopAttack)用\(String(describing: ANPC[LoopAttack].SecondaryWeapon?.Name))攻擊了\(BNPC[TargetId].NPC.Name) 造成\(HurtValue)點傷害")
                            if(BNPC[TargetId].getHP() <= 0){
                                StringArray.append("第\(TurnO)秒 我方的\(ANPC[LoopAttack].NPC.Name)用\(ANPC[LoopAttack].SecondaryWeapon?.Name ?? "Nil") 造成\(HurtValue)點傷害殺死 敵方的\(BNPC[TargetId].NPC.Name)")
                            }
                        }else{
                            ANPC[LoopAttack].position = WarMap.NPCGo(NPC: ANPC[LoopAttack], NNPC: BNPC, Direction: .forward)
                        }
                    }
                }
                //print("AAttackB\(TargetId) Hurt\(HurtValue)")
            }
        }
        
        for LoopAttack in 0..<BNPC.endIndex{
            if(BNPC[LoopAttack].PrimaryWeapon != nil){
                for _ in 0..<Int(BNPC[LoopAttack].PrimaryWeapon!.AttackSpeed){
                    TargetId = WarMap.NPCSelectRecentAimsNPC(NPC: BNPC[LoopAttack], NNPC: ANPC)
                    if(TargetId >= 0){
                        Target = ANPC[TargetId]
                        AToTarget = Int(WarMap.ABDistance(NPCA: BNPC[LoopAttack], NPCB: Target))
                        HurtValue = BNPC[LoopAttack].AttackB(B: Target.NPC, AttackRange: AToTarget, UseWeapon: .PrimaryWeapon)
                        if(HurtValue >= 0){
                            ANPC[TargetId].addHP(InputH: -1*(HurtValue))
                            //StringArray.append("第\(TurnO)秒\(BNPC[LoopAttack].NPC.Name)\(LoopAttack)用\(String(describing: BNPC[LoopAttack].PrimaryWeapon?.Name))攻擊了\(ANPC[TargetId].NPC.Name) 造成\(HurtValue)點傷害")
                            if(ANPC[TargetId].getHP() <= 0){
                                StringArray.append("第\(TurnO)秒 敵方的\(BNPC[LoopAttack].NPC.Name)用\(BNPC[LoopAttack].PrimaryWeapon?.Name ?? "Nil") 造成\(HurtValue)點傷害殺死 我方的\(ANPC[TargetId].NPC.Name)")
                            }
                        }else{
                            BNPC[LoopAttack].position = WarMap.NPCGo(NPC: BNPC[LoopAttack], NNPC: ANPC, Direction: .backward)
                        }
                    }
                }
                //print("BAttackA\(TargetId) Hurt\(HurtValue)")
            }
            if(BNPC[LoopAttack].SecondaryWeapon != nil){
                if(BNPC[LoopAttack].SecondaryWeapon != nil){
                    for _ in 0..<Int(BNPC[LoopAttack].SecondaryWeapon!.AttackSpeed){
                        TargetId = WarMap.NPCSelectRecentAimsNPC(NPC: BNPC[LoopAttack], NNPC: ANPC)
                        if(TargetId >= 0){
                            Target = ANPC[TargetId]
                            AToTarget = Int(WarMap.ABDistance(NPCA: BNPC[LoopAttack], NPCB: Target))
                            HurtValue = BNPC[LoopAttack].AttackB(B: Target.NPC, AttackRange: AToTarget, UseWeapon: .SecondaryWeapon)
                            if(HurtValue >= 0){
                                ANPC[TargetId].addHP(InputH: -1*(HurtValue))
                                //StringArray.append("第\(TurnO)秒\(BNPC[LoopAttack].NPC.Name)\(LoopAttack)用\(String(describing: BNPC[LoopAttack].SecondaryWeapon?.Name))攻擊了\(ANPC[TargetId].NPC.Name) 造成\(HurtValue)點傷害")
                                if(ANPC[TargetId].getHP() <= 0){
                                    StringArray.append("第\(TurnO)秒 敵方的\(BNPC[LoopAttack].NPC.Name)用\(BNPC[LoopAttack].SecondaryWeapon?.Name ?? "Nil") 造成\(HurtValue)點傷害殺死 我方的\(ANPC[TargetId].NPC.Name)")
                                }
                            }else{
                                BNPC[LoopAttack].position = WarMap.NPCGo(NPC: BNPC[LoopAttack], NNPC: ANPC, Direction: .backward)
                            }
                        }
                        //print("BAttackA\(TargetId) Hurt\(HurtValue)")
                    }
                }
            }
        }
        DataNew()
        TurnO = TurnO + 1
    }
    
    func DataNew(){
        let NANPC = ANPC
        let NBNPC = BNPC
        self.ANPC.removeAll()
        for LoopCreate in 0..<NANPC.endIndex{
            if(NANPC[LoopCreate].NPC.RoleAttributes.Health.NowHealth > 0){
                ANPC.append(NANPC[LoopCreate])
            }else{
                SUMAEX = SUMAEX + NANPC[LoopCreate].NPC.GiveExperience
                SUMAMoney = SUMAMoney + NANPC[LoopCreate].NPC.GiveMoney
                //StringArray.append("第\(TurnO)秒 我方\(NANPC[LoopCreate].NPC.Name)死亡")
            }
        }
        self.BNPC.removeAll()
        for LoopCreate in 0..<NBNPC.endIndex{
            if(NBNPC[LoopCreate].NPC.RoleAttributes.Health.NowHealth > 0){
                BNPC.append(NBNPC[LoopCreate])
            }else{
                SUMBEX = SUMBEX + NBNPC[LoopCreate].NPC.GiveExperience
                SUMBMoney = SUMBMoney + NBNPC[LoopCreate].NPC.GiveMoney
                //StringArray.append("第\(TurnO)秒 敵方\(NBNPC[LoopCreate].NPC.Name)死亡")
            }
        }
    }
    
    func returnA()->Force{
        self.AForce.NPCForce.removeAll()
        for LoopCreate in 0..<ANPC.endIndex{
            self.AForce.NPCForce.append(ANPC[LoopCreate].NPC)
        }
        return AForce
    }
    
    func returnB()->Force{
        self.BForce.NPCForce.removeAll()
        for LoopCreate in 0..<BNPC.endIndex{
            self.BForce.NPCForce.append(BNPC[LoopCreate].NPC)
        }
        return BForce
    }
    
    func giveS() -> [String]{
        return self.StringArray
    }
}
