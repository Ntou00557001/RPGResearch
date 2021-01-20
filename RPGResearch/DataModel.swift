//
//  DataModel.swift
//  RPGResearch
//
//  Created by User10 on 2020/12/31.
//

import SwiftUI

protocol MainAttributes:Identifiable,Codable{
    var id: UUID { get set }
    var Name: String { get set }
}

struct Player:MainAttributes{
    var id: UUID = UUID()
    var Name: String
    var password:String
    var image:String
    var Birthday:Date
    var GameWorldID:[GameWorld]? = nil
    
    enum CodingKeys:String, CodingKey{
        case id
        case Name
        case password
        case image
        case Birthday
        case GameWorldID
    }
}

struct GameWorld:MainAttributes{
    var id: UUID = UUID()
    var Name: String
    var creatData:Date
    var GameData:GameData? = nil
    
    enum CodingKeys:String, CodingKey{
        case id
        case Name
        case creatData
        case GameData
    }
}

struct GameData:Codable{
    //var PlayerRole:PlayerRole
    var money:Int
    var Backpack:[Inventory]? = nil
    var Storehouse:[Inventory]? = nil
    var MapData:Map
    
    enum CodingKeys:String, CodingKey{
        //case PlayerRole
        case money
        case Backpack
        case Storehouse
        case MapData
    }
}

struct Map:Codable{
    var id:Int
    var Name:String
    var AreaNodeData:[AreaNode]?=nil
    
    enum CodingKeys:String, CodingKey{
        case id
        case Name
        case AreaNodeData
    }
}

struct Area:Codable{
    var id:Int
    var Name:String
    var ExplorationRate:Double
    var AreaSize:Int
    var AgileAddExplorationRate:Int
    var IntellectAddDropsProbability:Double
    var AreaStatus:AreaStatus
    var AreaNPC:NPC
    var AreaDrops:Drops
    
    enum CodingKeys:String, CodingKey{
        case id
        case Name
        case ExplorationRate
        case AreaSize
        case AgileAddExplorationRate
        case IntellectAddDropsProbability
        case AreaStatus
        case AreaNPC
        case AreaDrops
    }
}

enum AreaStatus:String,Codable{
    case Exploreable
    case Unexplorable
    
    enum CodableKeys:String,CodingKey {
        case AreaStatus
    }
    
    enum CodingError: Error { case decodig(String) }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodableKeys.self)

        guard let AreaStatusString = try? values.decode(String.self, forKey: .AreaStatus) else { throw CodingError.decodig("Decode error \(dump(values))") }

        if let AreaStatus = AreaStatus.init(rawValue: AreaStatusString) {
            self = AreaStatus
            return
        }

        throw CodingError.decodig("Decode error \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableKeys.self)
        try container.encode(rawValue, forKey: .AreaStatus)
    }
}

struct AreaNode:Codable{
    var Area:Area
    var ReachableAreaID:[Int]? = nil
    
    enum CodingKeys:String, CodingKey{
        case Area
        case ReachableAreaID
    }
}

struct Inventory:Codable{
    var id:Int
    var ResType:MaterialType
    var NumberOfPossessions:Int
    
    enum CodingKeys:String, CodingKey{
        case id
        case ResType
        case NumberOfPossessions
    }
}

struct City:Codable{
    var id:Int
    var Name: String
    var CityLevel:Int
    var AreaStatus:AreaStatus
    var CityForce:[Force]? = nil
    var CityCamp:Camp
    var ExplorationRate:Double
    var DemandGoods:[Inventory]? = nil
    var SupplyGoods:[Inventory]? = nil
    
    enum CodingKeys:String, CodingKey{
        case id
        case Name
        case CityLevel
        case AreaStatus
        case CityForce
        case CityCamp 
        case ExplorationRate
        case DemandGoods
        case SupplyGoods
    }
}

struct Building:Codable{
    var id:Int
    var Name:String
    var Level:Int
    var UpLevelMoney:Int
    var giveMoney:Int
    var giveNPC:[NPC]? = nil
    var giveDrops:[Drops]? = nil
    var MaintenanceCost:Int
    var MakeFormula:[Formula]? = nil
    
    enum CodingKeys:String,CodingKey{
        case id
        case Name
        case Level
        case UpLevelMoney
        case giveMoney
        case giveNPC
        case giveDrops
        case MaintenanceCost
        case MakeFormula
    }
}

struct PlayerRole:MainAttributes{
    var id:UUID = UUID()
    var Name:String
    var image:String
    var RoleAttributes:RoleAttributes
    
    enum CodingKeys:String, CodingKey{
        case id
        case Name
        case image
        case RoleAttributes
    }
}

struct RoleAttributes:Codable{
    var Level:Level
    var Health:Health
    var Power:Int
    var Intellect:Int
    var Agile:Int
    var Equipment:Equipment
    var Skill:[Skill]? = nil
    var Material:[material]? = nil
    var UseMaterial:[material]? = nil
    
    enum CodingKeys:String, CodingKey{
        case Level
        case Health
        case Power
        case Intellect
        case Agile
        case Equipment
        case Skill
        case Material
        case UseMaterial
    }
}

struct NPC:Codable{
    var id:Int
    var Name: String
    var image:String
    var RoleAttributes:RoleAttributes
    var Camp:Camp
    var GiveExperience:Int
    var GiveMoney:Int
    var Drops:Drops? = nil
    
    enum CodingKeys:String, CodingKey{
        case id
        case Name
        case image
        case RoleAttributes
        case Camp
        case GiveExperience
        case GiveMoney
        case Drops
    }
}

struct Drops:Codable{
    var Id:Int
    var MaterialType:MaterialType
    var GiveMinNumber:Int
    var GiveMaxNumber:Int
    var DropsProbability:Double
    
    enum CodingKeys:String, CodingKey{
        case Id
        case MaterialType
        case GiveMinNumber
        case GiveMaxNumber
        case DropsProbability
    }
}

enum Camp:String,Codable{
    case None
    case My
    case Enemy
    case Friendly
    
    enum CodableKeys:String,CodingKey {
        case Camp
    }
    
    enum CodingError: Error { case decodig(String) }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodableKeys.self)

        guard let CampString = try? values.decode(String.self, forKey: .Camp) else { throw CodingError.decodig("Decode error \(dump(values))") }

        if let Camp = Camp.init(rawValue: CampString) {
            self = Camp
            return
        }

        throw CodingError.decodig("Decode error \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableKeys.self)
        try container.encode(rawValue, forKey: .Camp)
    }
}

struct Equipment:Codable{
    var PrimaryWeapon:Weapon? = nil
    var SecondaryWeapon:Weapon? = nil
    var Armor:Armor? = nil
    var Vehicle:Vehicle? = nil
    
    enum CodingKeys:String, CodingKey{
        case PrimaryWeapon
        case SecondaryWeapon
        case Armor
        case Vehicle
    }
}

enum SkillType:String,Codable{
    case None
    case MaxHealth
    case Power
    case Intellect
    case Agile
    case GetExperience
    case CompanionPower
    case CompanionIntellect
    case CompanionAgile
    case GetMoney
    
    enum CodableKeys:String,CodingKey {
        case SkillType
    }
    
    enum CodingError: Error { case decodig(String) }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodableKeys.self)

        guard let SkillTypeString = try? values.decode(String.self, forKey: .SkillType) else { throw CodingError.decodig("Decode error \(dump(values))") }

        if let SkillType = SkillType(rawValue: SkillTypeString) {
            self = SkillType
            return
        }

        throw CodingError.decodig("Decode error \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableKeys.self)
        try container.encode(rawValue, forKey: .SkillType)
    }
}

struct Skill:Codable{
	var id:Int
	var Name:String
	var SkillDescription:String
	var SkillLevel:Int
	var SkillMaxLevel:Int
	var GetSkill:Int
	var UpLevelNeedSkillPoint:Int
	var UpLevelSkillPointGrowthRatio:Int
	var SkillType:SkillType
	var SkillEffect:Int
	var LevelGiveEffect:Int
    
    enum CodingKeys:String, CodingKey{
        case id
        case Name
        case SkillDescription
        case SkillLevel
        case SkillMaxLevel
        case GetSkill
        case UpLevelNeedSkillPoint
        case UpLevelSkillPointGrowthRatio
        case SkillType
        case SkillEffect
        case LevelGiveEffect
    }
}

struct Level:Codable{
    var Level:Int
    var NowExperience:Int
    var initialLevelUpExperience:Int
    var LevelUpExperienceGrowthRatio:Double
    var LevelGivePoint:Int
    var LevelGiveSkillPoint:Int
    var IntellectAddition:Double
    var LevelGiveHealthPoint:Int
    var LevelGiveHealthGrowthRatio:Double
    var AttributePoint:Int
    var SkillPoint:Int
    
    enum CodingKeys:String, CodingKey{
        case Level
        case NowExperience
        case initialLevelUpExperience
        case LevelUpExperienceGrowthRatio
        case LevelGivePoint
        case LevelGiveSkillPoint
        case IntellectAddition
        case LevelGiveHealthPoint
        case LevelGiveHealthGrowthRatio
        case AttributePoint
        case SkillPoint
    }
}

struct Health:Codable{
    var NowHealth:Int
    var MaxHealth:Int
    var PowerAddition:Int
    
    enum CodingKeys:String, CodingKey{
        case NowHealth
        case MaxHealth
        case PowerAddition
    }
}

enum ResType:String,Codable{
    case NonConsumable
    case Consumables
    case Continued
    case Resources
    
    enum CodableKeys:String,CodingKey {
        case ResType
    }
    
    enum CodingError: Error { case decodig(String) }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodableKeys.self)

        guard let ResTypeString = try? values.decode(String.self, forKey: .ResType) else { throw CodingError.decodig("Decode error \(dump(values))") }

        if let ResType = ResType.init(rawValue: ResTypeString) {
            self = ResType
            return
        }

        throw CodingError.decodig("Decode error \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableKeys.self)
        try container.encode(rawValue, forKey: .ResType)
    }
}

enum MaterialType:String,Codable{
    case None
    case Consumables
    case Armor
    case Weapon
    case Vehicle
    
    enum CodableKeys:String,CodingKey {
        case MaterialType
    }
    
    enum CodingError: Error { case decodig(String) }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodableKeys.self)

        guard let MaterialTypeString = try? values.decode(String.self, forKey: .MaterialType) else { throw CodingError.decodig("Decode error \(dump(values))") }

        if let MaterialType = MaterialType.init(rawValue: MaterialTypeString) {
            self = MaterialType
            return
        }

        throw CodingError.decodig("Decode error \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableKeys.self)
        try container.encode(rawValue, forKey: .MaterialType)
    }
}

struct material:Codable{
    var id:Int
    var Name:String
    var image:String
    var ResType:ResType
    var Duration:Int
    var Health:Int
    var Power:Int
    var Agile:Int
    var moneyValue:Int
    
    enum CodingKeys:String, CodingKey{
        case id
        case Name
        case image
        case ResType
        case Duration
        case Health
        case Power
        case Agile
        case moneyValue
    }
}

enum WeaponType:String,Codable{
    case Power
    case NoPower
    
    enum CodableKeys:String,CodingKey {
        case WeaponType
    }
    
    enum CodingError: Error { case decodig(String) }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodableKeys.self)

        guard let WeaponTypeString = try? values.decode(String.self, forKey: .WeaponType) else { throw CodingError.decodig("Decode error \(dump(values))") }

        if let WeaponType = WeaponType.init(rawValue: WeaponTypeString) {
            self = WeaponType
            return
        }

        throw CodingError.decodig("Decode error \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableKeys.self)
        try container.encode(rawValue, forKey: .WeaponType)
    }
}

struct Weapon:Codable{
    var id:Int
    var Name:String
    var image:String
    var WeaponType:WeaponType
    var Attack:Int
    var ArmorPiercing:Int
    var AttackSpeed:Double
    var AttackRange:Int
    var HitProbability:Double
    var Weight:Double
    var moneyValue:Int
    
    enum CodingKeys:String, CodingKey{
        case id
        case Name
        case image
        case WeaponType
        case Attack
        case ArmorPiercing
        case AttackSpeed
        case AttackRange
        case HitProbability
        case Weight
        case moneyValue
    }
}

struct Armor:Codable{
    var id:Int
    var Name:String
    var image:String
    var MaxDefense:Int
    var MinDefense:Int
    var Weight:Double
    var moneyValue:Int
    
    enum CodingKeys:String, CodingKey{
        case id
        case Name
        case image
        case MaxDefense
        case MinDefense
        case Weight
        case moneyValue
    }
}

struct Vehicle:Codable{
    var id:Int
    var Name:String
    var image:String
    var PrimaryWeapon:Weapon? = nil
    var SecondaryWeapon:Weapon? = nil
    var Armor:Armor? = nil
    var MovingSpeed:Double
    var LoadWeight:Double
    var moneyValue:Int
    
    enum CodingKeys:String, CodingKey{
        case id
        case Name
        case image
        case PrimaryWeapon
        case SecondaryWeapon
        case Armor
        case MovingSpeed
        case LoadWeight
        case moneyValue
    }
}

enum ModelStatus:String,Codable{
    case On
    case Off
    
    enum CodableKeys:String,CodingKey {
        case ModelStatus
    }
    
    enum CodingError: Error { case decodig(String) }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodableKeys.self)

        guard let ModelStatusString = try? values.decode(String.self, forKey: .ModelStatus) else { throw CodingError.decodig("Decode error \(dump(values))") }

        if let ModelStatus = ModelStatus.init(rawValue: ModelStatusString) {
            self = ModelStatus
            return
        }

        throw CodingError.decodig("Decode error \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableKeys.self)
        try container.encode(rawValue, forKey: .ModelStatus)
    }
}

struct Model:Codable{
    var id:Int
    var Name:String
    var image:String
    var ModelStatus:ModelStatus = .On
    var materialLibrary:[material]? = nil
    var WeaponLibrary:[Weapon]? = nil
    var ArmorLibrary:[Armor]? = nil
    var VehicleLibrary:[Vehicle]? = nil
    var SkillLibrary:[Skill]? = nil
    var MapLibrary:[Map]? = nil
    var NPCLibrary:[NPC]? = nil
    var ForceLibrary:[Force]? = nil
    var BuildingLibrary:[Building]? = nil
    var CityLibraray:[City]? = nil
    
    enum CodingKeys:String, CodingKey{
        case id
        case Name
        case image
        case ModelStatus
        case materialLibrary
        case WeaponLibrary
        case ArmorLibrary
        case VehicleLibrary
        case SkillLibrary
        case MapLibrary
        case NPCLibrary
        case ForceLibrary
        case BuildingLibrary
        case CityLibraray
    }
}

struct Formula:Codable{
    var id:Int
    var Name:String
    var image:String
    var Composite:[Inventory]? = nil
    var Product:[Inventory]? = nil
    
    enum CodingKeys:String,CodingKey{
        case id
        case Name
        case image
        case Composite
        case Product
    }
    
}

struct Force:Codable{
    var id:Int
    var Name:String
    var image:String
    var TeamLeader:NPC? = nil
    var NPCForce:[NPC]
    
    enum CodingKeys:String,CodingKey{
        case id
        case Name
        case image
        case TeamLeader
        case NPCForce
    }
}
