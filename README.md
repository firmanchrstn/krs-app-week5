# KRS Application (Student Study Plan)

A simple mobile application built with Flutter to manage Student Study Plans (Kartu Rencana Studi / KRS). This project was created to fulfill the Week 4 — State Management & Data Passing assignment for the Mobile Application Development course.

---

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

---

# Case Study Answers: Flutter State Management

This document contains technical explanations regarding `StatelessWidget`, `StatefulWidget`, and basic state management.

---

## 1. Why can’t `StatelessWidget` use `setState()`?

**Answer:**
Because `StatelessWidget` is designed to be **Immutable**.
* It does not have a companion `State` object to track data changes.
* Its only job is to render the UI **once** upon initialization based on the data it receives.
* To update the UI, the widget must be destroyed and completely rebuilt by its parent, rather than updated internally.

---

## 2. What happens if `setState()` is removed from the button?

**Answer:**
* **Data Changes:** The underlying variable still updates (e.g., the `counter` value increases).
* **UI Stagnates:** The screen display will **not** update.
* **Cause:** Without `setState()`, Flutter does not receive the "dirty" signal required to re-run the `build()` method. Consequently, the screen looks "stuck" on the old data.

---

## 3. Why is `KrsDetailScreen` better as a `StatelessWidget`?

**Answer:**
* **Read-Only Nature:** Detail screens usually only display static data passed from the previous screen (like Course Name, Credits).
* **No Interaction:** Direct data editing rarely happens on this specific screen.
* **Performance:** Using `StatelessWidget` is more memory and CPU efficient because it doesn't need to maintain a complex `State` lifecycle.

---

## 4. What kind of data should NOT be stored as state?

**Answer:**
Avoid storing the following types of data inside `setState`:

1.  **Derived Data:**
    * Data that depends on other variables for its calculation.
    * *Example:* Do not store `totalPrice`. Instead, calculate `price * quantity` directly inside the `build` method.
2.  **Static Data:**
    * Configuration that never changes while the app is running.
    * *Example:* App Title, fixed Theme Colors.
3.  **Temporary Logic Data:**
    * Variables used only for internal calculations that have no visual impact.
    * *Example:* Loop iterators (`i`), backend log timers.
    
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
   git clone https://github.com/firmanchrstn/krs-flutter-week4.git

2. Install dependencies:
   flutter pub get

3. Run the app:
   flutter run