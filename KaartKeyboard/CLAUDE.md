# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

KaartKeyboard is an iOS custom keyboard extension written in Swift designed for Go Map!! to make text input faster and more accurate. It supports multiple languages with accented character input and predictive text suggestions.

## Build and Development Commands

**Building the project:**
- Open `KaartKeyboard/KaartKeyboard.xcodeproj` in Xcode
- Build using Xcode's build system (⌘+B)
- Run on simulator or device (⌘+R)

**No package manager dependencies:** This project uses pure Swift/iOS SDK without external dependencies.



## Architecture

### Main Components

**App Extension Architecture:**
- Main app (`KaartKeyboard.app`) - Configuration interface with language selection
- Keyboard extension (`KaartKeyboard.KaartKeyboard.appex`) - The actual custom keyboard

**Core Classes:**
- `KeyboardViewController` - Main keyboard controller, handles input, layout, and user interactions
- `Language` - Decodable class representing keyboard layouts from JSON files
- `LanguageProvider` - Protocol for language-specific behavior (programming languages)
- `SuggestionProvider` - Protocol for autocomplete/predictive text

### Key Patterns

**Language System:**
- Language definitions stored as JSON in `Keyboard/Languages/` (english.json, greek.json, etc.)
- Each language defines primary/secondary/tertiary characters per key
- `Character` struct with primary, secondary, and tertiary (accented) characters
- Current language persisted in UserDefaults with key "CURRENT_LANG"

**Keyboard Layout:**
- Custom button classes: `KeyButton`, `CharacterButton`, `SuggestionButton`
- `KeyPop` handles accented character popups on long press
- `TouchDelegatingView` manages touch forwarding for complex interactions
- `SwipeView` for gesture-based input

**Suggestion System:**
- `SuggestionTrie` implements trie data structure for fast prefix matching
- `WeightedString` represents suggestions with frequency weights
- `PredictiveTextScrollView` displays suggestion bar above keyboard

**Language Providers:**
- `DefaultLanguageProvider` - Basic language support
- `SwiftLanguageProvider` - Swift programming language keywords and symbols
- Each provider defines secondary/tertiary characters and autocapitalization rules

### File Structure

- `ELDeveloperKeyboard/` - Main app UI (language selection, settings)
- `Keyboard/` - Keyboard extension implementation
  - `Custom Views/` - UI components (buttons, views)
  - `Extensions/` - Swift extensions (CGPoint, String, UIImage)
  - `LanguageProviders/` - Programming language definitions
  - `Languages/` - JSON language layout files
  - `Suggestion/` - Autocomplete system
  - `Helper/` - Utility classes (CircularArray)

## Development Notes

- Uses Settings.bundle for in-app configuration
- Supports iOS keyboard extension lifecycle and delegate patterns
- Implements custom keyboard appearance with gradients and styling
- Language switching through main app interface, persisted to UserDefaults
- No automated tests present in current codebase