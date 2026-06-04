import SwiftUI

// Mohammed Al-Rashid のリクエスト:
// "Front and center. Not buried in settings."
// 言語選択は、最初に見える場所に。

struct LanguageSelectorView: View {
    @State private var currentLanguage: AppLanguage = .system

    var body: some View {
        HStack(spacing: 4) {
            ForEach(AppLanguage.allCases, id: \.self) { lang in
                Button(action: { select(lang) }) {
                    Text(lang.label)
                        .font(.system(size: 11, weight: currentLanguage == lang ? .medium : .light))
                        .foregroundColor(currentLanguage == lang
                            ? Color.white.opacity(0.8)
                            : Color.white.opacity(0.3))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 3)
                                .fill(currentLanguage == lang
                                    ? Color.white.opacity(0.1)
                                    : Color.clear)
                        )
                }
                .buttonStyle(.plain)

                if lang != AppLanguage.allCases.last {
                    Text("·")
                        .font(.system(size: 10))
                        .foregroundColor(Color.white.opacity(0.15))
                }
            }
        }
    }

    private func select(_ lang: AppLanguage) {
        currentLanguage = lang
        UserDefaults.standard.set([lang.localeId], forKey: "AppleLanguages")
        // Note: full locale change requires app restart.
        // In a production build, prompt user to restart or use Bundle swizzling.
    }
}

enum AppLanguage: String, CaseIterable {
    case system  = "system"
    case english = "en"
    case japanese = "ja"

    var label: String {
        switch self {
        case .system:   return "Auto"
        case .english:  return "EN"
        case .japanese: return "日本語"
        }
    }

    var localeId: String {
        switch self {
        case .system:   return Locale.current.identifier
        case .english:  return "en"
        case .japanese: return "ja"
        }
    }
}
