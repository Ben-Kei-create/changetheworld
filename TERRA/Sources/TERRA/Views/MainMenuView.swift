import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var gameState: GameState
    @State private var animateGlobe = false
    @State private var showSubtitle = false
    @State private var showButtons = false
    @State private var particleOpacity = 0.0

    var body: some View {
        ZStack {
            // Deep space background
            LinearGradient(
                colors: [
                    Color(red: 0.02, green: 0.04, blue: 0.12),
                    Color(red: 0.05, green: 0.08, blue: 0.20),
                    Color(red: 0.02, green: 0.05, blue: 0.15)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Star field
            StarFieldView()
                .opacity(particleOpacity)

            VStack(spacing: 0) {
                Spacer()

                // Globe visual
                ZStack {
                    // Glow rings
                    ForEach(0..<3, id: \.self) { i in
                        Circle()
                            .stroke(
                                Color(red: 0.2, green: 0.7, blue: 1.0).opacity(0.1 - Double(i) * 0.03),
                                lineWidth: 1
                            )
                            .frame(width: CGFloat(220 + i * 40), height: CGFloat(220 + i * 40))
                            .scaleEffect(animateGlobe ? 1.05 : 0.95)
                            .animation(
                                .easeInOut(duration: 3.0 + Double(i) * 0.5)
                                    .repeatForever(autoreverses: true),
                                value: animateGlobe
                            )
                    }

                    // Main globe
                    ZStack {
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [
                                        Color(red: 0.1, green: 0.5, blue: 0.9),
                                        Color(red: 0.05, green: 0.25, blue: 0.6),
                                        Color(red: 0.02, green: 0.1, blue: 0.35)
                                    ],
                                    center: UnitPoint(x: 0.35, y: 0.35),
                                    startRadius: 20,
                                    endRadius: 100
                                )
                            )
                            .frame(width: 200, height: 200)

                        // Continent shapes (simplified)
                        GlobeOverlayView()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())

                        // Atmosphere glow
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.4, green: 0.8, blue: 1.0).opacity(0.6),
                                        Color.clear
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 8
                            )
                            .frame(width: 200, height: 200)
                    }
                    .rotationEffect(.degrees(animateGlobe ? 360 : 0))
                    .animation(
                        .linear(duration: 60).repeatForever(autoreverses: false),
                        value: animateGlobe
                    )
                    .shadow(color: Color(red: 0.2, green: 0.5, blue: 1.0).opacity(0.5), radius: 30)
                }
                .padding(.bottom, 40)

                // Title
                VStack(spacing: 8) {
                    Text("TERRA")
                        .font(.system(size: 72, weight: .ultraLight, design: .serif))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color.white,
                                    Color(red: 0.7, green: 0.9, blue: 1.0)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .tracking(20)

                    Text("Stories of Our World")
                        .font(.system(size: 18, weight: .light, design: .serif))
                        .foregroundColor(Color(red: 0.6, green: 0.8, blue: 1.0))
                        .tracking(6)
                        .opacity(showSubtitle ? 1 : 0)
                }
                .padding(.bottom, 60)

                // Buttons
                VStack(spacing: 16) {
                    MenuButton(title: "Begin Journey", style: .primary) {
                        gameState.currentScreen = .worldMap
                    }

                    if gameState.worldData.storiesCompleted > 0 {
                        MenuButton(title: "Continue", style: .secondary) {
                            gameState.currentScreen = .worldMap
                        }
                    }

                    MenuButton(title: "Our Impact", style: .ghost) {
                        gameState.currentScreen = .impactReport
                    }

                    MenuButton(title: "Settings", style: .ghost) {
                        gameState.currentScreen = .settings
                    }
                }
                .opacity(showButtons ? 1 : 0)
                .offset(y: showButtons ? 0 : 20)

                Spacer()

                // Language selector — Mohammed のリクエスト (front and center, not buried)
                LanguageSelectorView()
                    .padding(.bottom, 12)

                // Footer
                HStack {
                    Text("v1.0  ·  Stories from 7 characters  ·  Real data, real change")
                        .font(.system(size: 11, weight: .light))
                        .foregroundColor(Color.white.opacity(0.3))
                        .tracking(2)
                }
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            animateGlobe = true
            withAnimation(.easeIn(duration: 1.5).delay(0.5)) {
                particleOpacity = 1.0
            }
            withAnimation(.easeIn(duration: 0.8).delay(1.0)) {
                showSubtitle = true
            }
            withAnimation(.spring(duration: 0.8).delay(1.5)) {
                showButtons = true
            }
        }
    }
}

// MARK: - Supporting Views

struct StarFieldView: View {
    let stars: [(x: Double, y: Double, size: Double, opacity: Double)] = {
        (0..<150).map { _ in
            (
                x: Double.random(in: 0...1),
                y: Double.random(in: 0...1),
                size: Double.random(in: 0.5...2.5),
                opacity: Double.random(in: 0.2...0.9)
            )
        }
    }()

    var body: some View {
        GeometryReader { geo in
            ForEach(0..<stars.count, id: \.self) { i in
                Circle()
                    .fill(Color.white.opacity(stars[i].opacity))
                    .frame(width: stars[i].size, height: stars[i].size)
                    .position(
                        x: geo.size.width * stars[i].x,
                        y: geo.size.height * stars[i].y
                    )
            }
        }
    }
}

struct GlobeOverlayView: View {
    var body: some View {
        Canvas { context, size in
            let w = size.width
            let h = size.height

            // Africa
            context.fill(
                Path { p in
                    p.move(to: CGPoint(x: w*0.52, y: h*0.35))
                    p.addLine(to: CGPoint(x: w*0.62, y: h*0.32))
                    p.addLine(to: CGPoint(x: w*0.65, y: h*0.48))
                    p.addLine(to: CGPoint(x: w*0.60, y: h*0.65))
                    p.addLine(to: CGPoint(x: w*0.52, y: h*0.70))
                    p.addLine(to: CGPoint(x: w*0.47, y: h*0.58))
                    p.addLine(to: CGPoint(x: w*0.48, y: h*0.42))
                    p.closeSubpath()
                },
                with: .color(Color(red: 0.2, green: 0.6, blue: 0.2).opacity(0.7))
            )

            // Europe
            context.fill(
                Path { p in
                    p.move(to: CGPoint(x: w*0.47, y: h*0.22))
                    p.addLine(to: CGPoint(x: w*0.58, y: h*0.20))
                    p.addLine(to: CGPoint(x: w*0.60, y: h*0.30))
                    p.addLine(to: CGPoint(x: w*0.50, y: h*0.33))
                    p.addLine(to: CGPoint(x: w*0.45, y: h*0.28))
                    p.closeSubpath()
                },
                with: .color(Color(red: 0.2, green: 0.6, blue: 0.2).opacity(0.7))
            )

            // Asia
            context.fill(
                Path { p in
                    p.move(to: CGPoint(x: w*0.62, y: h*0.18))
                    p.addLine(to: CGPoint(x: w*0.85, y: h*0.20))
                    p.addLine(to: CGPoint(x: w*0.88, y: h*0.40))
                    p.addLine(to: CGPoint(x: w*0.80, y: h*0.45))
                    p.addLine(to: CGPoint(x: w*0.68, y: h*0.42))
                    p.addLine(to: CGPoint(x: w*0.60, y: h*0.30))
                    p.closeSubpath()
                },
                with: .color(Color(red: 0.2, green: 0.6, blue: 0.2).opacity(0.7))
            )

            // Americas
            context.fill(
                Path { p in
                    p.move(to: CGPoint(x: w*0.18, y: h*0.18))
                    p.addLine(to: CGPoint(x: w*0.32, y: h*0.20))
                    p.addLine(to: CGPoint(x: w*0.30, y: h*0.45))
                    p.addLine(to: CGPoint(x: w*0.22, y: h*0.72))
                    p.addLine(to: CGPoint(x: w*0.15, y: h*0.68))
                    p.addLine(to: CGPoint(x: w*0.12, y: h*0.38))
                    p.closeSubpath()
                },
                with: .color(Color(red: 0.2, green: 0.6, blue: 0.2).opacity(0.7))
            )

            // Oceania
            context.fill(
                Path { p in
                    p.move(to: CGPoint(x: w*0.78, y: h*0.60))
                    p.addLine(to: CGPoint(x: w*0.90, y: h*0.58))
                    p.addLine(to: CGPoint(x: w*0.92, y: h*0.70))
                    p.addLine(to: CGPoint(x: w*0.80, y: h*0.72))
                    p.closeSubpath()
                },
                with: .color(Color(red: 0.2, green: 0.6, blue: 0.2).opacity(0.7))
            )
        }
    }
}

enum MenuButtonStyle {
    case primary, secondary, ghost
}

struct MenuButton: View {
    let title: String
    let style: MenuButtonStyle
    let action: () -> Void

    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: .medium, design: .default))
                .tracking(3)
                .foregroundColor(foregroundColor)
                .frame(width: 240, height: 48)
                .background(background)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(borderColor, lineWidth: 1)
                )
                .cornerRadius(4)
        }
        .buttonStyle(.plain)
        .scaleEffect(isHovered ? 1.02 : 1.0)
        .animation(.spring(duration: 0.2), value: isHovered)
        .onHover { isHovered = $0 }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary: return .black
        case .secondary: return .white
        case .ghost: return Color(red: 0.6, green: 0.8, blue: 1.0)
        }
    }

    @ViewBuilder
    private var background: some View {
        switch style {
        case .primary:
            LinearGradient(
                colors: isHovered
                    ? [Color(red: 0.8, green: 1.0, blue: 0.9), Color(red: 0.5, green: 0.9, blue: 0.7)]
                    : [Color(red: 0.7, green: 0.95, blue: 0.85), Color(red: 0.4, green: 0.85, blue: 0.65)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .secondary:
            Color.white.opacity(isHovered ? 0.12 : 0.06)
        case .ghost:
            Color.clear
        }
    }

    private var borderColor: Color {
        switch style {
        case .primary: return Color.clear
        case .secondary: return Color.white.opacity(0.3)
        case .ghost: return Color(red: 0.3, green: 0.5, blue: 0.8).opacity(isHovered ? 0.6 : 0.3)
        }
    }
}
