import SwiftUI

// MARK: - TERRA Design System
// Single source of truth for all visual constants

enum TerraColor {
    // Base palette
    static let spaceDeep      = Color(red: 0.02, green: 0.04, blue: 0.12)
    static let spaceMid       = Color(red: 0.04, green: 0.07, blue: 0.18)
    static let spaceLight     = Color(red: 0.08, green: 0.13, blue: 0.28)

    // Accent
    static let earthGreen     = Color(red: 0.22, green: 0.72, blue: 0.44)
    static let earthGreenSoft = Color(red: 0.3,  green: 0.82, blue: 0.55)
    static let oceanBlue      = Color(red: 0.18, green: 0.52, blue: 0.92)
    static let sunGold        = Color(red: 0.98, green: 0.78, blue: 0.20)
    static let dawnOrange     = Color(red: 1.0,  green: 0.48, blue: 0.22)

    // Text
    static let textPrimary    = Color.white
    static let textSecondary  = Color.white.opacity(0.65)
    static let textTertiary   = Color.white.opacity(0.35)
    static let textAccent     = Color(red: 0.55, green: 0.85, blue: 1.0)

    // Surface
    static let surfaceCard    = Color.white.opacity(0.04)
    static let surfaceBorder  = Color.white.opacity(0.08)
    static let surfaceHover   = Color.white.opacity(0.08)
    static let overlayDark    = Color.black.opacity(0.5)
}

enum TerraFont {
    static func display(_ size: CGFloat) -> Font {
        .system(size: size, weight: .ultraLight, design: .serif)
    }
    static func heading(_ size: CGFloat) -> Font {
        .system(size: size, weight: .semibold, design: .default)
    }
    static func body(_ size: CGFloat) -> Font {
        .system(size: size, weight: .light, design: .serif)
    }
    static func ui(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
    static func label(_ size: CGFloat) -> Font {
        .system(size: size, weight: .medium, design: .default)
    }
    static func caption() -> Font {
        .system(size: 11, weight: .light, design: .default)
    }
}

enum TerraSpacing {
    static let xs: CGFloat   = 4
    static let sm: CGFloat   = 8
    static let md: CGFloat   = 16
    static let lg: CGFloat   = 24
    static let xl: CGFloat   = 40
    static let xxl: CGFloat  = 60
    static let page: CGFloat = 80
}

enum TerraRadius {
    static let sm: CGFloat  = 4
    static let md: CGFloat  = 8
    static let lg: CGFloat  = 12
    static let xl: CGFloat  = 20
    static let full: CGFloat = 999
}

enum TerraAnimation {
    static let fast     = Animation.easeInOut(duration: 0.2)
    static let standard = Animation.easeInOut(duration: 0.4)
    static let slow     = Animation.easeInOut(duration: 0.8)
    static let spring   = Animation.spring(response: 0.4, dampingFraction: 0.75)
    static let reveal   = Animation.easeIn(duration: 0.6)
}

// MARK: - View Modifiers

struct TerraCardStyle: ViewModifier {
    var padding: CGFloat = TerraSpacing.lg

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(TerraColor.surfaceCard)
            .overlay(
                RoundedRectangle(cornerRadius: TerraRadius.lg)
                    .stroke(TerraColor.surfaceBorder, lineWidth: 1)
            )
            .cornerRadius(TerraRadius.lg)
    }
}

extension View {
    func terraCard(padding: CGFloat = TerraSpacing.lg) -> some View {
        modifier(TerraCardStyle(padding: padding))
    }

    func terraSectionLabel() -> some View {
        self
            .font(TerraFont.ui(10, weight: .semibold))
            .tracking(3)
            .foregroundColor(TerraColor.textTertiary)
    }
}
