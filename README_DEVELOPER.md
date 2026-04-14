# HotPotato - Mathematik-Spiel für Flutter

## Übersicht
HotPotato ist ein spannendes Mathematik-Spiel, bei dem Spieler einfache Rechenaufgaben lösen müssen, bevor die Zeit abläuft. Die App wurde mit Flutter entwickelt und verwendet moderne UI-Prinzipien mit Animationen und einem ansprechenden Design.

## Architektur

### Ordnerstruktur
```
lib/
├── data/                    # Datenlogik (Repository Pattern)
│   ├── model/              # Datenmodelle
│   └── service/            # Services für Datenverarbeitung
├── routing/                # Navigation und Routen
├── ui/                     # Benutzeroberfläche
│   ├── core/              # Gemeinsame UI-Komponenten
│   │   ├── ui/           # Themes und Animationen
│   │   └── widgets/      # Wiederverwendbare Widgets
│   ├── ending/           # Spielende-Screen
│   ├── main/             # Hauptspiel-Screen
│   ├── math_challenge/   # Mathematik-Aufgaben
│   ├── starting/         # Start-Screen
│   └── timer/            # Timer-Funktionalität
└── utils/                # Hilfsfunktionen
```

## Wichtige Komponenten

### 1. Datenlayer (Repository Pattern)

#### MathChallengeService
```dart
class MathChallengeService {
  MathChallengeModel createChallenge() {
    // Erstellt zufällige Rechenaufgaben
  }
}
```

#### MathChallengeModel
```dart
class MathChallengeModel {
  int firstNumber = 0;
  int secondNumber = 0;
  String operator = '+';

  String get readableChallenge => "$firstNumber $operator $secondNumber";
}
```

### 2. UI-Komponenten

#### MathChallengeView
Hauptkomponente für die Anzeige von Rechenaufgaben:
- Zeigt die Aufgabe formatiert an
- Beinhaltet Eingabefeld und Submit-Button
- Verwendet MathChallengeParser für die Darstellung

#### MathChallengeParser
Parst und formatiert Rechenaufgaben:
- Zerlegt "15 + 23" in einzelne Teile
- Erstellt RichText mit unterschiedlichen Stilen für Zahlen und Operatoren
- Hat Fallback für unbekannte Formate

#### ResultInputField
Eingabefeld für die Antwort:
- TextField für Zahlen-Eingabe
- Submit-Button mit Haken-Symbol
- Fokussiert automatisch

### 3. Timer-System

#### TimerViewModel
Verwaltet den Spiel-Timer:
- Startet und stoppt den Timer
- Berechnet verbleibende Zeit
- Farbcodierung basierend auf Zeitdruck

#### TimerView
Zeigt den Timer an:
- CircularProgressIndicator für Zeitvisualisierung
- Farbwechsel (Grün → Gelb → Rot) bei wenig Zeit
- Animiert beim Spielstart

### 4. Animationen

#### Wichtige Animationen:
- **FAB Animation**: Start-Button verschwindet beim Spielstart
- **Pulse Animation**: Knöpfe pulsieren für Aufmerksamkeit
- **Slide-in Animationen**: Karten gleiten sanft ein
- **Bounce Animationen**: Elemente springen beim Erscheinen

#### AnimationHelper
```dart
class AnimationHelper {
  static Color playPulse(double time) {
    // Erstellt pulsierende Farben basierend auf Zeit
  }
}
```

## Spielablauf

1. **Start-Screen**: Spieler sieht Start-Button
2. **Spielstart**: Timer beginnt, erste Aufgabe erscheint
3. **Spiel-Loop**:
   - Spieler sieht Aufgabe (z.B. "15 + 23")
   - Spieler gibt Antwort ein
   - Bei richtiger Antwort: Neue Aufgabe
   - Bei falscher Antwort: Zeitstrafe
4. **Spielende**: Zeit abgelaufen oder Spieler gibt auf

## Code-Prinzipien

### SOLID-Prinzipien
- **Single Responsibility**: Jede Klasse hat nur eine Aufgabe
- **Open-Closed**: Erweiterbar ohne Änderungen
- **Dependency Inversion**: Abhängigkeiten zu Abstraktionen

### Beispiel für Single Responsibility:
```dart
// ❌ Schlecht: Eine Klasse macht alles
class GameWidget {
  void parseChallenge() { /* ... */ }
  void displayTimer() { /* ... */ }
  void handleInput() { /* ... */ }
}

// ✅ Gut: Aufgeteilte Verantwortlichkeiten
class MathChallengeParser { /* nur parsen */ }
class TimerView { /* nur Timer anzeigen */ }
class ResultInputField { /* nur Eingabe */ }
```

## Themes und Styling

### AppTheme
Definiert das gesamte Farbschema:
- Material Design 3
- Dunkle und helle Modi
- Konsistente Farben für Timer-Zustände

### Farbcodierung
- **Grün**: Viel Zeit übrig
- **Gelb**: Mittlerer Zeitdruck
- **Rot**: Wenig Zeit, Eile!

## Wichtige Dateien

### Haupt-Entry-Points
- `lib/main.dart` - App-Startpunkt
- `lib/main_development.dart` - Entwicklungsmodus (Wird aktuell nicht verwendet)
- `lib/main_staging.dart` - Testmodus (Wird aktuell Nicht verwendet)

### Services
- `lib/data/service/math_challenge_service.dart` - Aufgaben generieren
- `lib/data/service/timer_service.dart` - Timer verwalten

### UI-Screens
- `lib/ui/starting/` - Start-Screen
- `lib/ui/timer/` - Spiel-Screen mit Timer
- `lib/ui/ending/` - Ende-Screen

## Entwicklung

### Neue Features hinzufügen
1. **Daten**: Neue Models in `lib/data/model/`
2. **Logik**: Services in `lib/data/service/`
3. **UI**: Widgets in entsprechenden `lib/ui/*/widgets/`
4. **Animationen**: In `lib/ui/core/ui/animations/`

### Testing
```bash
flutter test
```

### Build
```bash
flutter build apk  # Für Android
flutter build ios  # Für iOS
```

## Häufige Probleme

### Timer funktioniert nicht
- Prüfe TimerService-Initialisierung
- Stelle sicher, dass TimerViewModel richtig connected ist

### Animationen ruckeln
- Verwende `TickerProviderStateMixin`
- Optimiere `setState()` Aufrufe

### Text erscheint nicht richtig
- Prüfe Theme-Kontext
- Verwende `Theme.of(context)` für Farben

## Nützliche Befehle

```bash
# App starten
flutter run

# Code analysieren
flutter analyze

# Tests ausführen
flutter test

# Dependencies aktualisieren
flutter pub get

# Neue Platform hinzufügen
flutter create --platforms=web .
```

## Tipps für Anfänger

1. **State Management**: Verwende Provider für komplexe States
2. **Keys**: Immer `super.key` in Konstruktoren weitergeben
3. **Context**: `Theme.of(context)` nur in Build-Methoden verwenden
4. **Animationen**: `AnimationController` immer disposen
5. **Performance**: `const` verwenden wo möglich

## Architektur-Entscheidungen

### Warum Repository Pattern?
- Trennt Datenlogik von UI
- Einfach testbar
- Wiederverwendbar

### Warum separate Parser-Klasse?
- Single Responsibility
- Einfach zu testen
- Wiederverwendbar für andere Formate

### Warum Animationen?
- Bessere User Experience
- Feedback für Aktionen
- Professionelles Erscheinungsbild

---

**Viel Spaß beim Entwickeln!** 🚀