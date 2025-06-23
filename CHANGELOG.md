# 📜 Changelog

All notable changes to **Ear Trainer** will be documented in this file using [Semantic Versioning](https://semver.org/).

---
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

