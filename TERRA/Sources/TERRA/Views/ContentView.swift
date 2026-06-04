import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameState: GameState

    var body: some View {
        ZStack {
            switch gameState.currentScreen {
            case .mainMenu:
                MainMenuView()
                    .transition(.opacity)
            case .worldMap:
                WorldMapView()
                    .transition(.opacity)
            case .characterSelect:
                CharacterSelectView()
                    .transition(.move(edge: .trailing))
            case .storyChapter(let character):
                StoryView(character: character)
                    .transition(.move(edge: .trailing))
            case .impactReport:
                ImpactReportView()
                    .transition(.move(edge: .bottom))
            case .settings:
                SettingsView()
                    .transition(.move(edge: .bottom))
            }
        }
        .animation(.easeInOut(duration: 0.5), value: "\(gameState.currentScreen)")
        .sheet(isPresented: $gameState.showAbout) {
            AboutView()
        }
    }
}
