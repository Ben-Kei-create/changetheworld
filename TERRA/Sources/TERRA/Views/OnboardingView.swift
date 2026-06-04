import SwiftUI

// Onboarding that feels like the game — no tutorial screens, just experience.
// Sofia's suggestion: "Let the world tell you how to play."

struct OnboardingView: View {
    @EnvironmentObject var gameState: GameState
    @Binding var isComplete: Bool

    @State private var step = 0
    @State private var opacity = 0.0

    private let steps: [OnboardingStep] = [
        OnboardingStep(
            visual: "globe.europe.africa.fill",
            color: TerraColor.earthGreen,
            headline: "The world is not a headline.",
            body: "It is made of people — engineers, teachers, farmers, elders — each living at the intersection of a challenge and a choice.",
            cta: nil
        ),
        OnboardingStep(
            visual: "figure.stand",
            color: TerraColor.oceanBlue,
            headline: "You will walk in their shoes.",
            body: "Each story is grounded in real research. The decisions are real. There are no easy answers, and no correct ones.",
            cta: nil
        ),
        OnboardingStep(
            visual: "arrow.triangle.branch",
            color: TerraColor.dawnOrange,
            headline: "Your choices have weight.",
            body: "Every decision you make shapes the story and accumulates into your global impact score — a reflection of the kind of world you help build.",
            cta: nil
        ),
        OnboardingStep(
            visual: "map.fill",
            color: TerraColor.sunGold,
            headline: "Begin anywhere.",
            body: "Six continents. Six stories. Two are open to you now. Finish one to unlock the next. The world will expand.",
            cta: "Enter the World"
        )
    ]

    var body: some View {
        ZStack {
            TerraColor.spaceDeep
                .ignoresSafeArea()

            // Subtle particle bg
            StarFieldView()
                .opacity(0.4)

            VStack {
                // Step content
                if step < steps.count {
                    let current = steps[step]
                    OnboardingStepView(step: current)
                        .id(step)
                        .opacity(opacity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                }

                // Progress dots
                HStack(spacing: 10) {
                    ForEach(0..<steps.count, id: \.self) { i in
                        Circle()
                            .fill(i == step ? TerraColor.earthGreen : TerraColor.surfaceBorder)
                            .frame(width: i == step ? 8 : 5, height: i == step ? 8 : 5)
                            .animation(TerraAnimation.fast, value: step)
                    }
                }
                .padding(.bottom, TerraSpacing.xxl)

                // Navigation
                HStack(spacing: TerraSpacing.lg) {
                    if step > 0 {
                        Button(action: prevStep) {
                            HStack(spacing: 6) {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                            .font(TerraFont.ui(13))
                            .foregroundColor(TerraColor.textTertiary)
                        }
                        .buttonStyle(.plain)
                    }

                    Spacer()

                    if let cta = steps[step].cta {
                        Button(action: finish) {
                            Text(cta)
                                .font(TerraFont.ui(15, weight: .medium))
                                .tracking(2)
                                .foregroundColor(.black)
                                .frame(width: 220, height: 50)
                                .background(TerraColor.earthGreen)
                                .cornerRadius(TerraRadius.sm)
                        }
                        .buttonStyle(.plain)
                    } else {
                        Button(action: nextStep) {
                            HStack(spacing: 6) {
                                Text("Continue")
                                Image(systemName: "chevron.right")
                            }
                            .font(TerraFont.ui(14, weight: .medium))
                            .tracking(1)
                            .foregroundColor(TerraColor.textAccent)
                            .frame(width: 180, height: 44)
                            .overlay(
                                RoundedRectangle(cornerRadius: TerraRadius.sm)
                                    .stroke(TerraColor.textAccent.opacity(0.3), lineWidth: 1)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, TerraSpacing.page)
                .padding(.bottom, TerraSpacing.xl)
            }
        }
        .onAppear {
            withAnimation(TerraAnimation.reveal) { opacity = 1.0 }
        }
    }

    private func nextStep() {
        SoundManager.shared.playSFX(.pageTransition)
        withAnimation(TerraAnimation.standard) {
            opacity = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            step += 1
            withAnimation(TerraAnimation.standard) {
                opacity = 1.0
            }
        }
    }

    private func prevStep() {
        withAnimation(TerraAnimation.standard) { opacity = 0 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            step -= 1
            withAnimation(TerraAnimation.standard) { opacity = 1.0 }
        }
    }

    private func finish() {
        SoundManager.shared.playSFX(.pageTransition)
        UserDefaults.standard.set(true, forKey: "terra_onboarding_done")
        withAnimation(TerraAnimation.slow) { isComplete = true }
    }
}

struct OnboardingStep {
    let visual: String
    let color: Color
    let headline: String
    let body: String
    let cta: String?
}

struct OnboardingStepView: View {
    let step: OnboardingStep
    @State private var iconPulse = false

    var body: some View {
        VStack(spacing: TerraSpacing.xl) {
            Spacer()

            // Visual
            ZStack {
                Circle()
                    .fill(step.color.opacity(0.08))
                    .frame(width: 160, height: 160)
                    .scaleEffect(iconPulse ? 1.08 : 1.0)
                    .animation(
                        .easeInOut(duration: 3.0).repeatForever(autoreverses: true),
                        value: iconPulse
                    )

                Circle()
                    .stroke(step.color.opacity(0.2), lineWidth: 1)
                    .frame(width: 140, height: 140)

                Image(systemName: step.visual)
                    .font(.system(size: 60, weight: .ultraLight))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [step.color, step.color.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .onAppear { iconPulse = true }

            // Text
            VStack(spacing: TerraSpacing.md) {
                Text(step.headline)
                    .font(TerraFont.display(34))
                    .foregroundColor(TerraColor.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)

                Text(step.body)
                    .font(TerraFont.body(16))
                    .foregroundColor(TerraColor.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(7)
                    .frame(maxWidth: 540)
            }
            .padding(.horizontal, TerraSpacing.page)

            Spacer()
        }
    }
}
