import SwiftUI

struct WorldMapView: View {
    @EnvironmentObject var gameState: GameState
    @State private var selectedContinent: Continent?
    @State private var hoveredCharacter: Character?
    @State private var mapScale: CGFloat = 1.0
    @State private var mapOffset: CGSize = .zero
    @State private var showIntro = true

    var body: some View {
        ZStack {
            // Background
            Color(red: 0.04, green: 0.06, blue: 0.14)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Navigation bar
                HStack {
                    Button(action: { gameState.currentScreen = .mainMenu }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 13, weight: .medium))
                            Text("TERRA")
                                .font(.system(size: 14, weight: .light))
                                .tracking(4)
                        }
                        .foregroundColor(Color.white.opacity(0.6))
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Text("CHOOSE YOUR STORY")
                        .font(.system(size: 13, weight: .light))
                        .tracking(4)
                        .foregroundColor(Color.white.opacity(0.5))

                    Spacer()

                    // Impact score
                    HStack(spacing: 6) {
                        Image(systemName: "globe.europe.africa.fill")
                            .foregroundColor(Color(red: 0.4, green: 0.8, blue: 0.5))
                            .font(.system(size: 14))
                        Text("Impact: \(gameState.totalImpactScore)")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.5, green: 0.9, blue: 0.6))
                    }
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .background(Color.black.opacity(0.3))

                // Main content
                HStack(spacing: 0) {
                    // World map area
                    GeometryReader { geo in
                        ZStack {
                            // Ocean
                            RadialGradient(
                                colors: [
                                    Color(red: 0.08, green: 0.18, blue: 0.40),
                                    Color(red: 0.03, green: 0.08, blue: 0.22)
                                ],
                                center: .center,
                                startRadius: 100,
                                endRadius: 600
                            )

                            // Grid lines (latitude/longitude)
                            WorldGridView()
                                .opacity(0.08)

                            // Interactive map
                            InteractiveWorldMap(
                                characters: gameState.characters,
                                hoveredCharacter: $hoveredCharacter,
                                onSelect: { character in
                                    if character.isUnlocked {
                                        gameState.selectCharacter(character)
                                    }
                                }
                            )
                        }
                    }

                    // Character panel
                    VStack(spacing: 0) {
                        if let character = hoveredCharacter ?? gameState.characters.first(where: { $0.isUnlocked }) {
                            CharacterInfoPanel(character: character) {
                                if character.isUnlocked {
                                    gameState.selectCharacter(character)
                                }
                            }
                        } else {
                            EmptyPanelView()
                        }
                    }
                    .frame(width: 320)
                    .background(Color.black.opacity(0.4))
                }
            }

            // Intro overlay
            if showIntro {
                IntroOverlay(isShowing: $showIntro)
            }
        }
    }
}

struct WorldGridView: View {
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            Canvas { context, size in
                // Latitude lines
                for i in stride(from: 0.0, through: 1.0, by: 0.1) {
                    let y = h * i
                    context.stroke(
                        Path { p in
                            p.move(to: CGPoint(x: 0, y: y))
                            p.addLine(to: CGPoint(x: w, y: y))
                        },
                        with: .color(.white),
                        lineWidth: 0.5
                    )
                }
                // Longitude lines
                for i in stride(from: 0.0, through: 1.0, by: 0.1) {
                    let x = w * i
                    context.stroke(
                        Path { p in
                            p.move(to: CGPoint(x: x, y: 0))
                            p.addLine(to: CGPoint(x: x, y: h))
                        },
                        with: .color(.white),
                        lineWidth: 0.5
                    )
                }
            }
        }
    }
}

struct InteractiveWorldMap: View {
    let characters: [Character]
    @Binding var hoveredCharacter: Character?
    let onSelect: (Character) -> Void

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            ZStack {
                // Continent shapes
                ContinentShapesView()
                    .frame(width: w, height: h)

                // Connection lines between characters
                ForEach(characters.filter { $0.isUnlocked }) { character in
                    ForEach(characters.filter { $0.isUnlocked && $0.id != character.id }) { other in
                        ConnectionLine(
                            from: mapPosition(character.coordinates, in: geo.size),
                            to: mapPosition(other.coordinates, in: geo.size)
                        )
                    }
                }

                // Character pins
                ForEach(characters) { character in
                    let pos = mapPosition(character.coordinates, in: geo.size)
                    CharacterPin(
                        character: character,
                        isHovered: hoveredCharacter?.id == character.id
                    )
                    .position(pos)
                    .onHover { isHovering in
                        hoveredCharacter = isHovering ? character : nil
                    }
                    .onTapGesture {
                        onSelect(character)
                    }
                }
            }
        }
    }

    private func mapPosition(_ coord: WorldCoordinate, in size: CGSize) -> CGPoint {
        // Mercator-like projection
        let x = (coord.lon + 180.0) / 360.0 * size.width
        let y = (90.0 - coord.lat) / 180.0 * size.height
        return CGPoint(x: x, y: y)
    }
}

struct ConnectionLine: View {
    let from: CGPoint
    let to: CGPoint

    var body: some View {
        Canvas { context, _ in
            context.stroke(
                Path { p in
                    p.move(to: from)
                    p.addLine(to: to)
                },
                with: .color(Color(red: 0.3, green: 0.6, blue: 1.0).opacity(0.08)),
                lineWidth: 0.5
            )
        }
    }
}

struct CharacterPin: View {
    let character: Character
    let isHovered: Bool
    @State private var pulse = false

    var body: some View {
        ZStack {
            if character.isUnlocked {
                // Pulse ring
                Circle()
                    .stroke(character.challenge.color.opacity(0.3), lineWidth: 1)
                    .frame(width: pulse ? 36 : 20, height: pulse ? 36 : 20)
                    .opacity(pulse ? 0 : 0.8)
                    .animation(.easeOut(duration: 2.0).repeatForever(), value: pulse)
            }

            Circle()
                .fill(character.isUnlocked
                    ? character.challenge.color
                    : Color.gray.opacity(0.4))
                .frame(width: isHovered ? 18 : 12, height: isHovered ? 18 : 12)
                .overlay(
                    Image(systemName: character.avatarSymbol)
                        .font(.system(size: isHovered ? 9 : 6))
                        .foregroundColor(.white)
                )
                .shadow(color: character.isUnlocked ? character.challenge.color.opacity(0.6) : .clear, radius: 8)

            if isHovered {
                Text(character.name)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(4)
                    .offset(y: -22)
            }
        }
        .animation(.spring(duration: 0.3), value: isHovered)
        .onAppear {
            if character.isUnlocked { pulse = true }
        }
    }
}

struct ContinentShapesView: View {
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            Canvas { context, size in
                let continents: [(Path, Color)] = makeContinentPaths(w: w, h: h)
                for (path, color) in continents {
                    context.fill(path, with: .color(color))
                    context.stroke(path, with: .color(Color.white.opacity(0.05)), lineWidth: 0.5)
                }
            }
        }
    }

    private func makeContinentPaths(w: CGFloat, h: CGFloat) -> [(Path, Color)] {
        let landColor = Color(red: 0.15, green: 0.35, blue: 0.18)

        // Simplified continent outlines using lat/lon -> x/y
        func proj(_ lat: Double, _ lon: Double) -> CGPoint {
            CGPoint(x: (lon + 180) / 360 * Double(w), y: (90 - lat) / 180 * Double(h))
        }

        // North America
        var na = Path()
        na.move(to: proj(70, -140)); na.addLine(to: proj(75, -85))
        na.addLine(to: proj(60, -64)); na.addLine(to: proj(47, -53))
        na.addLine(to: proj(25, -77)); na.addLine(to: proj(15, -85))
        na.addLine(to: proj(8, -77)); na.addLine(to: proj(15, -92))
        na.addLine(to: proj(22, -105)); na.addLine(to: proj(32, -117))
        na.addLine(to: proj(48, -124)); na.addLine(to: proj(60, -135))
        na.addLine(to: proj(70, -140)); na.closeSubpath()

        // South America
        var sa = Path()
        sa.move(to: proj(12, -73)); sa.addLine(to: proj(8, -60))
        sa.addLine(to: proj(5, -52)); sa.addLine(to: proj(-5, -35))
        sa.addLine(to: proj(-23, -43)); sa.addLine(to: proj(-35, -57))
        sa.addLine(to: proj(-55, -67)); sa.addLine(to: proj(-55, -73))
        sa.addLine(to: proj(-40, -73)); sa.addLine(to: proj(-18, -70))
        sa.addLine(to: proj(0, -80)); sa.addLine(to: proj(12, -73))
        sa.closeSubpath()

        // Europe
        var eu = Path()
        eu.move(to: proj(71, 28)); eu.addLine(to: proj(71, -25))
        eu.addLine(to: proj(60, -25)); eu.addLine(to: proj(55, 5))
        eu.addLine(to: proj(45, 0)); eu.addLine(to: proj(36, -6))
        eu.addLine(to: proj(36, 28)); eu.addLine(to: proj(42, 42))
        eu.addLine(to: proj(48, 40)); eu.addLine(to: proj(60, 30))
        eu.addLine(to: proj(71, 28)); eu.closeSubpath()

        // Africa
        var af = Path()
        af.move(to: proj(37, -6)); af.addLine(to: proj(37, 42))
        af.addLine(to: proj(30, 52)); af.addLine(to: proj(12, 51))
        af.addLine(to: proj(-5, 42)); af.addLine(to: proj(-10, 40))
        af.addLine(to: proj(-35, 27)); af.addLine(to: proj(-35, 17))
        af.addLine(to: proj(-20, 13)); af.addLine(to: proj(-5, -8))
        af.addLine(to: proj(5, -8)); af.addLine(to: proj(15, -17))
        af.addLine(to: proj(37, -6)); af.closeSubpath()

        // Asia
        var as_ = Path()
        as_.move(to: proj(42, 42)); as_.addLine(to: proj(71, 30))
        as_.addLine(to: proj(72, 80)); as_.addLine(to: proj(68, 180))
        as_.addLine(to: proj(50, 150)); as_.addLine(to: proj(35, 140))
        as_.addLine(to: proj(20, 120)); as_.addLine(to: proj(5, 100))
        as_.addLine(to: proj(5, 80)); as_.addLine(to: proj(12, 51))
        as_.addLine(to: proj(30, 52)); as_.addLine(to: proj(42, 42))
        as_.closeSubpath()

        // Australia
        var au = Path()
        au.move(to: proj(-15, 130)); au.addLine(to: proj(-15, 145))
        au.addLine(to: proj(-30, 153)); au.addLine(to: proj(-39, 147))
        au.addLine(to: proj(-39, 130)); au.addLine(to: proj(-32, 115))
        au.addLine(to: proj(-22, 114)); au.addLine(to: proj(-15, 130))
        au.closeSubpath()

        return [
            (na, landColor),
            (sa, landColor),
            (eu, landColor),
            (af, landColor),
            (as_, landColor),
            (au, landColor)
        ]
    }
}

struct CharacterInfoPanel: View {
    let character: Character
    let onPlay: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [
                                character.challenge.color.opacity(0.6),
                                character.challenge.color.opacity(0.2)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 140)

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: character.avatarSymbol)
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                        Spacer()
                        if !character.isUnlocked {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }

                    Text(character.name)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)

                    Text("\(character.origin)  ·  Age \(character.age)")
                        .font(.system(size: 13, weight: .light))
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(20)
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Occupation
                    Label(character.occupation, systemImage: "person.fill")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(character.challenge.color)

                    // Challenge
                    HStack {
                        Image(systemName: character.challenge.icon)
                            .foregroundColor(character.challenge.color)
                        Text(character.challenge.rawValue)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(character.challenge.color)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(character.challenge.color.opacity(0.15))
                    .cornerRadius(4)

                    // Backstory
                    Text(character.backstory)
                        .font(.system(size: 13, weight: .light))
                        .foregroundColor(.white.opacity(0.75))
                        .lineSpacing(5)
                        .fixedSize(horizontal: false, vertical: true)

                    // Reading time — 鈴木健司のリクエスト
                    HStack(spacing: 5) {
                        Image(systemName: "clock")
                            .font(.system(size: 11))
                        Text("Approx. 60–90 min")
                            .font(.system(size: 12, weight: .light))
                    }
                    .foregroundColor(.white.opacity(0.35))

                    // Play button
                    if character.isUnlocked {
                        Button(action: onPlay) {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("Enter Their World")
                            }
                            .font(.system(size: 14, weight: .medium))
                            .tracking(1)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                LinearGradient(
                                    colors: [character.challenge.color, character.challenge.color.opacity(0.7)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(6)
                        }
                        .buttonStyle(.plain)
                    } else {
                        Text("Complete another story to unlock")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(.white.opacity(0.4))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 14)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                            )
                    }
                }
                .padding(20)
            }
        }
        .foregroundColor(.white)
    }
}

struct EmptyPanelView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "globe")
                .font(.system(size: 48))
                .foregroundColor(.white.opacity(0.15))
            Text("Hover over a story to explore")
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.white.opacity(0.3))
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct IntroOverlay: View {
    @Binding var isShowing: Bool
    @State private var opacity = 0.0

    var body: some View {
        ZStack {
            Color.black.opacity(0.85)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("The world has many stories.")
                    .font(.system(size: 28, weight: .ultraLight, design: .serif))
                    .foregroundColor(.white)

                Text("Each one is connected.")
                    .font(.system(size: 20, weight: .ultraLight, design: .serif))
                    .foregroundColor(Color(red: 0.6, green: 0.85, blue: 1.0))

                Text("Choose where to begin.")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white.opacity(0.6))

                Button("Explore the World") {
                    withAnimation(.easeOut(duration: 0.5)) {
                        isShowing = false
                    }
                }
                .buttonStyle(.plain)
                .font(.system(size: 14, weight: .medium))
                .tracking(3)
                .foregroundColor(.black)
                .frame(width: 220, height: 44)
                .background(Color(red: 0.4, green: 0.85, blue: 0.65))
                .cornerRadius(4)
            }
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.6)) {
                opacity = 1.0
            }
        }
    }
}
