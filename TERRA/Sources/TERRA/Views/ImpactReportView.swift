import SwiftUI

struct ImpactReportView: View {
    @EnvironmentObject var gameState: GameState

    var body: some View {
        ZStack {
            Color(red: 0.04, green: 0.07, blue: 0.15)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { gameState.currentScreen = .mainMenu }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .font(.system(size: 13, weight: .light))
                        .foregroundColor(.white.opacity(0.5))
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Text("OUR COLLECTIVE IMPACT")
                        .font(.system(size: 14, weight: .light))
                        .tracking(4)
                        .foregroundColor(.white.opacity(0.5))

                    Spacer()
                    Color.clear.frame(width: 60)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 20)

                ScrollView {
                    VStack(spacing: 48) {
                        // Headline
                        VStack(spacing: 12) {
                            Text("Every story matters.")
                                .font(.system(size: 36, weight: .ultraLight, design: .serif))
                                .foregroundColor(.white)
                            Text("These numbers reflect real-world context for each challenge TERRA explores.")
                                .font(.system(size: 15, weight: .light))
                                .foregroundColor(.white.opacity(0.5))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 20)

                        // Player stats
                        if gameState.worldData.storiesCompleted > 0 {
                            PlayerStatsCard(gameState: gameState)
                        }

                        // World data section
                        VStack(alignment: .leading, spacing: 24) {
                            Text("THE REAL NUMBERS")
                                .font(.system(size: 11, weight: .semibold))
                                .tracking(4)
                                .foregroundColor(.white.opacity(0.4))

                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                WorldStatCard(
                                    value: "1.2°C",
                                    label: "Global Temperature Rise",
                                    context: "above pre-industrial levels",
                                    color: ChallengeType.climate.color,
                                    icon: ChallengeType.climate.icon
                                )
                                WorldStatCard(
                                    value: "170M",
                                    label: "Tons of Ocean Plastic",
                                    context: "and growing by 11M tons/year",
                                    color: ChallengeType.pollution.color,
                                    icon: ChallengeType.pollution.icon
                                )
                                WorldStatCard(
                                    value: "10M ha",
                                    label: "Forest Lost Per Year",
                                    context: "that's 27,000 hectares daily",
                                    color: ChallengeType.deforestation.color,
                                    icon: ChallengeType.deforestation.icon
                                )
                                WorldStatCard(
                                    value: "250M",
                                    label: "Children Out of School",
                                    context: "globally right now",
                                    color: ChallengeType.inequality.color,
                                    icon: ChallengeType.inequality.icon
                                )
                                WorldStatCard(
                                    value: "733M",
                                    label: "People Hungry",
                                    context: "while food waste reaches 1/3 of production",
                                    color: ChallengeType.poverty.color,
                                    icon: ChallengeType.poverty.icon
                                )
                                WorldStatCard(
                                    value: "1 in 4",
                                    label: "Adults Feel Lonely",
                                    context: "equivalent health risk to smoking",
                                    color: ChallengeType.isolation.color,
                                    icon: ChallengeType.isolation.icon
                                )
                            }
                        }
                        .padding(.horizontal, 60)

                        // Call to action
                        ImpactCTASection()
                            .padding(.horizontal, 60)
                            .padding(.bottom, 60)
                    }
                }
            }
        }
    }
}

struct PlayerStatsCard: View {
    let gameState: GameState

    var body: some View {
        HStack(spacing: 0) {
            Spacer()

            VStack(spacing: 16) {
                Text("YOUR JOURNEY SO FAR")
                    .font(.system(size: 11, weight: .semibold))
                    .tracking(4)
                    .foregroundColor(.white.opacity(0.4))

                HStack(spacing: 60) {
                    StatPill(value: "\(gameState.worldData.storiesCompleted)", label: "Stories\nCompleted")
                    StatPill(value: "\(gameState.totalImpactScore)", label: "Impact\nPoints")
                    StatPill(value: "\(gameState.characters.filter { $0.isUnlocked }.count)", label: "Characters\nUnlocked")
                }
            }
            .padding(40)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.04))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
            )

            Spacer()
        }
        .padding(.horizontal, 60)
    }
}

struct StatPill: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.system(size: 42, weight: .ultraLight))
                .foregroundColor(.white)
            Text(label)
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.white.opacity(0.4))
                .multilineTextAlignment(.center)
                .lineSpacing(3)
        }
    }
}

struct WorldStatCard: View {
    let value: String
    let label: String
    let context: String
    let color: Color
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(color)

            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.system(size: 32, weight: .light))
                    .foregroundColor(color)
                Text(label)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white.opacity(0.8))
                Text(context)
                    .font(.system(size: 11, weight: .light))
                    .foregroundColor(.white.opacity(0.4))
                    .lineSpacing(3)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.06))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(color.opacity(0.15), lineWidth: 1)
        )
        .cornerRadius(10)
    }
}

struct ImpactCTASection: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("REAL ACTION, REAL WORLD")
                .font(.system(size: 11, weight: .semibold))
                .tracking(4)
                .foregroundColor(.white.opacity(0.4))

            Text("TERRA explores real issues. These organizations are on the frontlines.")
                .font(.system(size: 15, weight: .light))
                .foregroundColor(.white.opacity(0.6))
                .multilineTextAlignment(.center)

            HStack(spacing: 16) {
                CTAOrgButton(name: "Solar Sister", focus: "Solar energy access in Africa", color: ChallengeType.climate.color)
                CTAOrgButton(name: "Ocean Conservancy", focus: "Ocean plastic research & cleanup", color: ChallengeType.pollution.color)
                CTAOrgButton(name: "Amazon Watch", focus: "Indigenous land rights", color: ChallengeType.deforestation.color)
            }

            Text("Learn about these organizations at terraapp.world/impact")
                .font(.system(size: 11, weight: .light))
                .foregroundColor(.white.opacity(0.25))
                .italic()
        }
        .padding(32)
        .background(Color.white.opacity(0.03))
        .cornerRadius(12)
    }
}

struct CTAOrgButton: View {
    let name: String
    let focus: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(color)
            Text(focus)
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.white.opacity(0.5))
                .lineSpacing(3)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
        .cornerRadius(8)
    }
}
