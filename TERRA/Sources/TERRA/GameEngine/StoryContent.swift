import Foundation

// MARK: - Story Data Structures

struct StoryContent {
    let title: String
    let scenes: [StoryScene]

    static func story(for character: Character) -> StoryContent {
        switch character.challenge {
        case .climate:   return amaraStory()
        case .pollution: return meiLinStory()
        case .deforestation: return carlosStory()
        case .inequality:    return fatimaStory()
        case .poverty:   return jamesStory()
        case .isolation: return hanaStory()
        }
    }
}

struct StoryScene: Identifiable {
    let id = UUID()
    let narrative: String
    let choices: [StoryChoice]
}

struct StoryChoice: Identifiable {
    let id = UUID()
    let text: String
    let outcome: String
    let icon: String
    let impactScore: Int
}

// MARK: - Amara's Story (Climate / Solar Energy)

private func amaraStory() -> StoryContent {
    StoryContent(
        title: "The Sun Never Forgets",
        scenes: [
            StoryScene(
                narrative: "It is 4:47 AM in Thiès, Senegal. Amara wakes before the call to prayer. The generator outside her workshop coughs twice and dies. Again. She has 11 solar panels, 3 batteries, and a proposal for a 40-village microgrid — but the regional energy authority wants a 2 million CFA bribe to approve it.\n\nShe looks at her notebook. The math is perfect. The need is urgent. But the path forward is blocked by a palm.",
                choices: [
                    StoryChoice(
                        text: "Pay the bribe. The villages need power now and you can't wait.",
                        outcome: "The approval comes through in 48 hours. But word spreads. Three more officials line up with requests. The project debt spirals. By month three, you've paid enough to have built two more microgrids.",
                        icon: "banknote.fill",
                        impactScore: 2
                    ),
                    StoryChoice(
                        text: "Document everything and go to the national anti-corruption commission.",
                        outcome: "It takes six weeks. The commissioner is replaced. Your evidence becomes part of a broader investigation. The approval finally comes — and the precedent protects the next 50 engineers who come after you.",
                        icon: "doc.badge.gearshape",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Find a village elder to negotiate — and build the first panel as proof of concept.",
                        outcome: "The elder's word carries weight no bureaucrat can ignore. You install the first panels. The light in the school that evening travels fast. Two journalists arrive within the week.",
                        icon: "person.2.fill",
                        impactScore: 8
                    )
                ]
            ),
            StoryScene(
                narrative: "Three months later. The first 12 villages have power. A 13-year-old girl named Khadija is doing homework at 9 PM for the first time in her life.\n\nBut the rainy season has shifted — six weeks early, according to the elders. The fishing community 30 km east says the ocean is three degrees warmer than their grandparents remember. They're asking Amara to speak at the regional climate summit in Dakar.\n\nShe's never spoken at a summit before. She's an engineer, not a politician.",
                choices: [
                    StoryChoice(
                        text: "Decline. Focus on the technical work. The panels matter more than speeches.",
                        outcome: "The summit happens without you. A mining company representative gets the closing keynote. Their proposal for 'sustainable extraction' gets applause. The fishing community loses their appeal for coastal protections.",
                        icon: "wrench.fill",
                        impactScore: 2
                    ),
                    StoryChoice(
                        text: "Go to Dakar. Bring Khadija — let the decision-makers see who they're deciding for.",
                        outcome: "Khadija stands in front of 400 delegates and says five words: 'I can read now, sirs.' The room is silent. Three West African nations commit to expanded solar funding that afternoon. International coverage follows.",
                        icon: "person.2.wave.2.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Send your data. Let the numbers speak. Numbers don't need a visa.",
                        outcome: "Your data is cited eleven times in the final summit report. The UN's climate adaptation fund approves a 2.3 million dollar grant for rural West African solar expansion. The numbers were enough.",
                        icon: "chart.bar.doc.horizontal.fill",
                        impactScore: 8
                    )
                ]
            ),
            StoryScene(
                narrative: "One year in. Forty-two villages. 18,000 people with reliable electricity for the first time. Khadija won her regional science competition. A tech company in France is offering Amara a senior engineering role — €90,000 a year, Paris, full relocation package.\n\nShe looks at the map of Senegal on her wall. There are 2,300 villages that still wait in the dark. She thinks about her mother, who still uses kerosene.",
                choices: [
                    StoryChoice(
                        text: "Take the Paris role. Send remittances home. Help from a position of global influence.",
                        outcome: "You build a career. Send money. Hire two local engineers from afar. But the microgrid project stalls without your daily presence. Five villages lose connection within a year. The dream doesn't travel well.",
                        icon: "airplane.departure",
                        impactScore: 3
                    ),
                    StoryChoice(
                        text: "Decline Paris. Use their offer as leverage to negotiate a joint venture for local manufacturing.",
                        outcome: "The French company agrees to co-fund a solar panel manufacturing facility in Thiès. Within three years, it employs 140 people and makes Senegal a solar exporter. The offer becomes the foundation of an industry.",
                        icon: "building.2.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Negotiate a remote advisory role. Stay home, but connect to global networks.",
                        outcome: "The hybrid arrangement works better than anyone expected. You train 12 engineers, write a replicable playbook, and the model spreads to Nigeria, Ghana, and Burkina Faso within 18 months.",
                        icon: "network",
                        impactScore: 9
                    )
                ]
            )
        ]
    )
}

// MARK: - Mei Lin's Story (Ocean Pollution)

private func meiLinStory() -> StoryContent {
    StoryContent(
        title: "What the Water Remembers",
        scenes: [
            StoryScene(
                narrative: "The lab smells like brine and ethanol. It's 11:30 PM in Shanghai. Mei Lin has mapped 847 microplastic sample points along the Yangtze estuary over the past six months. The data confirms what the fishing families have been saying for years — the concentration has tripled since 2019.\n\nHer professor wants her to soften the conclusions before publication. 'The university has a funding relationship with the polymer consortium,' he explains, not unkindly.",
                choices: [
                    StoryChoice(
                        text: "Revise the paper as requested. Stay in the program, get published, fight later.",
                        outcome: "The paper is published in a mid-tier journal. The industry uses the softened language in a government submission. The data you collected — the real data — helps no one.",
                        icon: "pencil.and.outline",
                        impactScore: 1
                    ),
                    StoryChoice(
                        text: "Publish raw data on an open-access preprint server before the official paper.",
                        outcome: "The preprint goes viral in the environmental science community. Nature Climate Change picks it up two weeks later. The professor is furious. The polymer consortium is furious. The data is out.",
                        icon: "network.badge.shield.half.filled",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Transfer to a different advisor. Delay by a semester but keep your integrity.",
                        outcome: "The new advisor has connections to the Ministry of Ecology. Your study becomes the basis for the first estuary microplastic monitoring regulation in Chinese environmental law.",
                        icon: "arrow.triangle.2.circlepath",
                        impactScore: 8
                    )
                ]
            ),
            StoryScene(
                narrative: "Six months later. Mei's data is cited in 40 papers. She's been invited to speak at a UN Ocean Conference in Nairobi. On the flight, she reads about a startup that claims it can remove ocean plastic at scale — but their technology requires enormous energy and creates toxic byproducts. They have 50 million dollars in funding and a TED talk.\n\nAt the conference, they'll present right before her.",
                choices: [
                    StoryChoice(
                        text: "Stay quiet. Let your data speak. Don't get into public conflicts.",
                        outcome: "The startup gets the headline. Your rigorous science gets a footnote. Three months later, their pilot project in the Pacific causes a localized ocean acidification event. The footnote becomes the warning nobody heeded.",
                        icon: "mouth.fill",
                        impactScore: 2
                    ),
                    StoryChoice(
                        text: "Request a joint Q&A. Ask specific questions about energy inputs and byproducts in public.",
                        outcome: "The CEO stumbles on the questions. Two venture capitalists in the room quietly withdraw their planned follow-on funding. The startup pivots to a less harmful method six weeks later — because you asked the questions out loud.",
                        icon: "questionmark.bubble.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Co-author a rapid response brief with two other scientists before the conference.",
                        outcome: "The brief circulates before the conference opens. Three journalists have read it before the startup takes the stage. The resulting coverage is more balanced. Science holds its ground.",
                        icon: "doc.on.doc.fill",
                        impactScore: 9
                    )
                ]
            ),
            StoryScene(
                narrative: "Mei Lin is 22 now. She's been offered a PhD position at MIT, a research grant in Singapore, and a position at a new Chinese government environmental data agency. Her hometown, Zhoushan, just announced plans to expand its container port — directly over the estuary she's spent three years documenting.",
                choices: [
                    StoryChoice(
                        text: "Accept MIT. Build an international career. The estuary will outlast the port.",
                        outcome: "Five years later, you publish the most comprehensive ocean microplastic atlas ever created, using AI trained on your Zhoushan data. It changes global environmental impact assessment standards. The estuary is partially protected by your work — from 6,000 miles away.",
                        icon: "graduationcap.fill",
                        impactScore: 7
                    ),
                    StoryChoice(
                        text: "Take the government position. Fight from inside the system.",
                        outcome: "Inside the agency, you discover three other estuaries under threat. You build a monitoring network. You delay the Zhoushan port by 18 months. The redesigned port leaves the estuary's core ecosystem intact. Slow, grinding, essential work.",
                        icon: "building.columns.fill",
                        impactScore: 9
                    ),
                    StoryChoice(
                        text: "Start a citizen science network — train the fishing families to be the data collectors.",
                        outcome: "Within two years, 3,200 fishers across the Yangtze delta are collecting microplastic data on mobile phones. The dataset is the largest of its kind in the world. No government can ignore it. No university owns it. It belongs to the water.",
                        icon: "person.3.sequence.fill",
                        impactScore: 10
                    )
                ]
            )
        ]
    )
}

// MARK: - Carlos Story (Deforestation)

private func carlosStory() -> StoryContent {
    StoryContent(
        title: "The Forest That Breathes",
        scenes: [
            StoryScene(
                narrative: "Carlos stands at the edge of what was, until three months ago, primary rainforest. The stumps are still weeping sap. A logging road cuts through his community's territory — unpermitted, unannounced, financed by a company registered in Panama.\n\nHe has 72 hours before the next cutting crew arrives. His community is divided. Some want to blockade. Some fear retaliation. Some have already taken payments from the company.",
                choices: [
                    StoryChoice(
                        text: "Organize the blockade. Physical presence is the only language they understand.",
                        outcome: "Forty community members hold the road for 11 days. The company brings in private security. Two people are injured. The blockade holds. International media arrives on day 9. The permits are frozen pending investigation.",
                        icon: "figure.stand.line.dotted.figure.stand",
                        impactScore: 8
                    ),
                    StoryChoice(
                        text: "Use the community's GPS mapping project to file an emergency territorial injunction.",
                        outcome: "The injunction takes 48 hours. The logging stops while courts deliberate. Three months later, the community's ancestral territory map — built over 10 years — becomes legally recognized for the first time. The road is ordered removed.",
                        icon: "map.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Meet with the community members who took payments. Understand before you condemn.",
                        outcome: "You learn the company specifically targeted the most economically vulnerable. You restructure the community's forest conservation payments — the carbon credit revenue — to reach those families directly. The company loses its internal informants.",
                        icon: "person.2.fill",
                        impactScore: 9
                    )
                ]
            ),
            StoryScene(
                narrative: "The forest survives — for now. A European carbon credit broker contacts Carlos. They want to buy the rights to 50,000 tons of CO₂ sequestration annually from his community's territory. The money would transform the community. But the contract has a clause: any future land use decisions must be approved by the broker's committee.",
                choices: [
                    StoryChoice(
                        text: "Sign the contract. The money can fund education, healthcare, and defense of the land.",
                        outcome: "The contract funds a school and clinic. Then a mining company approaches the broker's committee about a 'compatible' extraction project. Your community's approval was bypassed. A different clause gives the broker that right. You traded sovereignty for funding.",
                        icon: "signature",
                        impactScore: 2
                    ),
                    StoryChoice(
                        text: "Counter-propose: revenue sharing yes, governance clause removed entirely.",
                        outcome: "The broker walks away. A direct-trade indigenous carbon market you helped build connects your community to buyers who accept your terms. It takes 18 months longer. The terms are yours.",
                        icon: "arrow.left.arrow.right.circle.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Involve the Amazon Indigenous Peoples' Coordination Network before signing anything.",
                        outcome: "The network's legal team finds four clauses that have stripped sovereignty from other communities. Armed with precedent, you negotiate a contract that becomes a model for indigenous carbon rights across South America.",
                        icon: "network",
                        impactScore: 10
                    )
                ]
            )
        ]
    )
}

// MARK: - Fatima's Story (Inequality/Education)

private func fatimaStory() -> StoryContent {
    StoryContent(
        title: "A Tent is Not a Ceiling",
        scenes: [
            StoryScene(
                narrative: "Fatima's classroom is a UNHCR tent that floods in the winter. She has 60 students, two boxes of pencils, and no textbooks. What she does have: a solar-charged tablet, a list of 60 birthdays she's memorized, and the conviction that the children's futures are larger than the camp.\n\nToday, she learns the camp is being reduced. Her students — some of whom have been here for 8 years — may be dispersed to three different locations.",
                choices: [
                    StoryChoice(
                        text: "Fight the dispersal. Document each child's educational progress and present it to UNHCR.",
                        outcome: "The documentation takes seven nights. The progress reports for 60 children, translated into three languages, land on the desk of a UNHCR regional director. The dispersal is suspended. The school stays intact.",
                        icon: "doc.text.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Accept it and focus on giving each child the best possible resources before they leave.",
                        outcome: "You prepare personalized learning kits for each child. Many families lose them during the move. Three children never re-enroll anywhere. The ones who do carry something with them that is harder to lose.",
                        icon: "gift.fill",
                        impactScore: 5
                    ),
                    StoryChoice(
                        text: "Contact a refugee education NGO to take over the program and give it institutional protection.",
                        outcome: "The NGO formalizes the school. Adds three more teachers. The tent becomes a permanent structure within a year. You become director of education for the whole camp.",
                        icon: "building.columns.fill",
                        impactScore: 9
                    )
                ]
            )
        ]
    )
}

// MARK: - James's Story (Poverty/Urban Food)

private func jamesStory() -> StoryContent {
    StoryContent(
        title: "Roots in Concrete",
        scenes: [
            StoryScene(
                narrative: "James stands in what was an abandoned lot in the Surulere district of Lagos. Now it grows enough vegetables to feed 500 families weekly. He built it with 12 neighbors and a YouTube tutorial on raised-bed cultivation.\n\nA real estate developer has just bought the adjacent three lots. He wants the food forest gone. He's offered to relocate it — to a lot 14 km away, inaccessible by transit. This is effectively destruction.",
                choices: [
                    StoryChoice(
                        text: "Negotiate. Ask for a ground-floor community garden in the new development.",
                        outcome: "After eight weeks of talks, the developer agrees to a 400m² integrated garden in the building's ground floor. It's smaller, but it's permanent. The families who cook from it become the building's most loyal neighbors.",
                        icon: "arrow.left.arrow.right.circle.fill",
                        impactScore: 8
                    ),
                    StoryChoice(
                        text: "Mobilize the 500 families who depend on the garden. Numbers are leverage.",
                        outcome: "The community shows up. All 500. Photos of 500 people standing in a vegetable garden in Lagos make international headlines. The developer quietly abandons the eviction plan and pivots to claiming he 'supports urban agriculture.'",
                        icon: "person.3.sequence.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Accept the relocation. The movement matters more than any single location.",
                        outcome: "The new location is hard to reach. Attendance drops by 70%. The original community loses its green space and its meeting point. Sometimes the right fight is the one in front of you.",
                        icon: "arrow.uturn.right.circle.fill",
                        impactScore: 2
                    )
                ]
            )
        ]
    )
}

// MARK: - Hana's Story (Isolation)

private func hanaStory() -> StoryContent {
    StoryContent(
        title: "The Space Between Words",
        scenes: [
            StoryScene(
                narrative: "Hana Nakamura retired three years ago and has not had a conversation longer than ninety seconds since. Not from her neighbors. Not from her building's automated food delivery. Not from the care-app on her phone.\n\nShe has decided to build a community room — in her own building's unused storage space. The building management has said no twice. She has written four letters. She is 72 years old, and she has more patience than the building has forms.",
                choices: [
                    StoryChoice(
                        text: "Appeal to the building's legal obligation to provide community space.",
                        outcome: "You spend six weeks researching Tokyo's community space ordinances. Your fifth letter cites three specific codes. The management approves a six-month trial. The community room opens on a Tuesday. By Thursday, it is never empty.",
                        icon: "book.fill",
                        impactScore: 9
                    ),
                    StoryChoice(
                        text: "Ask 10 neighbors to co-sign a petition. Start with the ones you know least.",
                        outcome: "Collecting signatures requires you to knock on 22 doors. Twelve people invite you in. You realize the building is full of people who have been waiting for someone to knock. The petition becomes less important than the knocking.",
                        icon: "hand.tap.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Start without permission. Use the lobby. See what happens.",
                        outcome: "You set up a small table with tea in the lobby every Monday morning. Management asks you to stop. You ask them to come have tea and explain why. The manager stays for an hour. The table moves upstairs — into the storage room.",
                        icon: "cup.and.saucer.fill",
                        impactScore: 8
                    )
                ]
            )
        ]
    )
}
