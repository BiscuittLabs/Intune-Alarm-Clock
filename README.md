# Ear Trainer

This project is an iOS application for ear training built with Swift and AVFoundation.

## SoundFont Usage

To use the sampler playback mode you must provide a SoundFont file. Place your `.sf2` file in `eartrainer/SoundFonts/` and ensure it is added to the Xcode project with **Copy items if needed** enabled and **Target Membership** set for the app target. The runtime looks for the file `Casio_Privia_PX-160.sf2` inside the `SoundFonts` folder of the app bundle.

If the folder or file is not included in the bundle you will see an error similar to:

```
Failed to list SoundFonts folder: Error Domain=NSCocoaErrorDomain Code=260 ...
SoundFont file not found.
```

After adding the file to the project and rebuilding, the sampler mode will load the instrument correctly.
