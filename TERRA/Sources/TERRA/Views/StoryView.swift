import SwiftUI

struct StoryView: View {
    @EnvironmentObject var gameState: GameState
    let character: Character

    @State private var currentSceneIndex = 0
    @State private var selectedChoiceId: UUID?
    @State private var showOutcome = false
    @State private var totalScore = 0
    @State private var showCompletionScreen = false
    @State private var narrativeOpacity = 0.0
    @State private var choicesOpacity = 0.0

    private var story: StoryContent { StoryContent.story(for: character) }
    private var currentScene: StoryScene { story.scenes[currentSceneIndex] }

    var body: some View {
        ZStack {
            // Atmospheric background
            LinearGradient(
                colors: [
                    character.challenge.color.opacity(0.15),
                    Color(red: 0.03, green: 0.05, blue: 0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            if showCompletionScreen {
                ChapterCompletionView(
                    character: character,
                    score: totalScore,
                    onContinue: {
                        gameState.completeChapter(characterId: character.id, score: totalScore)
                        gameState.currentScreen = .worldMap
                    }
                )
                .transition(.opacity)
            } else {
                VStack(spacing: 0) {
                    // Top bar
                    StoryNavBar(
                        character: character,
                        sceneIndex: currentSceneIndex,
                        totalScenes: story.scenes.count,
                        onExit: { gameState.currentScreen = .worldMap }
                    )

                    Spacer()

                    // Narrative area
                    VStack(spacing: 40) {
                        // Chapter title (first scene only)
                        if currentSceneIndex == 0 {
                            VStack(spacing: 8) {
                                Text(story.title)
                                    .font(.system(size: 32, weight: .ultraLight, design: .serif))
                                    .foregroundColor(.white)
                                Text(character.origin.uppercased())
                                    .font(.system(size: 12, weight: .light))
                                    .tracking(5)
                                    .foregroundColor(character.challenge.color)
                            }
                        }

                        // Scene illustration placeholder
                        SceneIllustration(
                            character: character,
                            sceneIndex: currentSceneIndex
                        )
                        .frame(height: 160)

                        // Narrative text
                        Text(currentScene.narrative)
                            .font(.system(size: 17, weight: .light, design: .serif))
                            .foregroundColor(.white.opacity(0.9))
                            .lineSpacing(8)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 680)
                            .padding(.horizontal, 40)
                            .opacity(narrativeOpacity)

                        // Outcome (after choice)
                        if showOutcome, let choiceId = selectedChoiceId,
                           let choice = currentScene.choices.first(where: { $0.id == choiceId }) {
                            OutcomeView(choice: choice, challengeColor: character.challenge.color)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }

                    Spacer()

                    // Choices
                    if !showOutcome {
                        VStack(spacing: 12) {
                            Text("What do you do?")
                                .font(.system(size: 12, weight: .light))
                                .tracking(3)
                                .foregroundColor(.white.opacity(0.4))

                            ForEach(currentScene.choices) { choice in
                                ChoiceButton(
                                    choice: choice,
                                    challengeColor: character.challenge.color
                                ) {
                                    makeChoice(choice)
                                }
                            }
                        }
                        .padding(.horizontal, 120)
                        .padding(.bottom, 40)
                        .opacity(choicesOpacity)
                    } else {
                        Button(action: advanceScene) {
                            HStack(spacing: 10) {
                                Text(currentSceneIndex < story.scenes.count - 1 ? "Continue" : "Complete Chapter")
                                Image(systemName: "arrow.right")
                            }
                            .font(.system(size: 15, weight: .medium))
                            .tracking(2)
                            .foregroundColor(.black)
                            .frame(width: 260, height: 50)
                            .background(
                                LinearGradient(
                                    colors: [character.challenge.color, character.challenge.color.opacity(0.8)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(6)
                        }
                        .buttonStyle(.plain)
                        .padding(.bottom, 40)
                        .transition(.opacity)
                    }
                }
            }
        }
        .onAppear { animateIn() }
        .animation(.easeInOut(duration: 0.5), value: showCompletionScreen)
    }

    private func makeChoice(_ choice: StoryChoice) {
        selectedChoiceId = choice.id
        totalScore += choice.impactScore
        withAnimation(.spring(duration: 0.5)) {
            showOutcome = true
            choicesOpacity = 0
        }
    }

    private func advanceScene() {
        if currentSceneIndex < story.scenes.count - 1 {
            withAnimation(.easeOut(duration: 0.3)) {
                narrativeOpacity = 0
                showOutcome = false
                selectedChoiceId = nil
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                currentSceneIndex += 1
                animateIn()
            }
        } else {
            withAnimation { showCompletionScreen = true }
        }
    }

    private func animateIn() {
        narrativeOpacity = 0
        choicesOpacity = 0
        withAnimation(.easeIn(duration: 0.8)) { narrativeOpacity = 1.0 }
        withAnimation(.easeIn(duration: 0.8).delay(0.5)) { choicesOpacity = 1.0 }
    }
}

// MARK: - Story Nav Bar

struct StoryNavBar: View {
    let character: Character
    let sceneIndex: Int
    let totalScenes: Int
    let onExit: () -> Void

    var body: some View {
        HStack {
            Button(action: onExit) {
                HStack(spacing: 8) {
                    Image(systemName: "xmark")
                        .font(.system(size: 13, weight: .medium))
                    Text("Exit Story")
                        .font(.system(size: 13, weight: .light))
                }
                .foregroundColor(.white.opacity(0.5))
            }
            .buttonStyle(.plain)

            Spacer()

            // Character indicator
            HStack(spacing: 10) {
                Image(systemName: character.avatarSymbol)
                    .font(.system(size: 14))
                    .foregroundColor(character.challenge.color)
                Text(character.name)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
            }

            Spacer()

            // Progress
            HStack(spacing: 6) {
                ForEach(0..<totalScenes, id: \.self) { i in
                    Capsule()
                        .fill(i <= sceneIndex ? character.challenge.color : Color.white.opacity(0.15))
                        .frame(width: i == sceneIndex ? 24 : 8, height: 4)
                        .animation(.spring(duration: 0.3), value: sceneIndex)
                }
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 16)
        .background(Color.black.opacity(0.3))
    }
}

// MARK: - Scene Illustration

struct SceneIllustration: View {
    let character: Character
    let sceneIndex: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        colors: [
                            character.challenge.color.opacity(0.25),
                            character.challenge.color.opacity(0.05)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            // Symbolic visual based on challenge type
            HStack(spacing: 30) {
                ForEach(0..<3, id: \.self) { i in
                    Image(systemName: sceneSymbols[min(sceneIndex, sceneSymbols.count - 1)][i % sceneSymbols[0].count])
                        .font(.system(size: CGFloat(28 - i * 4)))
                        .foregroundColor(character.challenge.color.opacity(1.0 - Double(i) * 0.25))
                }
            }
        }
        .frame(maxWidth: 500)
        .padding(.horizontal, 120)
    }

    private var sceneSymbols: [[String]] {
        switch character.challenge {
        case .climate:
            return [
                ["sun.haze.fill", "thermometer.high", "wind"],
                ["bolt.fill", "waveform.path.ecg", "cloud.sun.fill"],
                ["checkmark.seal.fill", "sun.max.fill", "leaf.fill"]
            ]
        case .pollution:
            return [
                ["water.waves", "drop.fill", "exclamationmark.triangle.fill"],
                ["magnifyingglass", "testtube.2", "doc.text.fill"],
                ["arrow.up.circle.fill", "heart.fill", "globe"]
            ]
        case .deforestation:
            return [
                ["tree.fill", "exclamationmark.circle.fill", "person.fill"],
                ["map.fill", "shield.fill", "megaphone.fill"],
                ["leaf.fill", "sun.and.horizon.fill", "hands.and.sparkles.fill"]
            ]
        case .inequality:
            return [
                ["book.closed.fill", "figure.stand", "pencil"],
                ["building.columns.fill", "network", "person.3.fill"],
                ["star.fill", "heart.fill", "globe.europe.africa.fill"]
            ]
        case .poverty:
            return [
                ["house.fill", "cloud.rain.fill", "bag.fill"],
                ["shovel.fill", "leaf.fill", "person.3.sequence.fill"],
                ["chart.bar.fill", "arrow.up.circle.fill", "globe"]
            ]
        case .isolation:
            return [
                ["figure.stand", "building.2.fill", "ellipsis.bubble.fill"],
                ["hammer.fill", "paintbrush.fill", "person.3.fill"],
                ["heart.fill", "music.note", "sun.max.fill"]
            ]
        case .futureAnxiety:
            return [
                ["moon.fill", "laptopcomputer", "water.waves"],
                ["person.3.fill", "book.fill", "magnifyingglass"],
                ["mic.fill", "globe.europe.africa.fill", "star.fill"]
            ]
        }
    }
}

// MARK: - Choice Button

struct ChoiceButton: View {
    let choice: StoryChoice
    let challengeColor: Color
    let action: () -> Void

    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Circle()
                    .fill(challengeColor.opacity(0.2))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: choice.icon)
                            .font(.system(size: 13))
                            .foregroundColor(challengeColor)
                    )

                Text(choice.text)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.3))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isHovered
                        ? challengeColor.opacity(0.15)
                        : Color.white.opacity(0.04))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isHovered ? challengeColor.opacity(0.4) : Color.white.opacity(0.08), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
        .scaleEffect(isHovered ? 1.01 : 1.0)
        .animation(.spring(duration: 0.2), value: isHovered)
        .onHover { isHovered = $0 }
    }
}

// MARK: - Outcome View

struct OutcomeView: View {
    let choice: StoryChoice
    let challengeColor: Color

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: choice.impactScore > 5 ? "star.fill" : "circle.fill")
                    .foregroundColor(choice.impactScore > 5 ? .yellow : challengeColor)
                Text("Outcome")
                    .font(.system(size: 13, weight: .semibold))
                    .tracking(2)
                    .foregroundColor(.white.opacity(0.6))
            }

            Text(choice.outcome)
                .font(.system(size: 15, weight: .light, design: .serif))
                .foregroundColor(.white.opacity(0.85))
                .lineSpacing(6)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 600)

            // Impact score
            HStack(spacing: 8) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(challengeColor)
                Text("+\(choice.impactScore) Impact Points")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(challengeColor)
            }
        }
        .padding(.horizontal, 120)
    }
}

// MARK: - Chapter Completion View

struct ChapterCompletionView: View {
    let character: Character
    let score: Int
    let onContinue: () -> Void

    @State private var appeared = false

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            // Trophy
            ZStack {
                Circle()
                    .fill(character.challenge.color.opacity(0.2))
                    .frame(width: 120, height: 120)
                Image(systemName: "medal.fill")
                    .font(.system(size: 56))
                    .foregroundColor(character.challenge.color)
            }
            .scaleEffect(appeared ? 1.0 : 0.5)
            .opacity(appeared ? 1.0 : 0)

            VStack(spacing: 12) {
                Text("Story Complete")
                    .font(.system(size: 36, weight: .ultraLight, design: .serif))
                    .foregroundColor(.white)

                Text("\(character.name)'s story has been heard.")
                    .font(.system(size: 17, weight: .light))
                    .foregroundColor(.white.opacity(0.7))
            }
            .opacity(appeared ? 1.0 : 0)
            .offset(y: appeared ? 0 : 20)

            // Score card
            VStack(spacing: 8) {
                Text("YOUR IMPACT")
                    .font(.system(size: 11, weight: .semibold))
                    .tracking(4)
                    .foregroundColor(.white.opacity(0.4))

                Text("\(score)")
                    .font(.system(size: 64, weight: .ultraLight))
                    .foregroundColor(character.challenge.color)

                Text("points earned")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(32)
            .background(Color.white.opacity(0.04))
            .cornerRadius(12)
            .opacity(appeared ? 1.0 : 0)

            // Real world data
            RealWorldDataCard(challenge: character.challenge)
                .opacity(appeared ? 1.0 : 0)

            Button(action: onContinue) {
                Text("Return to World Map")
                    .font(.system(size: 15, weight: .medium))
                    .tracking(2)
                    .foregroundColor(.black)
                    .frame(width: 260, height: 50)
                    .background(character.challenge.color)
                    .cornerRadius(6)
            }
            .buttonStyle(.plain)
            .opacity(appeared ? 1.0 : 0)

            Spacer()
        }
        .onAppear {
            withAnimation(.spring(duration: 0.8).delay(0.2)) {
                appeared = true
            }
        }
    }
}

struct RealWorldDataCard: View {
    let challenge: ChallengeType

    var body: some View {
        VStack(spacing: 8) {
            Text("REAL WORLD CONTEXT")
                .font(.system(size: 10, weight: .semibold))
                .tracking(3)
                .foregroundColor(.white.opacity(0.3))

            Text(realWorldFact)
                .font(.system(size: 13, weight: .light))
                .foregroundColor(.white.opacity(0.65))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .frame(maxWidth: 480)
        }
        .padding(20)
        .background(challenge.color.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(challenge.color.opacity(0.2), lineWidth: 1)
        )
        .cornerRadius(8)

    }

    private var realWorldFact: String {
        switch challenge {
        case .climate:
            return "Africa contributes less than 4% of global CO₂ emissions, yet bears the greatest climate burden. Solar microgrids now power over 420 million people in sub-Saharan Africa."
        case .pollution:
            return "Over 170 million metric tons of plastic are in our oceans. Scientists estimate that by 2050, there could be more plastic than fish by weight. Youth researchers are leading the change."
        case .deforestation:
            return "Indigenous peoples protect 80% of the world's remaining biodiversity while managing only 22% of the land. Their knowledge is irreplaceable."
        case .inequality:
            return "Over 250 million school-age children are not in school globally, with the highest concentration in conflict zones. A single teacher can change the trajectory of 1,000 lives."
        case .poverty:
            return "Urban food forests can produce up to 6x more food per square meter than industrial agriculture, while rebuilding community bonds and local ecosystems."
        case .isolation:
            return "Chronic loneliness is now as dangerous to health as smoking 15 cigarettes a day. Japan became the first country to appoint a Minister of Loneliness in 2021."
        case .futureAnxiety:
            return "A 2021 global survey of 10,000 young people found 59% were very or extremely worried about climate change. 45% said their feelings about it affected their daily life. The term 'eco-anxiety' was formally recognized by the American Psychological Association in 2017. The Baltic Sea has warmed faster than almost any other body of water on Earth."
        }
    }
}
