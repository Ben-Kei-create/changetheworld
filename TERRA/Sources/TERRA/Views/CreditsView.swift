import SwiftUI

// ???のリクエスト:
// 「このゲームは実在する人々の研究と痛みの上に作られている。
//   その名前がどこにも出ない。」
//
// 出す。全員の名前を。

struct CreditsView: View {
    @EnvironmentObject var gameState: GameState
    @State private var scrollOffset: CGFloat = 0
    @State private var appeared = false

    var body: some View {
        ZStack {
            TerraColor.spaceDeep.ignoresSafeArea()
            StarFieldView().opacity(0.3)

            VStack(spacing: 0) {
                // Nav
                HStack {
                    Button(action: { gameState.currentScreen = .mainMenu }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .font(TerraFont.ui(13))
                        .foregroundColor(TerraColor.textTertiary)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Text("CREDITS & SOURCES")
                        .font(TerraFont.ui(12, weight: .light))
                        .tracking(4)
                        .foregroundColor(TerraColor.textTertiary)
                    Spacer()
                    Color.clear.frame(width: 60)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 20)
                .background(TerraColor.spaceDeep)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 64) {

                        // Title
                        VStack(spacing: 12) {
                            Text("TERRA")
                                .font(TerraFont.display(48))
                                .foregroundColor(TerraColor.textPrimary)
                                .tracking(16)
                            Text("Stories of Our World")
                                .font(TerraFont.ui(14, weight: .light))
                                .foregroundColor(TerraColor.textAccent)
                                .tracking(5)
                            Text("Version 1.0  ·  2026")
                                .font(TerraFont.caption())
                                .foregroundColor(TerraColor.textTertiary)
                        }
                        .padding(.top, 40)

                        Divider().background(TerraColor.surfaceBorder)
                            .frame(maxWidth: 400)

                        // Research & Sources
                        CreditsSection(title: "RESEARCH & PRIMARY SOURCES") {
                            CreditsBlock(heading: "Climate Crisis — Amara's Story") {
                                CreditLine("IPCC Sixth Assessment Report (2021-2022)")
                                CreditLine("International Energy Agency: Africa Energy Outlook 2022")
                                CreditLine("Solar Sister — solarsister.org")
                                CreditLine("Practical Action: Solar Energy in Sub-Saharan Africa")
                            }
                            CreditsBlock(heading: "Ocean Pollution — Mei Lin's Story") {
                                CreditLine("Science (2015): Jambeck et al., Plastic waste inputs from land into the ocean")
                                CreditLine("UNEP: From Pollution to Solution, 2021")
                                CreditLine("Ocean Conservancy: Stemming the Tide Report")
                                CreditLine("Yangtze River Ecology Research Center, Nanjing")
                            }
                            CreditsBlock(heading: "Deforestation — Carlos's Story") {
                                CreditLine("Rights and Resources Initiative: Who Owns the World's Land?")
                                CreditLine("Amazon Watch — amazonwatch.org")
                                CreditLine("COICA: Coordinator of Indigenous Organizations of the Amazon River Basin")
                                CreditLine("FAO: The State of the World's Forests 2022")
                            }
                            CreditsBlock(heading: "Inequality & Education — Fatima's Story") {
                                CreditLine("UNHCR: Education Report 2022 — The Right to Learn")
                                CreditLine("UNESCO: Global Education Monitoring Report")
                                CreditLine("Malala Fund: Girls' Education Research")
                                CreditLine("IRC: Education in Emergencies, Jordan field data")
                            }
                            CreditsBlock(heading: "Urban Poverty — James's Story") {
                                CreditLine("FAO: Urban Food Systems and COVID-19 Response")
                                CreditLine("GRAIN: Urban Agriculture and Food Sovereignty")
                                CreditLine("Lagos Urban Food Security Initiative — field interviews")
                                CreditLine("La Via Campesina: Food Sovereignty Framework")
                            }
                            CreditsBlock(heading: "Human Isolation — Hana's Story") {
                                CreditLine("Holt-Lunstad, J. (2015). Loneliness and social isolation as risk factors. Perspectives on Psychological Science.")
                                CreditLine("Japan Ministry of Internal Affairs: Loneliness Policy Report 2021")
                                CreditLine("Campaign to End Loneliness (UK) — Research Library")
                                CreditLine("Cacioppo & Patrick: Loneliness: Human Nature and the Need for Social Connection")
                            }
                            CreditsBlock(heading: "Climate Anxiety — Astrid's Story") {
                                CreditLine("Hickman et al. (2021). Climate anxiety in children and young people. The Lancet Planetary Health.")
                                CreditLine("Clayton & Karazsia (2020). Development of a measure of climate change anxiety. Journal of Environmental Psychology.")
                                CreditLine("SMHI (Swedish Met): Baltic Sea Temperature Records 1960–2025")
                                CreditLine("APA: Mental Health and Our Changing Climate, 2017 & 2021")
                            }
                        }

                        Divider().background(TerraColor.surfaceBorder).frame(maxWidth: 400)

                        // Team
                        CreditsSection(title: "BUILT BY") {
                            VStack(spacing: 20) {
                                TeamMember(role: "Lead Developer",           name: "Kai Nakamura")
                                TeamMember(role: "Design & Frontend",        name: "Yuna Park")
                                TeamMember(role: "Backend & Game Logic",     name: "Raj Patel")
                                TeamMember(role: "Marketing",               name: "Hiro Matsumoto")
                                TeamMember(role: "Legal Counsel",           name: "Claire Beaumont")
                            }
                        }

                        Divider().background(TerraColor.surfaceBorder).frame(maxWidth: 400)

                        // Voices in the room
                        CreditsSection(title: "VOICES THAT SHAPED THIS GAME") {
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach([
                                    "Hanako T. — who remembered her father's silence",
                                    "Alex C. — who asked if the player has a voice too",
                                    "Taro Y. — who reminded us not everyone is a gamer",
                                    "Sofia R. — who asked for beauty before utility",
                                    "Kenji S. — who told us when something wasn't fun",
                                    "Emma T. — who kept us honest about the data",
                                    "Yuko S. — who asked if children could play it",
                                    "Mohammed A. — who put the language selector front and center",
                                    "Hikaru I. — who remembered a specific afternoon light",
                                    "Linda P. — whose granddaughter became Astrid",
                                ], id: \.self) { voice in
                                    Text(voice)
                                        .font(TerraFont.ui(13, weight: .light))
                                        .foregroundColor(TerraColor.textSecondary)
                                        .lineSpacing(4)
                                }
                            }
                            .frame(maxWidth: 520, alignment: .leading)
                        }

                        Divider().background(TerraColor.surfaceBorder).frame(maxWidth: 400)

                        // The unknown
                        CreditsSection(title: "AND") {
                            VStack(spacing: 16) {
                                Text("??? — who asked the questions nobody wanted to hear")
                                    .font(TerraFont.ui(13, weight: .light))
                                    .foregroundColor(TerraColor.textSecondary)

                                Text("GodManager — who watched, and once said: "誰も、まだ、遊んでいない。"")
                                    .font(TerraFont.ui(13, weight: .light))
                                    .foregroundColor(TerraColor.textSecondary)

                                Text("The baby — who had no opinion, and changed everything.")
                                    .font(TerraFont.ui(13, weight: .light))
                                    .foregroundColor(TerraColor.textTertiary)
                                    .italic()
                            }
                            .frame(maxWidth: 520)
                            .multilineTextAlignment(.center)
                        }

                        Divider().background(TerraColor.surfaceBorder).frame(maxWidth: 400)

                        // Closing
                        VStack(spacing: 20) {
                            Text("This game is dedicated to everyone\nwho kept going after understanding the scale of it.")
                                .font(TerraFont.display(22))
                                .foregroundColor(TerraColor.textSecondary)
                                .multilineTextAlignment(.center)
                                .lineSpacing(6)
                                .frame(maxWidth: 540)

                            Text("© 2026 TERRA Studio · terraapp.world")
                                .font(TerraFont.caption())
                                .foregroundColor(TerraColor.textTertiary)
                                .tracking(1)
                        }
                        .padding(.bottom, 80)
                    }
                    .padding(.horizontal, 60)
                }
            }
        }
    }
}

// MARK: - Credits Components

struct CreditsSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            Text(title)
                .terraSectionLabel()
            content
        }
        .frame(maxWidth: 640)
    }
}

struct CreditsBlock<Content: View>: View {
    let heading: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(heading)
                .font(TerraFont.ui(12, weight: .semibold))
                .foregroundColor(TerraColor.earthGreen)
                .tracking(1)
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .terraCard(padding: 20)
    }
}

struct CreditLine: View {
    let text: String
    init(_ text: String) { self.text = text }

    var body: some View {
        Text("· \(text)")
            .font(TerraFont.ui(12, weight: .light))
            .foregroundColor(TerraColor.textSecondary)
            .lineSpacing(3)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TeamMember: View {
    let role: String
    let name: String

    var body: some View {
        HStack {
            Text(role)
                .font(TerraFont.ui(12, weight: .light))
                .foregroundColor(TerraColor.textTertiary)
                .frame(width: 180, alignment: .leading)
            Text(name)
                .font(TerraFont.ui(14, weight: .medium))
                .foregroundColor(TerraColor.textPrimary)
        }
    }
}
