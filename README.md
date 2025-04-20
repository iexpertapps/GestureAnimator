# GestureAnimator

**GestureAnimator** is a lightweight, declarative Swift package for creating gesture-driven animations in SwiftUI. It supports smooth, interruptible transitions such as zoom, drag, rotate, morph, and even custom path-based effects.

---

## ✨ Features

- 📐 Declarative API: `.gestureZoom(scale: $zoomLevel)`
- 🌀 Interruptible animations (e.g., drag → spring)
- 🧬 Real morphing transitions between shapes
- 🚀 Performance-optimized (native-level FPS)
- 🧪 Unit + FPS benchmarking support

---

## 📦 Installation

Add GestureAnimator via Swift Package Manager:

```swift
.package(url: "https://github.com/yourname/GestureAnimator.git", from: "1.0.0")
```

Then, in your target:

```swift
.target(name: "YourApp", dependencies: ["GestureAnimator"])
```

---

## 🚀 Usage

### Zoom Gesture
```swift
@State private var scale: CGFloat = 1.0

Image("photo")
    .gestureZoom(scale: $scale)
```

### Drag Gesture
```swift
@State private var offset: CGSize = .zero

RoundedRectangle(cornerRadius: 16)
    .gestureDrag(offset: $offset)
```

### Morph Gesture
```swift
@State private var morphProgress: CGFloat = 0.0

ShapeView()
    .gestureMorph(progress: $morphProgress, style: .roundedToCircle)
```

---

## 🧪 Performance

- Uses `os_signpost` + `TimelineView` to track real-time FPS
- Designed to match native SwiftUI animation performance
- Fully unit tested with gesture simulators

---

## 📂 Project Structure

```
Sources/GestureAnimator
├── Core
├── Effects
├── ViewModels
├── Utilities
```

---

## 📱 Demo App

Clone the repo and open `Examples/DemoApp` in Xcode. You can interactively test all gesture effects.

---

## 📄 License

MIT License

---

## 🙌 Contributing

Feel free to open issues or PRs. We welcome community contributions!

---

## 🔗 Credits

Built with ❤️ by iOS developers passionate about animation.

---

> “Design fluid, animate boldly.”
