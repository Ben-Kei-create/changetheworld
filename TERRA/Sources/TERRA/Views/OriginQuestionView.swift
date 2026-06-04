import SwiftUI

// 「君たちは、いったいどこからきた。」
//
// ゲームが始まる前に、一度だけプレイヤーに問う。
// 誰も見ない。送信されない。サーバーに届かない。
// ただ、自分自身のために書く。
//
// そして全ての物語が終わった後——その言葉が戻ってくる。
// — ???のアイデア、スプリント7

struct OriginQuestionView: View {
    @Binding var isComplete: Bool
    @State private var answer: String = ""
    @State private var phase: Phase = .arrival
    @State private var opacity = 0.0
    @State private var cursorVisible = true
    @FocusState private var focused: Bool

    enum Phase { case arrival, question, waiting, ready }

    private let cursorTimer = Timer.publish(every: 0.6, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                Spacer()

                switch phase {
                case .arrival:
                    arrivalText
                case .question:
                    questionText
                case .waiting:
                    inputArea
                case .ready:
                    readyState
                }

                Spacer()
            }
            .opacity(opacity)
        }
        .onAppear {
            runSequence()
        }
        .onReceive(cursorTimer) { _ in
            if phase == .waiting { cursorVisible.toggle() }
        }
    }

    // MARK: - Phases

    private var arrivalText: some View {
        Text("Before you enter.")
            .font(.system(size: 28, weight: .ultraLight, design: .serif))
            .foregroundColor(.white.opacity(0.6))
            .tracking(2)
    }

    private var questionText: some View {
        VStack(spacing: 0) {
            Text("Where did you come from?")
                .font(.system(size: 42, weight: .ultraLight, design: .serif))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
    }

    private var inputArea: some View {
        VStack(spacing: 48) {
            Text("Where did you come from?")
                .font(.system(size: 32, weight: .ultraLight, design: .serif))
                .foregroundColor(.white.opacity(0.7))

            // Input line
            VStack(spacing: 0) {
                ZStack(alignment: .leading) {
                    if answer.isEmpty {
                        HStack(spacing: 0) {
                            Text("A place. A person. A moment.")
                                .font(.system(size: 18, weight: .ultraLight, design: .serif))
                                .foregroundColor(.white.opacity(0.2))
                                .italic()
                            Spacer()
                        }
                    }

                    HStack(spacing: 0) {
                        TextField("", text: $answer)
                            .font(.system(size: 18, weight: .ultraLight, design: .serif))
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .focused($focused)
                            .onSubmit { if !answer.isEmpty { advance() } }
                            .frame(maxWidth: .infinity)

                        // cursor
                        if answer.isEmpty {
                            Rectangle()
                                .fill(Color.white.opacity(cursorVisible ? 0.7 : 0))
                                .frame(width: 1, height: 22)
                        }
                    }
                }

                Rectangle()
                    .fill(Color.white.opacity(0.2))
                    .frame(height: 1)
                    .padding(.top, 12)
            }
            .frame(maxWidth: 480)

            // Actions
            HStack(spacing: 24) {
                Button("Skip — I'd rather not say") {
                    saveAndComplete(answer: nil)
                }
                .buttonStyle(.plain)
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.white.opacity(0.2))

                if !answer.isEmpty {
                    Button(action: advance) {
                        Text("Enter the world  →")
                            .font(.system(size: 14, weight: .light))
                            .tracking(2)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .buttonStyle(.plain)
                    .transition(.opacity)
                    .animation(TerraAnimation.standard, value: answer.isEmpty)
                }
            }

            Text("No one else will see this.")
                .font(.system(size: 11, weight: .ultraLight))
                .foregroundColor(.white.opacity(0.15))
                .tracking(1)
        }
        .padding(.horizontal, 80)
        .onAppear { focused = true }
    }

    private var readyState: some View {
        VStack(spacing: 20) {
            if !answer.isEmpty {
                Text("\u{201C}\(answer)\u{201D}")
                    .font(.system(size: 22, weight: .ultraLight, design: .serif))
                    .foregroundColor(.white.opacity(0.6))
                    .italic()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 500)
            }

            Text("You'll see this again, at the end.")
                .font(.system(size: 13, weight: .ultraLight))
                .foregroundColor(.white.opacity(0.3))
                .tracking(1)
        }
    }

    // MARK: - Flow

    private func runSequence() {
        withAnimation(.easeIn(duration: 1.0)) { opacity = 1.0 }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            transition(to: .question)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            transition(to: .waiting)
        }
    }

    private func advance() {
        SoundManager.shared.playSFX(.pageTransition)
        transition(to: .ready)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            saveAndComplete(answer: answer.isEmpty ? nil : answer)
        }
    }

    private func transition(to next: Phase) {
        withAnimation(.easeOut(duration: 0.5)) { opacity = 0 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            phase = next
            withAnimation(.easeIn(duration: 0.7)) { opacity = 1.0 }
        }
    }

    private func saveAndComplete(answer: String?) {
        if let a = answer {
            UserDefaults.standard.set(a, forKey: "terra_player_origin")
        }
        UserDefaults.standard.set(true, forKey: "terra_origin_asked")
        withAnimation(TerraAnimation.slow) { isComplete = true }
    }
}
