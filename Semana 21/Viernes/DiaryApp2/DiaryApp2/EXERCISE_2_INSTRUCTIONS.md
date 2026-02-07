# Exercise 2

## General Information

This exercise is divided into two parts:
- **Part 1**: Improvements and bug fixes to the existing Pokedex project
- **Part 2**: Create a new application from scratch

---

# Part 1: Pokedex Improvements

In this part, you will work with the Pokedex project to fix bugs and improve code organization.

---

## 1.1 Fix First Launch Crash (15 points)

### Objective
Fix the bug that causes the app to crash when installed for the first time.

### Requirements
- [ ] Identify the bug in `PokemonListViewModel.swift` in the `loadFavoritePokemon()` method
- [ ] The app should not crash when the favorites file doesn't exist yet

---

## 1.2 Create ViewModel for UserAuthenticationViewController (20 points)

### Objective
Separate the authentication logic from the view in `UserAuthenticationViewController`.

### Requirements
- [ ] Create a new file `UserAuthenticationViewModel.swift`
- [ ] The ViewModel must handle:
  - `LAContext` configuration
  - Biometric authentication evaluation
  - Error handling for authentication failures
- [ ] Create a **protocol/delegate** to communicate authentication results to the ViewController
- [ ] The ViewController should only:
  - Configure the UI
  - Respond to ViewModel notifications
  - Handle navigation after successful authentication

---

## 1.3 Move PHPicker/ImagePicker Logic to ViewModel (20 points)

### Objective
Refactor `FavoritePokemonDetailViewController` to move photo picking logic to the ViewModel.

### Requirements
- [ ] The `FavoriteDetailPokemonViewModel` must handle:
  - Image picker configuration
  - Photo selection results
- [ ] Create appropriate delegate methods to communicate with the ViewController
- [ ] The ViewController should only:
  - Present the picker
  - Update the UI when an image is selected
- [ ] Support both camera (device) and photo library (simulator)

---

## 1.4 Add Robust Error Handling (15 points)

### Objective
Add proper error handling throughout the app with user-friendly alerts.

### Requirements
- [ ] Show alerts when:
  - Favorite pokemon cannot be saved
  - Favorite pokemon cannot be loaded
  - Biometric authentication is not available
- [ ] All error messages must be clear and user-friendly
- [ ] Use `UIAlertController` for all error displays

---

# Part 2: Diary App 📔

In this part, you will create a personal diary application.

---

## General Description

The application will have the following screens:

1. **Authentication Screen**: FaceID/TouchID to unlock the app
2. **Diary Entry List**: List of all entries with an "Add" button
3. **Entry Editor**: Create/edit entries with title, message, location, and photo
4. **Location Search**: Search for addresses and select location
5. **Entry Detail**: View saved entry with directions button

---

## 2.1 Initial Setup (5 points)

### Requirements
- [ ] Configure the project to use **programmatic UIKit**
- [ ] Configure `SceneDelegate` to start the app programmatically
- [ ] Add required permissions in `Info.plist`:
  - Location usage description
  - Camera usage description
  - Photo library usage description
  - FaceID usage description
- [ ] Add Lottie dependency using Swift Package Manager

---

## 2.2 Data Models (15 points)

### Requirements
- [ ] Create the `DiaryEntry` model
- [ ] All models must conform to `Codable`
- [ ] Create a `DiaryDataService` to handle:
  - Loading entries from file
  - Saving entries to file
  - File must be saved in Documents directory (NOT UserDefaults)

---

## 2.3 Authentication Screen (15 points)

### Requirements
- [ ] Create `AuthenticationViewController` programmatically
- [ ] Create `AuthenticationViewModel` to handle FaceID/TouchID logic
- [ ] Display:
  - App logo or welcome message
  - "Authenticate" button
- [ ] After successful authentication, dismiss and show the entry list
- [ ] The app must "lock" when it receives `willResignActiveNotification`
- [ ] When the app becomes active again after being locked, show authentication

---

## 2.4 Diary Entry List (20 points)

### Requirements
- [ ] Create `DiaryListTableViewController`
- [ ] Create `DiaryListViewModel`
- [ ] Each cell must show:
  - Entry title
  - Entry date
  - **Draft indicator** if it's a draft (use different color, badge, or icon)
- [ ] Add a "+" button in the navigation bar to create new entries
- [ ] When selecting an entry:
  - If draft: open editor to continue editing
  - If not draft: open detail view
- [ ] Entries should be sorted by date (newest first)

---

## 2.5 Entry Editor (25 points)

### Requirements
- [ ] Create `EntryEditorViewController` programmatically
- [ ] Create `EntryEditorViewModel`
- [ ] The editor must have:
  - `UITextField` for title
  - `UITextView` for message
  - Button to add photo (with action sheet: Camera or Gallery)
  - Button to add/change location
  - Preview of selected photo (if any)
  - Preview of selected location (if any)
  - "Save" button
- [ ] **Draft functionality**:
  - Listen to `UIApplication.willResignActiveNotification`
  - When received: save current entry as draft
  - Pop back to the list (the list should show FaceID when app becomes active)
- [ ] Photos must be saved as separate files in Documents directory

### Hints
- To save an image to Documents:
  ```swift
  guard let data = image.jpegData(compressionQuality: 0.8),
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
  else { return nil }
  
  let imageName = UUID().uuidString
  let imageURL = documentsURL.appendingPathComponent("\(imageName).jpg")
  try? data.write(to: imageURL)
  ```

---

## 2.6 Location Search (20 points)

### Requirements
- [ ] Create `LocationSearchViewController` programmatically
- [ ] Create `LocationSearchViewModel`
- [ ] The screen must have:
  - `UISearchBar` for typing addresses
  - `UITableView` to display search results
  - Cancel button
- [ ] As the user types, show address suggestions
- [ ] When selecting a result, get coordinates and pass back to editor screen
- [ ] Use delegate pattern to communicate with the editor screen

### Hints
- Use `MKLocalSearchCompleter` for address autocomplete
- Use `MKLocalSearch.Request(completion:)` to get coordinates from a selected result

---

## 2.7 Entry Detail View (20 points)

### Requirements
- [ ] Create `EntryDetailViewController` programmatically
- [ ] Create `EntryDetailViewModel`
- [ ] Display:
  - Entry title
  - Entry message
  - Entry date
  - Photo (if available)
  - Location address (if available)
  - **"Get Directions" button** (only if location exists)
  - **`UISegmentedControl`** to choose between walking or driving directions
  - **Lottie animation** (decorative, your choice)
- [ ] "Get Directions" button should show route from user's current location to entry location
- [ ] The route type must change based on the segmented control selection (walking vs driving)
- [ ] The route should be displayed on a map (can be embedded or presented modally)

---

## 2.8 Photo Capture with Action Sheet (10 points)

### Requirements
- [ ] When tapping the photo button, show an action sheet with options:
  - "Take Photo" (only on device)
  - "Choose from Gallery"
  - "Cancel"
- [ ] Handle camera on device using `UIImagePickerController`
- [ ] Handle gallery using `PHPickerViewController`
- [ ] Update the preview in the editor when a photo is selected

---

## Suggested Project Structure

```
MiPrimerDiario/
├── AppDelegate.swift
├── SceneDelegate.swift
├── Models/
│   ├── DiaryEntry.swift
│   └── Location.swift
├── Services/
│   └── DiaryDataService.swift
├── Authentication/
│   ├── AuthenticationViewController.swift
│   └── AuthenticationViewModel.swift
├── DiaryList/
│   ├── DiaryListTableViewController.swift
│   └── DiaryListViewModel.swift
├── EntryEditor/
│   ├── EntryEditorViewController.swift
│   └── EntryEditorViewModel.swift
├── LocationSearch/
│   ├── LocationSearchViewController.swift
│   └── LocationSearchViewModel.swift
├── EntryDetail/
│   ├── EntryDetailViewController.swift
│   └── EntryDetailViewModel.swift
├── Resources/
│   └── (Lottie animation files)
└── Info.plist
```

---

## Extra Points (Optional)

- **+10 points**: Add swipe-to-delete for entries
- **+5 points**: Add edit functionality for saved (non-draft) entries
- **+5 points**: Implement Dark Mode correctly
- **-10 points**: Use of `print` statements

---

**Good luck! 🍀**
