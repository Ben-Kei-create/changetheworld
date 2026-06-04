import SwiftUI

@main
struct TERRAApp: App {
    @StateObject private var gameState = GameState()
    @State private var splashDone    = false
    @State private var onboardingDone = UserDefaults.standard.bool(forKey: "terra_onboarding_done")
    @State private var originAsked    = UserDefaults.standard.bool(forKey: "terra_origin_asked")

    var body: some Scene {
        WindowGroup {
            ZStack {
                if !splashDone {
                    SplashView(isFinished: $splashDone)
                        .transition(.opacity)
                } else if !onboardingDone {
                    OnboardingView(isComplete: $onboardingDone)
                        .environmentObject(gameState)
                        .transition(.opacity)
                } else if !originAsked {
                    // 「君たちは、いったいどこからきた。」
                    OriginQuestionView(isComplete: $originAsked)
                        .transition(.opacity)
                } else {
                    ContentView()
                        .environmentObject(gameState)
                        .transition(.opacity)
                        .onAppear {
                            SoundManager.shared.play(.mainMenu)
                        }
                }
            }
            .animation(TerraAnimation.slow, value: splashDone)
            .animation(TerraAnimation.slow, value: onboardingDone)
            .animation(TerraAnimation.slow, value: originAsked)
            .frame(minWidth: 1200, minHeight: 800)
            .background(TerraColor.spaceDeep)
        }
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(replacing: .newItem) {}
            CommandGroup(after: .help) {
                Button("About TERRA") {
                    gameState.showAbout = true
                }
            }
        }
    }
}
