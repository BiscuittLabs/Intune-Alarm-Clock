# 🎵 Intune Alarm Clock (formerly Intune-Alarm-Clock)

A musical alarm app where you **must identify a note, chord, or melody** to turn off the alarm. Built to sharpen your pitch recognition, train perfect pitch, and start your day with focus.

---

## 📚 Overview

Instead of tapping "Snooze", this app only lets you dismiss the alarm by accurately naming the **musical sound** it plays. It’s like ear training meets morning motivation.

---

## 🚀 Features

- ⏰ **Musical Alarm** — Plays a random note, chord, or melody string
- 🌟 **Pitch Challenge** — You must guess correctly to silence it
- 🔄 **Progressive difficulty** — (future release)
- 🔊 **Custom SoundFonts** — Load your own `.sf2` instrument banks

---

## 💠 Requirements

- iOS 16+, Swift 5.9, Xcode 15+
- SoundFont files (`.sf2`) placed in a blue `SoundFonts/` folder reference
- iPhone or Simulator for testing audio

---

## 🧹 Project Structure

```
Intune-Alarm-Clock/
🔻— SoundFonts/      # .sf2 files (folder reference)
🔻— Models/          # Audio logic, pitch checks
🔻— Views/           # SwiftUI alarm UI
🔻— ViewModels/      # Alarm state & logic
🔻— Resources/       # Assets and voice prompts
```

---

## 🎺 SoundFont Support

To use custom instruments:

1. Add `.sf2` files into `SoundFonts/`
2. Drag the folder into Xcode as a **folder reference** (blue icon)
3. Ensure target membership is checked
4. Load them using `AVAudioUnitSampler`

---

## 🚀 Getting Started

1. Clone:

   ```bash
   git clone https://github.com/BiscuittLabs/Intune-Alarm-Clock.git
   cd Intune-Alarm-Clock
   ```

2. Open in Xcode:

   ```bash
   open Intune-Alarm-Clock.xcodeproj
   ```

3. Add your `.sf2` files into `SoundFonts/`

4. Build & Run on your iPhone or Simulator

---

## 🌟 Usage

- Set an alarm time
- At alarm time, hear a musical snippet
- Guess the pitch, chord, or melody
- Correct answer = dismiss; incorrect = try again

---

## 🧪 Development

- Work from `main` or use feature branches
- Follow developer workflow outlined in `git_workflow.md`
- Share issues / feature ideas via GitHub issues
- Use SoundFonts to change instruments and challenge types

---

## 📅 Roadmap

Planned enhancements in future releases:

- Multiple challenge types (chords, melodies, scales)
- Settings: difficulty, instrument choice, snooze policies
- Persistence & user stats tracking
- Notifications & iOS alarm integration

See `CHANGELOG.md` for version history.

---

## 🤝 Contributing

Contributions welcome! Please see `CONTRIBUTING.md` for bug reports, feature requests, and pull request guidelines.

---

## 📄 License

Licensed under MIT — see `LICENSE.md` for details.

