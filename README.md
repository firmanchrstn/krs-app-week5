# KRS Application (Student Study Plan)

A simple mobile application built with Flutter to manage Student Study Plans (Kartu Rencana Studi / KRS). This project was created to fulfill the Week 4 — State Management & Data Passing assignment for the Mobile Application Development course.

## Features

1. Splash Screen: Welcome screen with a 3-second timer.
2. Authentication (Simulation):
   - Login & Sign Up using Email/Password.
   - Password visibility toggle (Show/Hide).
   - Simulated database using memory (Map).
3. Dashboard: Main menu navigation.
4. KRS Management (Week 4 Task):
   - Add courses (Mata Kuliah) to the list.
   - Calculate Total SKS (Credits) dynamically using State Management.
   - Validation: Prevents SKS from going below zero and prevents duplicate courses.
   - Reset button to clear selected courses.
5. KRS Summary:
   - Displays the final list of selected courses and total credits.
   - Demonstrates Data Passing between screens using Constructors.

## Tech Stack

- Framework: Flutter
- Language: Dart
- Architecture: MVC Pattern (Model-View-Controller) adapted for beginners.

## Project Structure

lib/
├── main.dart               # Entry point & Theme configuration
└── screens/
    ├── splash_screen.dart  # Timer & Logo
    ├── login_screen.dart   # Auth Logic (Sign In/Up)
    ├── dashboard_screen.dart # Main Menu
    ├── profile_screen.dart # User Profile (Placeholder)
    ├── krs_screen.dart     # [Stateful] KRS Logic (Add/Remove Courses)
    └── krs_detail_screen.dart # [Stateless] Summary Result

## Week 4 Assignment Checklist

- [x] State Management: Converted KRS Screen to StatefulWidget.
- [x] UI Updates: Used setState() to update "Total SKS" dynamically.
- [x] Data Passing: Passed totalSks and selectedCourses list to the Summary Screen via Constructor.
- [x] Validation: Added logic to prevent negative SKS values.
- [x] Course Selection: Users can select course names and credit values.

---

## Reflection (Week 4)

### 1. What confused me this week?
Initially, I was confused about where exactly to place the setState() function. I learned that it must wrap the specific variable change that affects the UI. If I update the variable outside of setState, the data changes in the background, but the user doesn't see the update on the screen.

### 2. How state changed UI behavior?
State acts as the "memory" of the widget. When I use a StatefulWidget, the screen can redraw itself. For example, when I click "Ambil" on a course, the totalSks variable increases. Because this is inside setState(), Flutter knows to run the build() method again, updating the text on the screen from "0" to "3".

### 3. Errors I faced and solutions
- Error: SKS became negative when testing the decrease button.
  Solution: I added an if (totalSks >= 1) check before performing the subtraction.
- Error: The Summary Screen was blank even after selecting courses.
  Solution: I realized I forgot to pass the List data in the Navigator.push constructor. I fixed it by adding required this.daftarMatkul in the KrsDetailScreen.

### 4. Differences between Stateful and Stateless Widgets

StatelessWidget:
- Data Change: Cannot change (Immutable) once built.
- Rebuild: Only builds once (unless parent changes).
- Use Case: Static text, Icons, Layouts, Detail Views.

StatefulWidget:
- Data Change: Can change (Mutable) dynamically.
- Rebuild: Can rebuild anytime using setState().
- Use Case: Forms, Counters, Checkboxes, KRS Input.

---

## How to Run

1. Clone this repository:
   git clone https://github.com/yourusername/krs-flutter-week4.git

2. Install dependencies:
   flutter pub get

3. Run the app:
   flutter run