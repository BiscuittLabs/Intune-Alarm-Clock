# 🎷 Ear Trainer

A SwiftUI app for practicing pitch recognition and note training using custom SoundFonts. Designed for musicians, students, and anyone wanting to sharpen their ear with beautiful tones instead of basic sine waves.

---

## 🧠 Overview

**Ear Trainer** plays a randomly selected musical note and challenges the user to identify it by ear. The app uses `AVAudioUnitSampler` to load realistic instrument samples from SoundFont files (`.sf2`).

---

## 🚀 Features

- 🎵 Random note playback (with adjustable octave and frequency)
- 🧠 Note identification training
- 🎺 Supports custom SoundFont files (`.sf2`)
- ⚙️ Configurable playback engine (sampler or sine wave fallback)
- 💡 SwiftUI-based user interface

---

## 💠 Requirements

- Xcode 15+
- iOS 16+
- Swift 5.9+
- `.sf2` SoundFont files (e.g. custom piano, synths, etc.)

---

## 🧹 Architecture

This project is organized into MVVM-style modules:

```
EarTrainer/
🔻— Models/           # Note logic, sampler engine, etc.
🔻— ViewModels/       # State + logic for note UI
🔻— Views/            # SwiftUI views
🔻— SoundFonts/       # Your .sf2 files (folder reference!)
```

- Audio powered by `AVAudioEngine` + `AVAudioUnitSampler`
- UI built with SwiftUI + Combine
- Code is modular and testable

---

## 🎺 SoundFont Setup

To add a custom `.sf2` SoundFont:

1. Place the `.sf2` file inside the `SoundFonts` folder.
2. In Xcode, drag the folder into the project.
3. **Important**: When prompted, select **"Create folder references"** (not "Create groups").
4. Ensure the file is checked under **Target Membership**.
5. In code, load it like this:

```swift
try sampler.loadSoundBankInstrument(
  at: soundbankURL,
  program: 0,
  bankMSB: 0x79, // melodic
  bankLSB: 0x00
)
```

---

## 🏁 Getting Started

1. Clone the repo:

   ```bash
   git clone https://github.com/yourusername/eartrainer.git
   cd eartrainer
   ```

2. Open the project in Xcode:

   ```bash
   open EarTrainer.xcodeproj
   ```

3. Add your `.sf2` files to the `SoundFonts/` folder.

4. Run the app on the iOS Simulator or a real device.

---

## 🧚️‍♂️ Testing

- Use the built-in `eartrainerTests` and `eartrainerUITests` folders to add your unit/UI tests.
- Test the audio system by simulating different note generations and playback modes.

---

## 📜 License

MIT License. See `LICENSE.md` for details.

---

## 🙌 Acknowledgments

- Apple Core Audio team for `AVAudioUnitSampler`
- [Polyphone SoundFont Editor](https://www.polyphone-soundfonts.com/) for inspecting `.sf2` files
- CodeAcademy for closure-driven functional programming inspiration

---

💠 Built with love and Swift.

