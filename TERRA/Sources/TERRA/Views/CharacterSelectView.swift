import SwiftUI

struct CharacterSelectView: View {
    @EnvironmentObject var gameState: GameState

    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        ZStack {
            Color(red: 0.04, green: 0.07, blue: 0.15)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: { gameState.currentScreen = .worldMap }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                            Text("World Map")
                        }
                        .font(.system(size: 13, weight: .light))
                        .foregroundColor(.white.opacity(0.5))
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Text("ALL STORIES")
                        .font(.system(size: 14, weight: .light))
                        .tracking(4)
                        .foregroundColor(.white.opacity(0.5))

                    Spacer()
                    Color.clear.frame(width: 80)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 20)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(gameState.characters) { character in
                            CharacterCard(character: character) {
                                if character.isUnlocked {
                                    gameState.selectCharacter(character)
                                }
                            }
                        }
                    }
                    .padding(40)
                }
            }
        }
    }
}

struct CharacterCard: View {
    let character: Character
    let action: () -> Void
    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 0) {
                // Header section
                ZStack(alignment: .bottomLeading) {
                    LinearGradient(
                        colors: [
                            character.challenge.color.opacity(character.isUnlocked ? 0.7 : 0.2),
                            character.challenge.color.opacity(character.isUnlocked ? 0.3 : 0.05)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 120)

                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Image(systemName: character.avatarSymbol)
                                .font(.system(size: 24))
                                .foregroundColor(.white.opacity(character.isUnlocked ? 1.0 : 0.3))
                            Text(character.name)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white.opacity(character.isUnlocked ? 1.0 : 0.4))
                        }
                        Spacer()
                        if !character.isUnlocked {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.white.opacity(0.3))
                        }
                    }
                    .padding(16)
                }

                // Info section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(character.origin)
                        Text("·")
                        Text("Age \(character.age)")
                    }
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.white.opacity(0.5))

                    Text(character.backstory)
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(.white.opacity(0.6))
                        .lineLimit(3)
                        .lineSpacing(3)

                    HStack(spacing: 6) {
                        Image(systemName: character.challenge.icon)
                            .font(.system(size: 10))
                        Text(character.challenge.rawValue)
                            .font(.system(size: 11, weight: .medium))
                    }
                    .foregroundColor(character.challenge.color.opacity(character.isUnlocked ? 1.0 : 0.4))
                }
                .padding(16)
            }
            .background(Color.white.opacity(isHovered && character.isUnlocked ? 0.06 : 0.03))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        character.isUnlocked && isHovered
                            ? character.challenge.color.opacity(0.4)
                            : Color.white.opacity(0.07),
                        lineWidth: 1
                    )
            )
        }
        .buttonStyle(.plain)
        .scaleEffect(isHovered && character.isUnlocked ? 1.02 : 1.0)
        .animation(.spring(duration: 0.2), value: isHovered)
        .onHover { isHovered = $0 }
        .opacity(character.isUnlocked ? 1.0 : 0.6)
    }
}
