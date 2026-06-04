import Foundation
import SwiftUI

// MARK: - World Challenge

enum ChallengeType: String, CaseIterable, Codable {
    case climate = "Climate Crisis"
    case poverty = "Poverty & Hunger"
    case inequality = "Social Inequality"
    case isolation = "Human Connection"
    case pollution = "Ocean Pollution"
    case deforestation = "Deforestation"
    case futureAnxiety = "Future & Fear"

    var icon: String {
        switch self {
        case .climate:       return "thermometer.sun.fill"
        case .poverty:       return "house.fill"
        case .inequality:    return "person.3.fill"
        case .isolation:     return "heart.fill"
        case .pollution:     return "drop.fill"
        case .deforestation: return "leaf.fill"
        case .futureAnxiety: return "eye.fill"
        }
    }

    var color: Color {
        switch self {
        case .climate:       return Color(red: 1.0,  green: 0.45, blue: 0.2)
        case .poverty:       return Color(red: 0.9,  green: 0.7,  blue: 0.1)
        case .inequality:    return Color(red: 0.6,  green: 0.3,  blue: 0.8)
        case .isolation:     return Color(red: 0.95, green: 0.3,  blue: 0.5)
        case .pollution:     return Color(red: 0.1,  green: 0.5,  blue: 0.9)
        case .deforestation: return Color(red: 0.2,  green: 0.7,  blue: 0.3)
        case .futureAnxiety: return Color(red: 0.55, green: 0.82, blue: 0.98)
        }
    }
}

// MARK: - Character

struct Character: Identifiable, Codable {
    let id: UUID
    let name: String
    let age: Int
    let origin: String
    let continent: Continent
    let occupation: String
    let challenge: ChallengeType
    let backstory: String
    let avatarSymbol: String
    let coordinates: WorldCoordinate
    var isUnlocked: Bool

    // UUIDs are fixed so save data survives app restarts
    static let all: [Character] = [
        Character(
            id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
            name: "Amara Diallo",
            age: 28,
            origin: "Senegal",
            continent: .africa,
            occupation: "Solar Engineer",
            challenge: .climate,
            backstory: "Amara grew up without reliable electricity. Now she builds solar microgrids for villages across West Africa, racing against the expanding Sahara.",
            avatarSymbol: "sun.max.fill",
            coordinates: WorldCoordinate(lat: 14.7, lon: -17.4),
            isUnlocked: true
        ),
        Character(
            id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            name: "Mei Lin",
            age: 19,
            origin: "China",
            continent: .asia,
            occupation: "Student & Activist",
            challenge: .pollution,
            backstory: "Mei watched her coastal hometown slowly disappear beneath rising tides. She now maps ocean microplastics with her university research team.",
            avatarSymbol: "drop.fill",
            coordinates: WorldCoordinate(lat: 31.2, lon: 121.5),
            isUnlocked: true
        ),
        Character(
            id: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
            name: "Carlos Vega",
            age: 45,
            origin: "Peru",
            continent: .southAmerica,
            occupation: "Indigenous Land Defender",
            challenge: .deforestation,
            backstory: "Carlos's community has protected the same 2,000 hectares of Amazon rainforest for generations. Illegal logging operations are closing in.",
            avatarSymbol: "leaf.fill",
            coordinates: WorldCoordinate(lat: -9.2, lon: -75.0),
            isUnlocked: false
        ),
        Character(
            id: UUID(uuidString: "44444444-4444-4444-4444-444444444444")!,
            name: "Fatima Al-Hassan",
            age: 34,
            origin: "Jordan",
            continent: .asia,
            occupation: "Refugee Camp Teacher",
            challenge: .inequality,
            backstory: "Fatima teaches 60 children in a tent school at a refugee camp on the Syrian border. She believes education is the most powerful form of resistance.",
            avatarSymbol: "book.fill",
            coordinates: WorldCoordinate(lat: 32.0, lon: 36.9),
            isUnlocked: false
        ),
        Character(
            id: UUID(uuidString: "55555555-5555-5555-5555-555555555555")!,
            name: "James Okafor",
            age: 55,
            origin: "Nigeria",
            continent: .africa,
            occupation: "Urban Farmer",
            challenge: .poverty,
            backstory: "James converted abandoned lots in Lagos into food forests feeding 500 families. He's trying to scale this model to 10 more megacities.",
            avatarSymbol: "cloud.rain.fill",
            coordinates: WorldCoordinate(lat: 6.5, lon: 3.4),
            isUnlocked: false
        ),
        Character(
            id: UUID(uuidString: "66666666-6666-6666-6666-666666666666")!,
            name: "Hana Nakamura",
            age: 72,
            origin: "Japan",
            continent: .asia,
            occupation: "Retired Nurse",
            challenge: .isolation,
            backstory: "In a city of 14 million, Hana hasn't spoken to a neighbor in three years. She's building a community center to reconnect her aging neighborhood.",
            avatarSymbol: "heart.fill",
            coordinates: WorldCoordinate(lat: 35.7, lon: 139.7),
            isUnlocked: false
        ),
        Character(
            id: UUID(uuidString: "77777777-7777-7777-7777-777777777777")!,
            name: "Astrid Lindqvist",
            age: 16,
            origin: "Sweden",
            continent: .europe,
            occupation: "Student",
            challenge: .futureAnxiety,
            backstory: "Astrid stopped sleeping well two years ago. She understands tipping points, feedback loops, and what 2°C actually means. She loves the Baltic Sea. She is watching it change. She has not stopped going to school. She has not stopped hoping. She doesn't know why.",
            avatarSymbol: "eye.fill",
            coordinates: WorldCoordinate(lat: 55.6, lon: 13.0),
            isUnlocked: false
        )
    ]
}

struct WorldCoordinate: Codable {
    let lat: Double
    let lon: Double
}

enum Continent: String, CaseIterable, Codable {
    case africa = "Africa"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case southAmerica = "South America"
    case oceania = "Oceania"
}

// MARK: - The Baby
// Presence in the room. No data. No model. No code.
// She doesn't need a struct. She's already in the building.

// MARK: - Story Chapter

struct Chapter: Identifiable, Codable {
    let id: UUID
    let characterId: UUID
    let title: String
    let scenes: [StoryScene]
    var isCompleted: Bool = false
    var score: Int = 0
}

struct StoryScene: Identifiable, Codable {
    let id: UUID
    let narrative: String
    let choices: [Choice]
    var selectedChoiceId: UUID?
}

struct Choice: Identifiable, Codable {
    let id: UUID
    let text: String
    let outcome: String
    let impactScore: Int
    let nextSceneId: UUID?
    let globalImpact: GlobalImpact
}

struct GlobalImpact: Codable {
    let co2Reduced: Double
    let livesTouched: Int
    let forestSaved: Double
    let description: String
}

// MARK: - Global State

struct WorldData: Codable {
    var globalTemperatureOffset: Double = 1.2
    var oceanPlasticTons: Double = 170_000_000
    var deforestedHectares: Double = 420_000_000
    var peopleInPoverty: Double = 700_000_000
    var refugeesDisplaced: Double = 108_000_000
    var lonelyElderlyPercent: Double = 40.0

    var totalImpactScore: Int = 0
    var storiesCompleted: Int = 0
}
