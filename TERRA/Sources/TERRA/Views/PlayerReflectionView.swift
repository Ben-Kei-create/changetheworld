import SwiftUI

// "意見を持つ画面"
// Triggered after all 7 stories are completed.
// The player stops being a witness and becomes a voice.
// — Alex Chen's insight, Sprint 6

struct PlayerReflectionView: View {
    @EnvironmentObject var gameState: GameState
    @State private var selectedStance: ReflectionStance?
    @State private var writtenThought: String = ""
    @State private var phase: ReflectionPhase = .intro
    @State private var opacity = 0.0
    @FocusState private var isWriting: Bool

    enum ReflectionPhase {
        case intro, question, written, closing
    }

    var body: some View {
        ZStack {
            // Pure white space — Yuna's direction: "one question, nothing else"
            Color(red: 0.97, green: 0.97, blue: 0.98)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                switch phase {
                case .intro:
                    introPhase
                case .question:
                    questionPhase
                case .written:
                    writtenPhase
                case .closing:
                    closingPhase
                }
            }
            .opacity(opacity)
        }
        .onAppear {
            withAnimation(.easeIn(duration: 1.2)) { opacity = 1.0 }
        }
    }

    // MARK: - Intro

    private var introPhase: some View {
        VStack(spacing: 40) {
            Spacer()

            VStack(spacing: 20) {
                Text("You have heard seven stories.")
                    .font(.system(size: 32, weight: .light, design: .serif))
                    .foregroundColor(Color(white: 0.1))
                    .multilineTextAlignment(.center)

                Text("From Senegal to Sweden.\nFrom 16 to 72.\nFrom a tent to a tokyo storage room.")
                    .font(.system(size: 17, weight: .light, design: .serif))
                    .foregroundColor(Color(white: 0.4))
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
            }

            Rectangle()
                .fill(Color(white: 0.8))
                .frame(width: 1, height: 60)

            Text("Now it is your turn.")
                .font(.system(size: 20, weight: .light, design: .serif))
                .foregroundColor(Color(white: 0.25))
                .italic()

            Spacer()

            Button(action: {
                withAnimation(.easeInOut(duration: 0.6)) { opacity = 0 }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    phase = .question
                    withAnimation(.easeIn(duration: 0.8)) { opacity = 1.0 }
                }
            }) {
                Text("I'm ready")
                    .font(.system(size: 14, weight: .medium))
                    .tracking(3)
                    .foregroundColor(Color(white: 0.3))
                    .frame(width: 160, height: 44)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color(white: 0.7), lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
            .padding(.bottom, 60)
        }
    }

    // MARK: - Question

    private var questionPhase: some View {
        VStack(spacing: 48) {
            Spacer()

            VStack(spacing: 32) {
                Text("After all of this —")
                    .font(.system(size: 18, weight: .light, design: .serif))
                    .foregroundColor(Color(white: 0.5))

                Text("What do\nyou think?")
                    .font(.system(size: 52, weight: .light, design: .serif))
                    .foregroundColor(Color(white: 0.1))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }

            // Stance options
            VStack(spacing: 12) {
                ForEach(ReflectionStance.allCases, id: \.self) { stance in
                    StanceButton(stance: stance, isSelected: selectedStance == stance) {
                        withAnimation(.spring(duration: 0.3)) {
                            selectedStance = stance
                        }
                        SoundManager.shared.playSFX(.choiceSelect)
                    }
                }
            }
            .padding(.horizontal, 120)

            if selectedStance != nil {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) { opacity = 0 }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        phase = .written
                        withAnimation(.easeIn(duration: 0.8)) { opacity = 1.0 }
                    }
                }) {
                    Text("Continue")
                        .font(.system(size: 14, weight: .medium))
                        .tracking(2)
                        .foregroundColor(.white)
                        .frame(width: 180, height: 48)
                        .background(Color(white: 0.15))
                        .cornerRadius(3)
                }
                .buttonStyle(.plain)
                .transition(.opacity)
            }

            Spacer()
        }
    }

    // MARK: - Written thought

    private var writtenPhase: some View {
        VStack(spacing: 40) {
            Spacer()

            VStack(spacing: 16) {
                Text("Is there something you want to remember?")
                    .font(.system(size: 22, weight: .light, design: .serif))
                    .foregroundColor(Color(white: 0.2))

                Text("Write it here. It stays only on your device.")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(Color(white: 0.5))
            }

            // Text area
            ZStack(alignment: .topLeading) {
                if writtenThought.isEmpty {
                    Text("A thought. A name. A question you're still holding.")
                        .font(.system(size: 15, weight: .light, design: .serif))
                        .foregroundColor(Color(white: 0.65))
                        .padding(.top, 12)
                        .padding(.leading, 4)
                        .allowsHitTesting(false)
                }

                TextEditor(text: $writtenThought)
                    .font(.system(size: 15, weight: .light, design: .serif))
                    .foregroundColor(Color(white: 0.15))
                    .frame(height: 120)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .focused($isWriting)
            }
            .padding(20)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(white: isWriting ? 0.5 : 0.82), lineWidth: 1)
            )
            .frame(maxWidth: 560)

            HStack(spacing: 20) {
                Button("Skip") {
                    advance()
                }
                .buttonStyle(.plain)
                .font(.system(size: 13, weight: .light))
                .foregroundColor(Color(white: 0.5))

                Button(action: advance) {
                    Text("Save & Continue")
                        .font(.system(size: 14, weight: .medium))
                        .tracking(1)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 46)
                        .background(Color(white: 0.15))
                        .cornerRadius(3)
                }
                .buttonStyle(.plain)
            }

            Spacer()
        }
        .padding(.horizontal, 120)
        .onAppear { isWriting = true }
    }

    // MARK: - Closing

    private var closingPhase: some View {
        let playerOrigin = UserDefaults.standard.string(forKey: "terra_player_origin")

        return VStack(spacing: 40) {
            Spacer()

            VStack(spacing: 32) {
                // Mirror: show player's opening answer
                if let origin = playerOrigin, !origin.isEmpty {
                    VStack(spacing: 12) {
                        Text("At the beginning, you wrote:")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(Color(white: 0.5))
                            .tracking(1)

                        Text(""\(origin)"")
                            .font(.system(size: 20, weight: .light, design: .serif))
                            .foregroundColor(Color(white: 0.25))
                            .italic()
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 500)
                    }
                    .padding(24)
                    .background(Color(white: 0.96))
                    .cornerRadius(6)

                    Text("↓")
                        .font(.system(size: 18))
                        .foregroundColor(Color(white: 0.7))
                }

                if let stance = selectedStance {
                    Text(stance.closingMessage)
                        .font(.system(size: 26, weight: .light, design: .serif))
                        .foregroundColor(Color(white: 0.12))
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .frame(maxWidth: 560)
                }

                if !writtenThought.isEmpty {
                    VStack(spacing: 8) {
                        Rectangle()
                            .fill(Color(white: 0.85))
                            .frame(width: 1, height: 28)

                        Text(writtenThought)
                            .font(.system(size: 15, weight: .light, design: .serif))
                            .foregroundColor(Color(white: 0.4))
                            .italic()
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 480)
                    }
                }
            }

            Rectangle()
                .fill(Color(white: 0.85))
                .frame(width: 40, height: 1)

            Text("Thank you for being here.")
                .font(.system(size: 16, weight: .light, design: .serif))
                .foregroundColor(Color(white: 0.4))

            Button(action: {
                gameState.saveReflection(stance: selectedStance, thought: writtenThought)
                SoundManager.shared.play(.mainMenu)
                withAnimation(TerraAnimation.slow) {
                    gameState.currentScreen = .mainMenu
                }
            }) {
                Text("Return")
                    .font(.system(size: 14, weight: .light))
                    .tracking(3)
                    .foregroundColor(Color(white: 0.4))
                    .frame(width: 140, height: 44)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color(white: 0.75), lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)

            Spacer()
        }
    }

    private func advance() {
        withAnimation(.easeInOut(duration: 0.5)) { opacity = 0 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            phase = .closing
            withAnimation(.easeIn(duration: 0.8)) { opacity = 1.0 }
        }
    }
}

// MARK: - Reflection Stance

enum ReflectionStance: String, CaseIterable, Codable {
    case hopeful       = "I feel more hopeful than before."
    case determined    = "I feel like I need to do something."
    case overwhelmed   = "I feel overwhelmed by the scale of it."
    case connected     = "I feel less alone in the world."
    case changed       = "Something in how I see things has shifted."
    case stillThinking = "I'm still thinking. I don't have words yet."

    var closingMessage: String {
        switch self {
        case .hopeful:
            return "Hope is not naivety.\nIt is the decision to keep going\ndespite knowing what you know."
        case .determined:
            return "The feeling that something must be done\nis the beginning of the something."
        case .overwhelmed:
            return "That is the right response.\nStay with it a little longer.\nThen do the next thing."
        case .connected:
            return "That connection is real.\nAmara, Mei, Carlos, Fatima,\nJames, Hana, Astrid —\nthey exist because you don't."
        case .changed:
            return "That is what stories are for.\nNot to inform.\nBut to shift the angle\nfrom which you see."
        case .stillThinking:
            return "Good.\nThe questions worth keeping\ndon't resolve quickly.\nKeep this one."
        }
    }
}

// MARK: - Stance Button

struct StanceButton: View {
    let stance: ReflectionStance
    let isSelected: Bool
    let action: () -> Void

    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Circle()
                    .fill(isSelected ? Color(white: 0.15) : Color.clear)
                    .frame(width: 8, height: 8)
                    .overlay(
                        Circle()
                            .stroke(Color(white: isSelected ? 0.15 : 0.65), lineWidth: 1)
                    )

                Text(stance.rawValue)
                    .font(.system(size: 14, weight: isSelected ? .medium : .light, design: .serif))
                    .foregroundColor(Color(white: isSelected ? 0.1 : 0.45))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(isSelected ? Color(white: 0.95) : (isHovered ? Color(white: 0.96) : Color.clear))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(white: isSelected ? 0.7 : (isHovered ? 0.82 : 0.9)), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .onHover { isHovered = $0 }
        .animation(.easeInOut(duration: 0.15), value: isSelected)
        .animation(.easeInOut(duration: 0.15), value: isHovered)
    }
}
