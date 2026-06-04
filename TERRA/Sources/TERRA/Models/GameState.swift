import Foundation
import SwiftUI

enum AppScreen: Equatable {
    case mainMenu
    case worldMap
    case characterSelect
    case storyChapter(Character)
    case impactReport
    case settings
    case reflection
    case credits

    static func == (lhs: AppScreen, rhs: AppScreen) -> Bool {
        switch (lhs, rhs) {
        case (.mainMenu, .mainMenu),
             (.worldMap, .worldMap),
             (.characterSelect, .characterSelect),
             (.impactReport, .impactReport),
             (.settings, .settings),
             (.reflection, .reflection),
             (.credits, .credits):
            return true
        case (.storyChapter(let a), .storyChapter(let b)):
            return a.id == b.id
        default:
            return false
        }
    }
}

@MainActor
final class GameState: ObservableObject {
    @Published var currentScreen: AppScreen = .mainMenu
    @Published var worldData = WorldData()
    @Published var characters: [Character] = Character.all
    @Published var selectedCharacter: Character?
    @Published var showAbout = false
    @Published var soundEnabled = true {
        didSet { SoundManager.shared.sfxEnabled = soundEnabled }
    }
    @Published var musicEnabled = true {
        didSet { SoundManager.shared.musicEnabled = musicEnabled }
    }

    // Story progress
    @Published var completedChapterIds: Set<UUID> = []
    @Published var totalImpactScore: Int = 0

    // Player's own voice — Sprint 6
    @Published var playerReflectionStance: ReflectionStance?
    @Published var playerReflectionThought: String = ""
    @Published var hasCompletedReflection = false

    var allStoriesComplete: Bool {
        completedChapterIds.count >= characters.count
    }

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

        unlockNextCharacter()

        // After all stories: show reflection screen
        if allStoriesComplete && !hasCompletedReflection {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.currentScreen = .reflection
            }
        }

        save()
    }

    func saveReflection(stance: ReflectionStance?, thought: String) {
        playerReflectionStance = stance
        playerReflectionThought = thought
        hasCompletedReflection = true
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
        UserDefaults.standard.set(hasCompletedReflection, forKey: "\(saveKey)_reflected")
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
        hasCompletedReflection = UserDefaults.standard.bool(forKey: "\(saveKey)_reflected")

        // Restore character unlock state: unlock one character per completed story
        // (Character.all starts with Amara + Mei Lin unlocked; each completion unlocks the next)
        let unlockCount = completedChapterIds.count
        for _ in 0..<unlockCount {
            unlockNextCharacter()
        }
    }

    func resetGame() {
        worldData = WorldData()
        completedChapterIds = []
        totalImpactScore = 0
        hasCompletedReflection = false
        playerReflectionStance = nil
        playerReflectionThought = ""
        characters = Character.all
        UserDefaults.standard.removeObject(forKey: saveKey)
        UserDefaults.standard.removeObject(forKey: "\(saveKey)_chapters")
        UserDefaults.standard.removeObject(forKey: "\(saveKey)_reflected")
        currentScreen = .mainMenu
    }
}
