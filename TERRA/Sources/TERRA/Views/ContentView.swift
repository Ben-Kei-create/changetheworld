import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameState: GameState

    var body: some View {
        ZStack {
            TerraColor.spaceDeep.ignoresSafeArea()

            switch gameState.currentScreen {
            case .mainMenu:
                MainMenuView()
                    .transition(.opacity)
            case .worldMap:
                WorldMapView()
                    .transition(.opacity)
            case .characterSelect:
                CharacterSelectView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            case .storyChapter(let character):
                StoryView(character: character)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            case .impactReport:
                ImpactReportView()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            case .settings:
                SettingsView()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            case .reflection:
                PlayerReflectionView()
                    .transition(.opacity)
            }
        }
        .animation(TerraAnimation.standard, value: gameState.currentScreen)
        .onChange(of: gameState.currentScreen) { _, newScreen in
            handleBGMTransition(for: newScreen)
        }
        .sheet(isPresented: $gameState.showAbout) {
            AboutView()
        }
    }

    private func handleBGMTransition(for screen: AppScreen) {
        switch screen {
        case .mainMenu:
            SoundManager.shared.play(.mainMenu)
        case .worldMap, .characterSelect:
            SoundManager.shared.play(.worldMap)
        case .storyChapter(let character):
            SoundManager.shared.play(SoundManager.track(for: character))
        case .impactReport, .settings:
            break
        }
    }
}
