import XCTest
@testable import TERRA

final class TERRATests: XCTestCase {

    func testCharacterDataIntegrity() {
        let characters = Character.all
        XCTAssertEqual(characters.count, 6, "Should have 6 playable characters")

        // Each character should have a unique id
        let ids = Set(characters.map { $0.id })
        XCTAssertEqual(ids.count, characters.count, "All character IDs should be unique")

        // First two should be unlocked by default
        let unlocked = characters.filter { $0.isUnlocked }
        XCTAssertEqual(unlocked.count, 2, "Two characters should be unlocked at start")
    }

    func testAllChallengeTypesRepresented() {
        let characters = Character.all
        let challenges = Set(characters.map { $0.challenge })
        XCTAssertEqual(challenges.count, 6, "Each of the 6 challenge types should be represented")
    }

    func testStoryContentForAllCharacters() {
        for character in Character.all {
            let story = StoryContent.story(for: character)
            XCTAssertFalse(story.title.isEmpty, "Story for \(character.name) should have a title")
            XCTAssertFalse(story.scenes.isEmpty, "Story for \(character.name) should have at least one scene")

            for scene in story.scenes {
                XCTAssertFalse(scene.narrative.isEmpty, "Scene narrative should not be empty")
                XCTAssertGreaterThanOrEqual(scene.choices.count, 2, "Each scene should have at least 2 choices")

                for choice in scene.choices {
                    XCTAssertFalse(choice.text.isEmpty, "Choice text should not be empty")
                    XCTAssertFalse(choice.outcome.isEmpty, "Choice outcome should not be empty")
                    XCTAssertGreaterThan(choice.impactScore, 0, "Impact score should be positive")
                    XCTAssertLesssThanOrEqual(choice.impactScore, 10, "Impact score max is 10")
                }
            }
        }
    }

    func testWorldDataDefaultValues() {
        let data = WorldData()
        XCTAssertEqual(data.storiesCompleted, 0)
        XCTAssertEqual(data.totalImpactScore, 0)
        XCTAssertGreaterThan(data.globalTemperatureOffset, 0)
    }

    func testGameStateUnlockProgression() {
        let state = GameState()
        let initialUnlocked = state.unlockedCharacters.count

        // Completing a chapter should unlock the next character
        state.completeChapter(characterId: state.characters[0].id, score: 25)
        XCTAssertGreaterThan(state.unlockedCharacters.count, initialUnlocked)
        XCTAssertEqual(state.totalImpactScore, 25)
    }

    func testGameStateReset() {
        let state = GameState()
        state.completeChapter(characterId: state.characters[0].id, score: 30)
        XCTAssertEqual(state.totalImpactScore, 30)

        state.resetGame()
        XCTAssertEqual(state.totalImpactScore, 0)
        XCTAssertEqual(state.completedChapterIds.count, 0)
    }
}

// Fix typo for compiler
func XCTAssertLesssThanOrEqual<T: Comparable>(_ a: T, _ b: T, _ msg: String = "") {
    XCTAssertLessThanOrEqual(a, b, msg)
}
