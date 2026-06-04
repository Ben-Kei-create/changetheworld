import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var gameState: GameState
    @State private var showResetConfirm = false

    var body: some View {
        ZStack {
            Color(red: 0.04, green: 0.07, blue: 0.15)
                .ignoresSafeArea()

            VStack(spacing: 0) {
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
                    Text("SETTINGS")
                        .font(.system(size: 14, weight: .light))
                        .tracking(4)
                        .foregroundColor(.white.opacity(0.5))
                    Spacer()
                    Color.clear.frame(width: 60)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 20)

                VStack(spacing: 24) {
                    SettingsSection(title: "Audio") {
                        SettingsToggle(label: "Music", icon: "music.note", isOn: $gameState.musicEnabled)
                        SettingsToggle(label: "Sound Effects", icon: "speaker.wave.2.fill", isOn: $gameState.soundEnabled)
                    }

                    SettingsSection(title: "Game") {
                        SettingsRow(label: "Stories Completed", value: "\(gameState.worldData.storiesCompleted)")
                        SettingsRow(label: "Total Impact Score", value: "\(gameState.totalImpactScore)")
                        SettingsRow(label: "Version", value: "1.0.0")
                    }

                    SettingsSection(title: "Data") {
                        Button(action: { showResetConfirm = true }) {
                            HStack {
                                Image(systemName: "arrow.counterclockwise")
                                    .foregroundColor(.red.opacity(0.7))
                                Text("Reset All Progress")
                                    .foregroundColor(.red.opacity(0.7))
                                Spacer()
                            }
                            .font(.system(size: 14, weight: .regular))
                            .padding(.vertical, 4)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .frame(maxWidth: 500)
                .padding(.top, 40)

                Spacer()
            }
        }
        .alert("Reset Progress?", isPresented: $showResetConfirm) {
            Button("Cancel", role: .cancel) {}
            Button("Reset", role: .destructive) {
                gameState.resetGame()
            }
        } message: {
            Text("This will erase all story progress and impact scores. This cannot be undone.")
        }
    }
}

struct SettingsSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .tracking(3)
                .foregroundColor(.white.opacity(0.3))

            VStack(spacing: 0) {
                content
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.04))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.07), lineWidth: 1)
            )
        }
    }
}

struct SettingsToggle: View {
    let label: String
    let icon: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white.opacity(0.5))
                .frame(width: 20)
            Text(label)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.white.opacity(0.8))
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(.switch)
                .labelsHidden()
                .tint(Color(red: 0.3, green: 0.8, blue: 0.5))
        }
        .padding(.vertical, 10)
    }
}

struct SettingsRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.white.opacity(0.7))
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.4))
        }
        .padding(.vertical, 10)
    }
}

struct AboutView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(red: 0.04, green: 0.07, blue: 0.15)
                .ignoresSafeArea()

            VStack(spacing: 32) {
                Image(systemName: "globe.europe.africa.fill")
                    .font(.system(size: 56))
                    .foregroundColor(Color(red: 0.3, green: 0.7, blue: 0.9))

                VStack(spacing: 8) {
                    Text("TERRA")
                        .font(.system(size: 32, weight: .ultraLight))
                        .tracking(8)
                        .foregroundColor(.white)
                    Text("Stories of Our World")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(.white.opacity(0.5))
                }

                Text("TERRA is a narrative experience built on the belief that understanding is the first step to change. Each story is grounded in real research, real data, and the lives of real people working on the world's most urgent challenges.\n\nThe choices you make reflect the choices humanity faces. None are easy. All matter.")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .frame(maxWidth: 440)

                Text("Version 1.0  ·  © 2026 TERRA Studio")
                    .font(.system(size: 11, weight: .light))
                    .foregroundColor(.white.opacity(0.3))

                Button("Close") { dismiss() }
                    .buttonStyle(.plain)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.6))
                    .frame(width: 120, height: 36)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            }
            .padding(60)
        }
        .frame(width: 560, height: 520)
    }
}
