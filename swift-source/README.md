# King's Prep - Swift Source Files

This directory contains all the Swift source code files for the iOS version of King's Prep.

## 📁 File Structure

```
swift-source/
├── KingsPrepApp.swift          # App entry point (@main)
├── Models/
│   ├── MenuItem.swift          # Menu item data model
│   └── Order.swift             # Order data models
├── Services/
│   └── APIService.swift        # Backend API integration
├── ViewModels/
│   ├── MenuViewModel.swift     # Menu business logic
│   └── OrderViewModel.swift    # Order business logic
├── Views/
│   ├── LandingView.swift       # Landing page
│   ├── MenuView.swift          # Menu listing
│   ├── ItemDetailView.swift    # Item details
│   ├── OrderView.swift         # Order form
│   └── Components/
│       └── MenuItemCard.swift  # Reusable menu card
└── Utilities/
    ├── Theme.swift             # Design system
    └── Extensions.swift        # Swift extensions
```

## 🚀 How to Use These Files

### Option 1: Manual Copy (Recommended for Learning)

1. Create a new Xcode project named "KingsPrep"
2. In Xcode, create the folder structure (right-click → New Group)
3. For each `.swift` file:
   - Right-click on the appropriate group → New File → Swift File
   - Copy and paste the code from this directory

### Option 2: Drag and Drop

1. Create a new Xcode project named "KingsPrep"
2. Delete the default ContentView.swift
3. Drag all these `.swift` files into your Xcode project
4. Make sure "Copy items if needed" is checked
5. Ensure they're added to your target

## ⚙️ Configuration Required

### 1. Update API URL

In `Services/APIService.swift`, update the `baseURL`:

```swift
private let baseURL = "YOUR_BACKEND_URL_HERE"
```

**Local Development:**
- Use your computer's local IP (not localhost)
- Example: `http://192.168.1.100:5000`
- Find your IP: Windows (ipconfig), Mac (ifconfig)

**Production:**
- Use your deployed backend URL
- Example: `https://api.yourapp.com`

### 2. Add Custom Fonts

Download and add these fonts to your project:

**Playfair Display:**
- Download from [Google Fonts](https://fonts.google.com/specimen/Playfair+Display)
- Files needed: PlayfairDisplay-Bold.ttf, PlayfairDisplay-BoldItalic.ttf

**DM Sans:**
- Download from [Google Fonts](https://fonts.google.com/specimen/DM+Sans)
- Files needed: DMSans-Regular.ttf, DMSans-Medium.ttf, DMSans-Bold.ttf

**JetBrains Mono:**
- Download from [JetBrains](https://www.jetbrains.com/lp/mono/)
- File needed: JetBrainsMono-Regular.ttf

**Add to Xcode:**
1. Create a "Fonts" folder in your project
2. Drag font files into the folder
3. Check "Copy items if needed" and add to target
4. Add to Info.plist (see below)

### 3. Configure Info.plist

Right-click Info.plist → Open As → Source Code, then add:

```xml
<!-- Custom Fonts -->
<key>UIAppFonts</key>
<array>
    <string>PlayfairDisplay-Bold.ttf</string>
    <string>PlayfairDisplay-BoldItalic.ttf</string>
    <string>DMSans-Regular.ttf</string>
    <string>DMSans-Medium.ttf</string>
    <string>DMSans-Bold.ttf</string>
    <string>JetBrainsMono-Regular.ttf</string>
</array>

<!-- Network Security (Development Only) -->
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

**⚠️ Production Note:** Replace `NSAllowsArbitraryLoads` with specific domain exceptions before App Store submission.

## 🏗️ Architecture

This app uses the **MVVM (Model-View-ViewModel)** pattern:

- **Models:** Data structures (MenuItem, Order)
- **Views:** SwiftUI views (UI layer)
- **ViewModels:** Business logic and state management
- **Services:** API communication

## 📱 Minimum Requirements

- **iOS:** 16.0+
- **Xcode:** 15.0+
- **Swift:** 5.9+

## 🧪 Testing

### Test API Connection

1. Make sure your backend is running
2. Update the `baseURL` in APIService.swift
3. Run the app
4. Check Xcode console for network logs (🌐 emoji)

### Common Issues

**Fonts not showing:**
- Verify font file names match Info.plist exactly
- Check fonts are added to app target (click font file → File Inspector)
- Run the app and check console for available fonts

**Network errors:**
- Verify backend is accessible from device/simulator
- Check Info.plist has NSAppTransportSecurity
- Test API with curl/Postman first
- Use local IP, not localhost

**Build errors:**
- Clean build: Cmd+Shift+K
- Restart Xcode
- Delete derived data

## 📚 Key SwiftUI Concepts Used

### State Management
- `@State` - Local view state
- `@StateObject` - View model instances
- `@Published` - Observable properties
- `@Environment` - System values (dismiss, etc.)

### Async/Await
```swift
.task {
    await viewModel.loadData()
}
```

### Navigation
```swift
NavigationStack {
    NavigationLink(destination: DetailView()) {
        Text("Go to Detail")
    }
}
```

### Networking
```swift
let (data, _) = try await URLSession.shared.data(from: url)
```

## 🎨 Design System

All styling is centralized in `Utilities/Theme.swift`:

- **Colors:** Dark theme with zinc accents
- **Typography:** Custom fonts with fallbacks
- **Spacing:** Consistent spacing system
- **Corner Radius:** Standardized radii

Usage:
```swift
Text("Hello")
    .font(Theme.displayFont(size: 30))
    .foregroundColor(Theme.textPrimary)
    .padding(Theme.spacing.lg)
```

## 🔄 Data Flow Example

1. User opens MenuView
2. View creates MenuViewModel with `@StateObject`
3. View calls `viewModel.loadMenuItems()` in `.task`
4. ViewModel calls `APIService.shared.fetchMenuItems()`
5. APIService makes HTTP request
6. Data returns → ViewModel updates `@Published var menuItems`
7. View automatically re-renders with new data

## 🆘 Need Help?

1. Check the main `SWIFT_CONVERSION_GUIDE.md` in the parent directory
2. Review Apple's [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
3. Check Xcode console for error messages
4. Test API endpoints independently first

## 📝 Next Steps

1. ✅ Copy all Swift files to Xcode project
2. ✅ Add custom fonts
3. ✅ Configure Info.plist
4. ✅ Update API URL
5. ✅ Build and run!
6. ✅ Test all features
7. ✅ Polish and customize

Good luck! 🚀

