# King's Prep iOS - Setup Checklist

Use this checklist to ensure you've completed all setup steps correctly.

## 📱 Xcode Project Setup

- [ ] Open Xcode (version 15.0 or later)
- [ ] Create new project: File → New → Project
- [ ] Select: iOS → App
- [ ] Configure project:
  - [ ] Product Name: `KingsPrep`
  - [ ] Interface: SwiftUI
  - [ ] Language: Swift
  - [ ] Storage: None
- [ ] Choose save location
- [ ] Project created successfully

## 📂 File Structure

- [ ] Delete default `ContentView.swift`
- [ ] Create folder structure (right-click → New Group):
  - [ ] Models
  - [ ] Services
  - [ ] ViewModels
  - [ ] Views
  - [ ] Views/Components
  - [ ] Utilities
  - [ ] Resources (optional)

## 📄 Add Swift Files

### Models
- [ ] Add `MenuItem.swift`
- [ ] Add `Order.swift`

### Services
- [ ] Add `APIService.swift`
- [ ] Update `baseURL` with your backend URL

### ViewModels
- [ ] Add `MenuViewModel.swift`
- [ ] Add `OrderViewModel.swift`

### Utilities
- [ ] Add `Theme.swift`
- [ ] Add `Extensions.swift`

### Views
- [ ] Add `LandingView.swift`
- [ ] Add `MenuView.swift`
- [ ] Add `ItemDetailView.swift`
- [ ] Add `OrderView.swift`
- [ ] Add `Components/MenuItemCard.swift`

### App Entry
- [ ] Replace or update app entry file with `KingsPrepApp.swift`

## 🎨 Custom Fonts

### Download Fonts
- [ ] Download Playfair Display from Google Fonts
  - [ ] PlayfairDisplay-Bold.ttf
  - [ ] PlayfairDisplay-BoldItalic.ttf (optional but recommended)
- [ ] Download DM Sans from Google Fonts
  - [ ] DMSans-Regular.ttf
  - [ ] DMSans-Medium.ttf
  - [ ] DMSans-Bold.ttf
- [ ] Download JetBrains Mono
  - [ ] JetBrainsMono-Regular.ttf

### Add Fonts to Project
- [ ] Create "Fonts" folder in project (optional, for organization)
- [ ] Drag font files into project
- [ ] Check "Copy items if needed"
- [ ] Ensure fonts are added to app target
- [ ] Verify in File Inspector that target membership is checked

### Register Fonts
- [ ] Open Info.plist
- [ ] Right-click → Open As → Source Code
- [ ] Add `UIAppFonts` array with all font filenames
- [ ] Verify font names match files exactly (case-sensitive!)

## ⚙️ Info.plist Configuration

- [ ] Open Info.plist as Source Code
- [ ] Add `UIAppFonts` array (see Info.plist-template.xml)
- [ ] Add `NSAppTransportSecurity` dict for network access
- [ ] (Optional) Set `CFBundleDisplayName` to "King's Prep"
- [ ] (Optional) Configure `UIStatusBarStyle`
- [ ] (Optional) Set supported orientations

## 🌐 Backend Configuration

### Local Development
- [ ] Start your backend server
- [ ] Find your computer's local IP address
  - Windows: `ipconfig` in Command Prompt
  - Mac/Linux: `ifconfig` in Terminal
- [ ] Update `APIService.swift` baseURL to `http://YOUR_LOCAL_IP:PORT`
  - Example: `http://192.168.1.100:5000`
- [ ] Ensure your device/simulator is on the same network

### Production
- [ ] Deploy backend to production server
- [ ] Update `APIService.swift` baseURL to production URL
- [ ] Update Info.plist to use domain-specific exceptions (not NSAllowsArbitraryLoads)

## 🧪 Build & Test

- [ ] Clean build folder: Cmd+Shift+K
- [ ] Build project: Cmd+B
- [ ] Fix any compilation errors
- [ ] Select simulator or device
- [ ] Run app: Cmd+R

### Test Fonts
- [ ] App launches successfully
- [ ] Check Xcode console for "Available Font Families" log
- [ ] Verify custom fonts are listed
- [ ] Landing page shows italic "king's prep" in Playfair Display

### Test Navigation
- [ ] Landing page displays correctly
- [ ] "VIEW" button navigates to menu
- [ ] Menu shows loading state
- [ ] Menu displays items (or shows error if backend not connected)
- [ ] Can tap menu item to see details
- [ ] "START ORDER" button works
- [ ] Order form displays correctly

### Test API Integration
- [ ] Menu items load from backend
- [ ] Item details load correctly
- [ ] Can select items in order form
- [ ] Can submit order
- [ ] Order success screen appears
- [ ] Check Xcode console for API logs (🌐 emoji)

## 🐛 Troubleshooting

### Fonts Not Showing
- [ ] Verified font files are in project
- [ ] Checked target membership
- [ ] Confirmed Info.plist entries match filenames exactly
- [ ] Reviewed console for font warnings
- [ ] Tried cleaning build and rebuilding

### Network Errors
- [ ] Backend server is running
- [ ] Using local IP (not localhost) for simulator/device
- [ ] Info.plist has NSAppTransportSecurity configured
- [ ] Tested API with Postman/curl separately
- [ ] Device/simulator has internet access
- [ ] Firewall not blocking connections

### Build Errors
- [ ] All Swift files are added to target
- [ ] No syntax errors in code
- [ ] Cleaned build folder (Cmd+Shift+K)
- [ ] Restarted Xcode
- [ ] Correct iOS deployment target set (16.0+)

### Runtime Crashes
- [ ] Checked Xcode console for error messages
- [ ] Verified all @StateObject and @ObservedObject usage
- [ ] Ensured API responses match model structures
- [ ] Tested with breakpoints to isolate issue

## 🚀 Final Checks

- [ ] All views display correctly
- [ ] Navigation flows work smoothly
- [ ] Animations are smooth
- [ ] Data loads from backend
- [ ] Orders can be submitted
- [ ] Error states display properly
- [ ] Loading states show correctly
- [ ] Dark theme applied throughout
- [ ] Text is readable and properly styled
- [ ] Images load correctly
- [ ] No console warnings or errors

## 📋 Optional Enhancements

- [ ] Add app icon (Assets.xcassets)
- [ ] Configure launch screen
- [ ] Add haptic feedback
- [ ] Implement pull-to-refresh
- [ ] Add offline mode/caching
- [ ] Implement search functionality
- [ ] Add order history
- [ ] Add user authentication
- [ ] Implement push notifications
- [ ] Add analytics
- [ ] Localization for multiple languages

## ✅ Ready for Testing!

Once all items are checked:
- [ ] App builds without errors
- [ ] All features work as expected
- [ ] Ready for device testing
- [ ] Ready for TestFlight (if needed)

---

**Need Help?** Check the main `SWIFT_CONVERSION_GUIDE.md` or `README.md` in the swift-source folder.

