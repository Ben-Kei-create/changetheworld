import SwiftUI

// 佐藤優子と田中花子のリクエストから生まれた設定
// "子どもモード" — 文字を大きく、文章を読みやすく、難しい表現にふりがな

final class AccessibilitySettings: ObservableObject {
    static let shared = AccessibilitySettings()

    @Published var textSizeMultiplier: CGFloat = 1.0 {
        didSet { save() }
    }
    @Published var showReadingGuide: Bool = false {
        didSet { save() }
    }
    @Published var highContrastMode: Bool = false {
        didSet { save() }
    }
    @Published var reducedMotion: Bool = false {
        didSet { save() }
    }

    // 子どもモード: テキストサイズ拡大 + シンプルな語彙ガイドを有効化
    var isYoungReaderMode: Bool {
        textSizeMultiplier >= 1.25
    }

    private init() { load() }

    private let key = "terra_a11y_v1"

    func save() {
        let data: [String: Any] = [
            "textSize": textSizeMultiplier,
            "readingGuide": showReadingGuide,
            "highContrast": highContrastMode,
            "reducedMotion": reducedMotion
        ]
        UserDefaults.standard.set(data, forKey: key)
    }

    func load() {
        guard let data = UserDefaults.standard.dictionary(forKey: key) else { return }
        textSizeMultiplier  = data["textSize"]      as? CGFloat ?? 1.0
        showReadingGuide    = data["readingGuide"]  as? Bool ?? false
        highContrastMode    = data["highContrast"]  as? Bool ?? false
        reducedMotion       = data["reducedMotion"] as? Bool ?? false
    }
}

// MARK: - Accessible Text

struct TerraText: View {
    let text: String
    let style: TerraTextStyle
    @ObservedObject private var a11y = AccessibilitySettings.shared

    enum TerraTextStyle {
        case narrative, choice, caption, heading
    }

    var body: some View {
        Text(text)
            .font(scaledFont)
            .lineSpacing(lineSpacing)
    }

    private var scaledFont: Font {
        let base: CGFloat
        switch style {
        case .narrative: base = 17
        case .choice:    base = 14
        case .caption:   base = 12
        case .heading:   base = 32
        }
        return .system(size: base * a11y.textSizeMultiplier,
                       weight: style == .heading ? .light : .light,
                       design: style == .narrative || style == .heading ? .serif : .default)
    }

    private var lineSpacing: CGFloat {
        style == .narrative ? 8 * a11y.textSizeMultiplier : 4
    }
}

// MARK: - Estimated reading time label

struct ReadingTimeLabel: View {
    let sceneCount: Int

    private var minutes: String {
        let low  = sceneCount * 8
        let high = sceneCount * 15
        return "\(low)–\(high) min"
    }

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "clock")
                .font(.system(size: 11))
            Text(minutes)
                .font(.system(size: 12, weight: .light))
        }
        .foregroundColor(TerraColor.textTertiary)
    }
}
