import Foundation
import SwiftUI

enum AppScreen {
    case mainMenu
    case worldMap
    case characterSelect
    case storyChapter(Character)
    case impactReport
    case settings
}

final class GameState: ObservableObject {
    @Published var currentScreen: AppScreen = .mainMenu
    @Published var worldData = WorldData()
    @Published var characters: [Character] = Character.all
    @Published var selectedCharacter: Character?
    @Published var showAbout = false
    @Published var soundEnabled = true
    @Published var musicEnabled = true

    // Story progress
    @Published var completedChapterIds: Set<UUID> = []
    @Published var totalImpactScore: Int = 0

    private let saveKey = "terra_save_v1"

    init() {
        load()
    }

    var unlockedCharacters: [Character] {
        characters.filter { $0.isUnlocked }
    }

    var progressPercent: Double {
        let total = Double(characters.count)
        let done = Double(completedChapterIds.count)
        return done / total
    }

    func selectCharacter(_ character: Character) {
        selectedCharacter = character
        currentScreen = .storyChapter(character)
    }

    func completeChapter(characterId: UUID, score: Int) {
        completedChapterIds.insert(characterId)
        totalImpactScore += score
        worldData.totalImpactScore += score
        worldData.storiesCompleted += 1

        // Unlock next character if available
        unlockNextCharacter()
        save()
    }

    private func unlockNextCharacter() {
        for i in characters.indices {
            if !characters[i].isUnlocked {
                characters[i].isUnlocked = true
                break
            }
        }
    }

    func save() {
        guard let data = try? JSONEncoder().encode(worldData) else { return }
        UserDefaults.standard.set(data, forKey: saveKey)
        UserDefaults.standard.set(Array(completedChapterIds.map { $0.uuidString }), forKey: "\(saveKey)_chapters")
    }

    func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode(WorldData.self, from: data) {
            worldData = decoded
            totalImpactScore = decoded.totalImpactScore
        }
        if let chapterStrings = UserDefaults.standard.array(forKey: "\(saveKey)_chapters") as? [String] {
            completedChapterIds = Set(chapterStrings.compactMap { UUID(uuidString: $0) })
        }
    }

    func resetGame() {
        worldData = WorldData()
        completedChapterIds = []
        totalImpactScore = 0
        characters = Character.all
        UserDefaults.standard.removeObject(forKey: saveKey)
        UserDefaults.standard.removeObject(forKey: "\(saveKey)_chapters")
        currentScreen = .mainMenu
    }
}
