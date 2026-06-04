# TERRA — Legal Checklist
## Prepared by: Claire Beaumont, Legal Counsel
## Sprint 2 | 2026-06-04

---

## App Store Compliance

### Required Before Submission

- [ ] **Privacy Policy URL** — Even if no data is collected, Apple requires a URL.
  Draft: "TERRA does not collect, transmit, or store any personal data.
  Gameplay data is stored locally on your device using UserDefaults."
  Host at: `terraapp.world/privacy`

- [ ] **Age Rating** — Submit as **4+** (no violence, mature themes handled tastefully)
  Review App Store age rating questionnaire before submission.

- [ ] **EULA** — Use Apple's standard EULA unless modified terms needed.
  Recommendation: Standard EULA sufficient for v1.

- [ ] **Copyright Notice** — Confirm "© 2026 TERRA Studio" in About screen.
  If publishing as individual: use legal name, not studio name, for Apple Developer account.

### In-App References

- [ ] **Solar Sister** — Referenced as informational. Confirm text-only mention is acceptable.
  Action: Review their media/press guidelines. Most NGOs welcome text mentions.

- [ ] **Ocean Conservancy** — Same as above.

- [ ] **Amazon Watch** — Same as above. Note: Amazon Watch is politically sensitive
  (named entity in legal disputes). Confirm mention framing is factual, not endorsement.

- [x] **Real-world data** — Sources referenced as "real-world context."
  Data sourced from: UN, IPCC, WWF, World Bank. All public domain / open data. ✓

---

## Intellectual Property

### Original Content
- All story content (characters, narratives, choice text) is original.
- No real persons depicted or named. All characters are fictional.
- Character names reviewed: no conflict with known public figures.

### Assets
- System icons (SF Symbols): Licensed for use in Apple platform apps. ✓
- SwiftUI framework: Apple license. ✓
- Audio (when produced): Ensure work-for-hire agreement with composer.
  Draft contract template needed before BGM production begins.

### Trademark
- "TERRA" as a standalone mark: search recommended before App Store submission.
  (Multiple products use "TERRA" — confirm no conflict in games/apps category)
- Domain: `terraapp.world` — register before press announcement.

---

## Data & Privacy

TERRA collects **zero personal data** by design.

UserDefaults stores:
- Story progress (local only)
- Impact score (local only)
- Settings preferences (local only)

No network requests. No analytics. No crash reporting (v1).

**Privacy manifest** (required by Apple for all apps):
- File location: `TERRA/Sources/TERRA/Resources/PrivacyInfo.xcprivacy`
- Declare: No data types collected.
- Action: Create this file before submission.

---

## Ongoing Monitoring

- Monitor App Store review guidelines for changes (updated periodically by Apple)
- If "donate" or external payment CTA added in future: requires Apple review
- If educator pricing / volume licensing: separate App Store agreements required

---

## Risk Summary

| Risk | Level | Mitigation |
|------|-------|-----------|
| Organization name trademark | Low | Text mention only, no logo |
| "TERRA" trademark conflict | Medium | Trademark search before launch |
| Audio licensing | Medium | Work-for-hire contract template |
| App Store rejection | Low | Content is educational, no flags |
| Privacy policy missing | High | Draft and host before submission |

---

*Reviewed with Kai Nakamura (dev) and Hiro Matsumoto (marketing) in Sprint 2 meeting.*
*Next review: Before alpha submission to TestFlight.*
