import Foundation
import AVFoundation
import SwiftUI

// MARK: - Sound Manager
// Manages ambient BGM per character/screen and UI sound effects.
// Audio files (.mp3/.aiff) are loaded from the app bundle.
// In the initial release, graceful fallback if files are missing.

enum BGMTrack: String {
    case mainMenu    = "bgm_main_menu"      // Ambient piano + ambient synth
    case worldMap    = "bgm_world_map"      // Soft orchestral, global feel
    case amara       = "bgm_amara"          // West African kora + gentle percussion
    case meiLin      = "bgm_mei_lin"        // Erhu-inspired melodic strings
    case carlos      = "bgm_carlos"         // Amazonian flute + rain sounds
    case fatima      = "bgm_fatima"         // Oud + ambient drone
    case james       = "bgm_james"          // Urban acoustic guitar + distant city
    case hana        = "bgm_hana"           // Sparse piano, minimalist
    case astrid      = "bgm_astrid"         // Nordic ambient, open water, quiet dread becoming resolve
    case completion  = "bgm_completion"     // Uplifting, full orchestral swell
}

enum SFXSound: String {
    case buttonTap      = "sfx_tap"
    case choiceSelect   = "sfx_choice"
    case pageTransition = "sfx_transition"
    case unlock         = "sfx_unlock"
    case completion     = "sfx_complete"
    case pinHover       = "sfx_pin_hover"
}

@MainActor
final class SoundManager: ObservableObject {
    static let shared = SoundManager()

    @Published var musicEnabled: Bool = true {
        didSet { handleMusicToggle() }
    }
    @Published var sfxEnabled: Bool = true
    @Published var musicVolume: Float = 0.45
    @Published var sfxVolume: Float = 0.7

    private var bgmPlayer: AVAudioPlayer?
    private var currentTrack: BGMTrack?
    private var fadeTimer: Timer?

    private init() {}

    // MARK: - BGM

    func play(_ track: BGMTrack, fadeIn: Bool = true) {
        guard musicEnabled else { return }
        guard track != currentTrack else { return }

        if bgmPlayer?.isPlaying == true {
            fadeOut { [weak self] in
                self?.startTrack(track, fadeIn: fadeIn)
            }
        } else {
            startTrack(track, fadeIn: fadeIn)
        }
    }

    func stopMusic(fadeOut: Bool = true) {
        guard bgmPlayer?.isPlaying == true else { return }
        if fadeOut {
            self.fadeOut(completion: nil)
        } else {
            bgmPlayer?.stop()
            currentTrack = nil
        }
    }

    private func startTrack(_ track: BGMTrack, fadeIn: Bool) {
        guard let url = Bundle.main.url(forResource: track.rawValue, withExtension: "mp3")
                ?? Bundle.main.url(forResource: track.rawValue, withExtension: "aiff") else {
            // No audio file found — silent operation in development
            currentTrack = track
            return
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            player.volume = fadeIn ? 0 : musicVolume
            player.prepareToPlay()
            player.play()
            bgmPlayer = player
            currentTrack = track

            if fadeIn {
                performFadeIn()
            }
        } catch {
            // Audio playback failure is non-fatal
        }
    }

    private func performFadeIn() {
        let targetVolume = musicVolume
        let steps = 30
        let interval = 1.2 / Double(steps)
        var step = 0

        fadeTimer?.invalidate()
        fadeTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self, let player = self.bgmPlayer else { timer.invalidate(); return }
            step += 1
            player.volume = targetVolume * Float(step) / Float(steps)
            if step >= steps {
                player.volume = targetVolume
                timer.invalidate()
            }
        }
    }

    private func fadeOut(completion: (() -> Void)?) {
        guard let player = bgmPlayer else { completion?(); return }
        let startVolume = player.volume
        let steps = 20
        let interval = 0.6 / Double(steps)
        var step = 0

        fadeTimer?.invalidate()
        fadeTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            step += 1
            player.volume = startVolume * (1.0 - Float(step) / Float(steps))
            if step >= steps {
                player.stop()
                self?.currentTrack = nil
                timer.invalidate()
                completion?()
            }
        }
    }

    private func handleMusicToggle() {
        if musicEnabled {
            if let track = currentTrack { startTrack(track, fadeIn: true) }
        } else {
            bgmPlayer?.stop()
        }
    }

    // MARK: - SFX

    func playSFX(_ sound: SFXSound) {
        guard sfxEnabled else { return }
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "aiff")
                ?? Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else { return }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.volume = sfxVolume
            player.play()
        } catch {}
    }

    // MARK: - Character BGM Mapping

    static func track(for character: Character) -> BGMTrack {
        switch character.challenge {
        case .climate:       return .amara
        case .pollution:     return .meiLin
        case .deforestation: return .carlos
        case .inequality:    return .fatima
        case .poverty:       return .james
        case .isolation:     return .hana
        case .futureAnxiety: return .astrid
        }
    }
}
