import Foundation

// MARK: - Story Data Structures

struct StoryContent {
    let title: String
    let scenes: [StoryScene]

    static func story(for character: Character) -> StoryContent {
        switch character.challenge {
        case .climate:       return amaraStory()
        case .pollution:     return meiLinStory()
        case .deforestation: return carlosStory()
        case .inequality:    return fatimaStory()
        case .poverty:       return jamesStory()
        case .isolation:     return hanaStory()
        case .futureAnxiety: return astridStory()
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
            ),
            StoryScene(
                narrative: "The contract was rewritten on your terms. The forest has a legal shield for the first time in its history.\n\nBut something else is happening in the community. A younger man, Rodrigo — 22 years old, Carlos's nephew — is building a following among the younger generation. He has a phone, a YouTube channel, and 40,000 subscribers who watch him hunt and fish in the forest. He is proud of the forest. He loves it.\n\nBut Rodrigo has been in conversations with an ecotourism company from São Paulo. They want to bring 200 visitors a month into the community's territory. Jobs. Income. Visibility.\n\nRodrigo asks Carlos: 'Why do you only talk to lawyers and governments? The world is watching us online. That is also power.'\n\nCarlos is not sure Rodrigo is wrong.",
                choices: [
                    StoryChoice(
                        text: "Embrace Rodrigo's platform. Go on camera with him. Tell the forest's story to his 40,000 viewers.",
                        outcome: "The video gets two million views. The logging company that has been circling your territory for three years sees it. Their investors — a German pension fund with an ESG mandate — quietly withdraw. You never know this happened. But the logging company's project is canceled. Rodrigo never knows either. But he keeps making videos.",
                        icon: "video.fill",
                        impactScore: 9
                    ),
                    StoryChoice(
                        text: "Help Rodrigo lead the ecotourism negotiation himself — with your guidance on terms.",
                        outcome: "Rodrigo negotiates a visitor cap of 40 per month, community-led guides only, no external ownership. The income is modest but real. More importantly, Rodrigo has learned what negotiating on your own terms looks like. He will do it for the rest of his life.",
                        icon: "person.2.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Warn Rodrigo about the risks: commodifying the forest changes how people see it.",
                        outcome: "Rodrigo disagrees. You disagree respectfully. The conversation between you lasts three years. The community holds a formal council. The decision — a limited ecotourism pilot with a community veto — is made by the people who will live with it. As it should be.",
                        icon: "bubble.left.and.bubble.right.fill",
                        impactScore: 8
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
            ),
            StoryScene(
                narrative: "The school survived. Eight months later, Fatima faces a different kind of wall.\n\nA 14-year-old girl named Nour — one of her best students, the one who reads in three languages and corrects Fatima's French — has been told by her father that she will not continue school next year. There are chores. There is a younger brother who needs attending. There is the marriage her uncle has begun to discuss.\n\nFatima is holding Nour's last essay. It is about the mathematician Emmy Noether. Nour has underlined: 'She was not permitted to lecture under her own name. So she lectured anyway.'",
                choices: [
                    StoryChoice(
                        text: "Speak to Nour's father directly. Bring proof of her academic achievements.",
                        outcome: "He listens for eleven minutes. Then he says: 'I know she is brilliant. That is not the problem.' You understand, finally, that the conversation is not about Nour's ability. You go home and think for a long time. You come back the next day with a different question.",
                        icon: "person.2.fill",
                        impactScore: 7
                    ),
                    StoryChoice(
                        text: "Connect the family to a women's education stipend program that provides financial support.",
                        outcome: "The stipend removes the economic argument. Nour returns. Two years later, she wins a regional scholarship to university in Amman. She studies mathematics. Her first paper cites Emmy Noether.",
                        icon: "banknote.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Give Nour the essay back. Tell her she already knows what to do. Trust her.",
                        outcome: "Nour reads the underlined line again. She speaks to her father herself, for three hours, in the language he understands best — the language of her future providing for the family. He listens to her in a way he would not have listened to you. She stays in school.",
                        icon: "star.fill",
                        impactScore: 9
                    )
                ]
            ),
            StoryScene(
                narrative: "Nour is at university. Fatima is still in the camp — by choice. She has been offered a position at an international education consultancy in Geneva. Real salary. Real office. Ability to influence policy for thousands of schools like the tent she built.\n\nBut today, a new family arrived. Syrian. A mother and three children. The youngest, a boy of six named Yousef, has not spoken since they crossed the border four months ago. He sits in the corner of Fatima's tent and watches everything with enormous, quiet eyes.\n\nThe Geneva flight is in five days.",
                choices: [
                    StoryChoice(
                        text: "Accept Geneva. Train a replacement and leave the strongest possible foundation.",
                        outcome: "You spend five days building binders, training two teachers, writing lesson plans for the next year. You board the plane. At Geneva, your first policy brief recommends mandatory trauma-informed pedagogy in all UNHCR schools. It is adopted in 14 countries. Yousef's school, two years later, has a trained trauma counselor. You never meet him. But he learns to speak again.",
                        icon: "airplane.departure",
                        impactScore: 8
                    ),
                    StoryChoice(
                        text: "Delay Geneva by six months. Yousef needs continuity right now, and so does the school.",
                        outcome: "By month three, Yousef draws a picture and pushes it across the table to you. It is a house with a sun. By month five, he says your name. You take the Geneva position in autumn, but the six months change how you understand the word 'policy' for the rest of your career.",
                        icon: "clock.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Turn Geneva down. This is the work. This tent, this boy, this morning.",
                        outcome: "You stay. Geneva finds someone else — someone who has never sat on a dirt floor. Yousef learns to speak. You train twelve more teachers over the next four years. You never write a policy brief. But you build something that outlasts the camp.",
                        icon: "heart.fill",
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
            ),
            StoryScene(
                narrative: "The garden survived. James is now known across Lagos.\n\nA government official has offered him a stipend and a position: 'Urban Agriculture Coordinator' — a new title, created for him. The role would let him push the model city-wide. Ten more gardens, official support, a budget.\n\nBut last week, James discovered that the same official's construction company received permits to demolish three community gardens in Ikeja last year. The offer may be genuine. Or it may be a way to keep James close enough to manage.",
                choices: [
                    StoryChoice(
                        text: "Accept. Work from inside. Demand the Ikeja gardens be part of your mandate.",
                        outcome: "The official agrees to include Ikeja in the restoration plan — in writing. You take the position. Six months later, the three gardens in Ikeja are rebuilt. Two of your ten new sites are quietly blocked. The math still works in humanity's favor.",
                        icon: "building.columns.fill",
                        impactScore: 8
                    ),
                    StoryChoice(
                        text: "Decline. Investigate the Ikeja demolitions first. Publish what you find.",
                        outcome: "The investigation takes three weeks. What you find is published in a Lagos newspaper. The official's construction permits are frozen. He withdraws the offer. You are on your own again — but the story changes who controls the approval process.",
                        icon: "magnifyingglass",
                        impactScore: 9
                    ),
                    StoryChoice(
                        text: "Counter-propose: a community-led board controls the program, not the official.",
                        outcome: "He says no. You ask the 500 families to sign a governance charter instead, establishing the garden as a community land trust — a legal structure the city cannot easily undo. It takes six months longer. Nobody can co-opt it.",
                        icon: "person.3.fill",
                        impactScore: 10
                    )
                ]
            ),
            StoryScene(
                narrative: "Three years in. James has nine gardens, 4,200 families, and a waiting list for the next site.\n\nHe receives a message from a foundation in Amsterdam. They want to fund James to replicate the model in Nairobi, Dhaka, and São Paulo. Full budget. Four years. His name on the methodology.\n\nHis youngest son, Emeka, is seven. Emeka has grown up watching his father dig. Last Tuesday, unprompted, Emeka planted a seed in a cracked plastic cup and placed it on the windowsill. He checks it every morning before school.\n\nJames looks at the message from Amsterdam. He looks at the cup on the windowsill.",
                choices: [
                    StoryChoice(
                        text: "Accept Amsterdam. Emeka will understand, when he's older.",
                        outcome: "The model lands in three cities. Thousands of families eat because James went. Emeka's cup grows a small tomato plant. His mother photographs it and sends it to James in Nairobi. James keeps the photo as his phone wallpaper for the rest of his life.",
                        icon: "globe",
                        impactScore: 9
                    ),
                    StoryChoice(
                        text: "Accept, but bring Emeka for the first year in Nairobi.",
                        outcome: "Emeka attends a Nairobi school for one year. He speaks three languages by the end. He digs in the first Nairobi garden with his father. Fifteen years later, Emeka will start his own urban food organization — and he will name it after the cup on the windowsill.",
                        icon: "person.2.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Decline Amsterdam. Train someone else to carry the methodology.",
                        outcome: "You write the playbook. Eighty-three pages. Everything you know. You send it to the Amsterdam foundation and they fund three other people to carry it forward. You stay in Lagos. Emeka's tomato plant fills the whole windowsill by summer.",
                        icon: "doc.text.fill",
                        impactScore: 8
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
            ),
            StoryScene(
                narrative: "The community room opened. It has twelve chairs, a kettle, and a rule Hana made up herself: no phones on the table.\n\nThere is a man named Tanaka-san on the fourth floor. He is 81. He comes every Monday and sits in the same corner chair and does not speak. He has come for eleven weeks in a row. Hana has learned that his wife died last year and that he has a son in Osaka who visits twice a year and calls every Sunday for exactly seven minutes.\n\nToday, Tanaka-san brought something. He set it on the table and sat down. It is a small tin box. He has not explained it. He is looking at his hands.",
                choices: [
                    StoryChoice(
                        text: "Say nothing. Pour him tea. Let the silence hold him.",
                        outcome: "He stays for two and a half hours. He never explains the tin box. Neither do you. When he leaves, he says: 'Same time next week.' It is the first complete sentence you have heard him say. You don't know what is in the box. Some things aren't yours to know.",
                        icon: "cup.and.saucer.fill",
                        impactScore: 9
                    ),
                    StoryChoice(
                        text: "Ask gently: 'Is that something you'd like to share with us?'",
                        outcome: "He opens the box. Inside are photographs — his wife, their honeymoon in Kyoto, 1971. He speaks for forty minutes. Three other neighbors stay to listen. At the end, he closes the box and says: 'I had forgotten I was still a person with a story.' You realize you have built something that cannot be measured.",
                        icon: "photo.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Invite him to be a co-host. Give him a role. Responsibility creates connection.",
                        outcome: "He becomes the one who makes tea. A small thing. But he arrives twenty minutes early every Monday now. He has started leaving the door propped open before the others arrive — a signal, in the language of small gestures, that someone is already waiting.",
                        icon: "person.badge.plus",
                        impactScore: 9
                    )
                ]
            ),
            StoryScene(
                narrative: "The community room is two years old. Hana is 74.\n\nA journalist from NHK wants to do a feature. 'Tackling Japan's loneliness epidemic from the inside of a storage room.' The story would reach millions. It might inspire other buildings, other cities, other Hanas.\n\nBut Tanaka-san pulls Hana aside before the interview. He says, quietly: 'I come here because it is not on television. Because no one is watching. If you put this on television, I will not come back.'\n\nHe is not asking her not to do it. He is telling her something true.",
                choices: [
                    StoryChoice(
                        text: "Do the interview. The larger impact is worth the cost.",
                        outcome: "The NHK segment airs. 847 people contact NHK asking how to start a community room in their building. A national initiative follows. Tanaka-san doesn't come back for three months. Then, quietly, he does. He sits in the corner. He doesn't say anything. But he comes.",
                        icon: "tv.fill",
                        impactScore: 7
                    ),
                    StoryChoice(
                        text: "Decline the interview. Ask the journalist to tell a different story instead — about the policy gap.",
                        outcome: "The journalist writes an opinion piece about why Japanese zoning law makes community space nearly impossible to create. It reaches the same audience. Three city council members read it. A pilot program begins. Tanaka-san never knows. The room is never on television. It stays exactly what it is.",
                        icon: "newspaper.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Ask the room — everyone in it — what they want.",
                        outcome: "You hold a vote. Twelve people. Six say yes, five say no, Tanaka-san abstains. You decline the interview. The journalist is frustrated. You tell them: 'This place only works because it belongs to the people in it.' The journalist quotes you anyway. It's enough.",
                        icon: "person.3.fill",
                        impactScore: 9
                    )
                ]
            )
        ]
    )
}


// MARK: - Astrid's Story (Future Anxiety)

private func astridStory() -> StoryContent {
    StoryContent(
        title: "Still Here",
        scenes: [
            StoryScene(
                narrative: "It is 2:47 AM in Malmö, Sweden. Astrid is sixteen years old and she has not slept well in two years.\n\nShe knows the difference between the Greenland Ice Sheet and the West Antarctic Ice Sheet. She knows what 'irreversible' means in a scientific paper. She learned these things in school, because she asked.\n\nTonight she opened her laptop to study for a biology exam. Instead, she has read seventeen articles about ocean acidification. The Baltic Sea outside her window is 2.1°C warmer than when her grandmother was born.\n\nShe is not panicking. She is past panic. She is in the still, cold place after panic.\n\nShe closes the laptop. Opens it again. Closes it.\n\nHer phone lights up. Her friend Sara: 'Still awake?' Then: 'same lol'",
                choices: [
                    StoryChoice(
                        text: "Don't reply. You can't explain this to Sara right now. Maybe to anyone.",
                        outcome: "You lie in the dark for two more hours. You think about the exam. You think about the ice. You think about how it is possible to know something and still do the next ordinary thing. You don't find the answer. But somehow, by 5 AM, you fall asleep. You wake up and go to school. You take the exam. You get an A. You don't know what to make of that.",
                        icon: "moon.fill",
                        impactScore: 4
                    ),
                    StoryChoice(
                        text: "Reply. Tell Sara exactly what you're reading and why you can't stop.",
                        outcome: "Sara doesn't understand all of it. But she says: 'that sounds exhausting. do you want to call?' You talk until 4 AM. She doesn't know about tipping points. You explain them, slowly. By the end she says: 'okay that is genuinely terrifying. but I'm glad you told me.' You feel, for the first time in weeks, like the weight is shared. Shared weight is still weight. But it moves differently.",
                        icon: "message.fill",
                        impactScore: 8
                    ),
                    StoryChoice(
                        text: "Close the laptop. Go to your window. Look at the water.",
                        outcome: "The Baltic is dark. You can't see it change. You can't see the 2.1 degrees. But you know it's there. You stand at the window for a long time. Then something shifts — not hope exactly. More like: this is real, and I am real, and both things can be true at the same time. You go back to bed. You sleep.",
                        icon: "water.waves",
                        impactScore: 7
                    )
                ]
            ),
            StoryScene(
                narrative: "Three weeks later. Biology class.\n\nThe teacher, Mr. Eriksson, is 58. He has been teaching biology for 29 years. He is explaining photosynthesis. He is good at it.\n\nAstrid raises her hand. She asks whether the class can discuss what ocean acidification does to photosynthesis in marine phytoplankton, since phytoplankton produces half the world's oxygen.\n\nMr. Eriksson says: 'That's a bit beyond the curriculum, Astrid.'\n\nThe class moves on.\n\nAfter class, a boy named Felix catches up with her in the hall. He says: 'I looked it up. You're right. It's actually really bad.' Then he says: 'Why don't you start a club or something?'\n\nAstrid has never started anything.",
                choices: [
                    StoryChoice(
                        text: "Say no. You're exhausted. A club won't change what's happening.",
                        outcome: "You go home. You study. A month passes. Felix starts the club himself — badly, without the knowledge you have. It meets three times and falls apart. One of the six students who showed up, a girl named Leila, keeps looking things up on her own. Astrid and Leila meet again later, in a different context, and something begins.",
                        icon: "xmark.circle.fill",
                        impactScore: 3
                    ),
                    StoryChoice(
                        text: "Say yes — but only if it's about real science, not just feelings.",
                        outcome: "The club starts with seven people, including Felix and Leila. You run it like a seminar. No slogans. Only papers, data, maps. Twelve weeks in, a local newspaper hears about it and runs a small piece. Forty more students ask to join. The curriculum doesn't change. But something else does: in that room, every Thursday, nobody tells you this is 'beyond the curriculum.'",
                        icon: "person.3.fill",
                        impactScore: 9
                    ),
                    StoryChoice(
                        text: "Ask to speak to Mr. Eriksson after school first. Tell him what you know.",
                        outcome: "He listens for twenty minutes. He says he hadn't updated his own reading in four years. He doesn't apologize. But the next week, he adds a section to the class. It's small. Two pages. But he wrote them himself, the night before, from the papers you recommended. He's been teaching for 29 years. He still learned something. That matters.",
                        icon: "person.fill",
                        impactScore: 10
                    )
                ]
            ),
            StoryScene(
                narrative: "Astrid is seventeen now.\n\nShe has been invited to speak at a youth climate conference in Stockholm. One hundred students. She will have eight minutes.\n\nShe sits at her desk with a blank document. She has written and deleted four speeches. The first was full of statistics — she knows all of them by heart. The second was about hope — it felt false. The third was angry — it felt true but incomplete. The fourth was about the Baltic Sea outside her window. She deleted that one too.\n\nIt's 11 PM. The conference is tomorrow.\n\nShe thinks about something her grandmother Linda told her once, on the phone, when Astrid said she didn't know how to keep going.\n\nLinda had said: 'I don't either. I just do the next thing. And then the next one.'\n\nAstrid opens a new document.\n\nShe starts typing.",
                choices: [
                    StoryChoice(
                        text: "Write the speech about what it actually feels like. 2:47 AM. The laptop. The water. The weight of knowing.",
                        outcome: "You give that speech. You don't use a single statistic. You describe the feeling of knowing something that changes how you see everything, and still having to go to school, still taking the exam, still getting the A, still not knowing what to make of it. When you finish, the room is quiet for a long moment. Then a girl in the second row starts crying. Then several others. Then applause. After, twelve people come up to you individually and say: 'I thought I was the only one who felt like that.'",
                        icon: "heart.fill",
                        impactScore: 10
                    ),
                    StoryChoice(
                        text: "Write about the club. About Felix. About what happened when knowledge was shared instead of carried alone.",
                        outcome: "It's a practical speech. You describe what works: small groups, real data, one Thursday at a time. Three teachers in the audience take notes. Two of them start similar programs in their schools within the year. You never meet their students. But the students exist.",
                        icon: "person.3.sequence.fill",
                        impactScore: 9
                    ),
                    StoryChoice(
                        text: "Write honestly that you don't know how to end a speech about this. And deliver that.",
                        outcome: "'I have eight minutes and I've written four speeches and deleted all of them,' you begin. 'So here is what I actually know: the Baltic Sea is 2.1 degrees warmer than when my grandmother was born. I love the Baltic Sea. I don't know how to end this speech, because I don't know how to end what's happening. But I came here. You came here. Maybe that's a kind of answer.' You sit down. It is the shortest speech of the day. It is the one people remember.",
                        icon: "text.bubble.fill",
                        impactScore: 10
                    )
                ]
            )
        ]
    )
}
