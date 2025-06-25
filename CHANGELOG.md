# 📜 Changelog

All notable changes to **Ear Trainer** will be documented in this file using [Semantic Versioning](https://semver.org/).

---
## [0.1.4] - 2025-06-25

### Added

- PlaybackSettings model to encapsulate playback configuration
- `setNote(_:)` method in `NoteEngine` for runtime note switching
- `NoteGuessingViewModel` for isolated guess management
- Detailed inline code documentation across major components

### Changed

- Project renamed from "eartrainer" to "InTune Alarm Clock"
- Split `NoteViewModel` into `NoteSettingsViewModel`, `NoteGameViewModel`, and `NoteGuessingViewModel`
- `NotePlayer` updated to reuse `NoteEngine` via `setNote(_:)`
- Playback buttons now visually reflect guess accuracy

### Fixed

- Prevented SoundFont crash fallback in sampler mode
- Corrected octave bounds synchronization in `SettingsView`
- Improved note validity checking using expanded `isValid`
- Optimized sharps filtering by reusing note name arrays
  
## [0.1.1] - 2025-06-23

### Added
- SoundFont picker in SettingsView
- Dynamic loading of `.sf2` files from app bundle
- Parameterized sampler initialization in NoteEngine

### Changed
- Updated internal documentation/comment formatting for consistency
- Moved SoundFont scan utility to NoteEngine

### Fixed
- Defaulted to sine fallback when SoundFont fails to load

## [v0.1.0] – 2025-06-16
### Added
- Initial working build of Ear Trainer
- Random note generation and playback using `AVAudioUnitSampler`
- Custom SoundFont (.sf2) loading with melodic bank support
- Basic SwiftUI UI with note display and playback button
- `NoteEngine`, `NotePlayer`, and view model structure

### Known Limitations
- No error feedback or training scoring
- No audio settings UI
- Single SoundFont hardcoded

---

## [Unreleased]
### Planned
- Note recognition UI and score tracking
- SoundFont picker and settings screen
- iCloud settings sync
- More instrument support
- Better unit test coverage

