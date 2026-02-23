# KRS Application - Week 5 Homework

This repository is an updated version of the KRS Application, focusing on the implementation of advanced business logic and validation rules for the Course Selection System (KRS).

## Student Information
- Name: Firman
- Major: Information Systems
- Semester: 6

---

# KRS Mobile App - Intermediate Level (Option A)

A student Course Selection Management (KRS) application developed using Flutter. This project represents an evolution from Basic to Intermediate level by incorporating more complex business logic and data validation.

---

## Development Focus
In this update, the development focus is directed towards two main points:
1. Addition of academic time identity.
2. Strict enforcement of student study load regulations.

---

## Task Updates (Level: Basic to Intermediate)

### 1. New Field Implementation
Added a "Semester Type" field to the KRS input form. Users are now required to select the current academic semester using a Dropdown Button.
* **Field:** Semester Type
* **Options:** Odd (Ganjil), Even (Genap)

### 2. New Validation Rules
Implemented dual-validation logic within the submit function to ensure data integrity before processing to the summary page.
* **Minimum Validation:** Students must take a minimum of 3 Credits (SKS). If not met, the system displays a SnackBar warning.
* **Maximum Validation:** Students are capped at a maximum of 24 Credits (SKS) in accordance with standard academic regulations.

### 3. Updated Flowchart
The application logic flow has been updated as follows:
1. User enters the KRS Screen.
2. User selects the Semester Type (New Field).
3. User selects courses from the list via Checkboxes.
4. User presses the Submit button.
5. System checks if Total Credits < 3. If true, an error message is displayed.
6. System checks if Total Credits > 24. If true, an error message is displayed.
7. If all validations are met, the system navigates to the KRS Detail Screen, passing the semester data and the list of selected courses.

---

## Main Logic

### State Management
The application utilizes `setState()` to manage local data changes on a single page. This includes:
* Updating the status of course Checkboxes.
* Updating the selection in the Semester Dropdown.
* Real-time automatic calculation of the total selected Credits.

### Navigation and Data Flow
Navigation between screens is handled using `Navigator.push` by leveraging `RouteSettings` to send data (arguments) as a Map. The transmitted data includes:
* A list of courses specifically marked as 'selected: true'.
* The integer sum of the total Credits.
* The string value of the selected semester type.

### Conditional Logic (If-Else)
If-else logic serves as the primary gatekeeper for the validation function. This ensures that navigation to the next screen only occurs if all academic requirements (minimum and maximum Credit limits) are satisfied by the user's input.

---

## Validation Implementation Example
```dart
void validateAndSubmit() {
  if (totalSKS < 3) {
    showSnackBar("Minimum requirement is 3 Credits");
  } else if (totalSKS > 24) {
    showSnackBar("Maximum limit is 24 Credits");
  } else {
    navigateToDetail();
  }
}