import SwiftUI

struct SplashView: View {
    @Binding var isFinished: Bool

    @State private var globeScale: CGFloat = 0.3
    @State private var globeOpacity: Double = 0
    @State private var textOpacity: Double = 0
    @State private var lineWidth: CGFloat = 0
    @State private var phase = 0

    var body: some View {
        ZStack {
            TerraColor.spaceDeep
                .ignoresSafeArea()

            VStack(spacing: TerraSpacing.lg) {
                // Animated logo mark
                ZStack {
                    // Outer ring expanding
                    Circle()
                        .stroke(TerraColor.earthGreen.opacity(0.3), lineWidth: 1)
                        .frame(width: 100, height: 100)
                        .scaleEffect(phase >= 2 ? 1.4 : 0.8)
                        .opacity(phase >= 2 ? 0 : 0.6)
                        .animation(TerraAnimation.slow.delay(0.6), value: phase)

                    // Globe icon
                    Image(systemName: "globe.europe.africa.fill")
                        .font(.system(size: 48, weight: .ultraLight))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [TerraColor.earthGreen, TerraColor.oceanBlue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .scaleEffect(globeScale)
                        .opacity(globeOpacity)
                }

                // Horizontal divider line animating in
                Rectangle()
                    .fill(TerraColor.earthGreen.opacity(0.5))
                    .frame(width: lineWidth, height: 0.5)
                    .animation(TerraAnimation.slow.delay(0.4), value: lineWidth)

                // Title
                VStack(spacing: 6) {
                    Text("TERRA")
                        .font(TerraFont.display(40))
                        .foregroundColor(TerraColor.textPrimary)
                        .tracking(16)

                    Text("Stories of Our World")
                        .font(TerraFont.ui(13, weight: .light))
                        .foregroundColor(TerraColor.textAccent)
                        .tracking(5)
                }
                .opacity(textOpacity)
            }
        }
        .onAppear {
            withAnimation(TerraAnimation.spring) {
                globeScale = 1.0
                globeOpacity = 1.0
            }
            withAnimation(TerraAnimation.slow.delay(0.3)) {
                lineWidth = 180
                textOpacity = 1.0
                phase = 2
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                withAnimation(TerraAnimation.slow) {
                    isFinished = true
                }
            }
        }
    }
}
