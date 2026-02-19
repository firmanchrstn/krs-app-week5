# KRS Application - Week 5 Homework

This repository is an updated version of the KRS Application, focusing on the implementation of advanced business logic and validation rules for the Course Selection System (KRS).

## Student Information
- Name: Firman
- Major: Information Systems
- Semester: 6

## Chosen Option
For this assignment, I have chosen **Option C: Business Logic Rule**. 
The goal was to implement strict academic rules that govern how a student selects their courses, moving beyond basic form inputs to a functional validation system.

## Main Logic Implementation

### 1. Credit Limit Validation (SKS)
The system enforces a maximum limit of 24 SKS per semester. 
- The application calculates the total SKS in real-time as the user selects or deselects courses.
- If the total exceeds 24 SKS, the submission process is blocked.
- UI Feedback: The SKS counter changes color to red when the limit is exceeded to warn the user before they attempt to submit.

### 2. Mandatory Course Requirement
To ensure students follow the core curriculum, the system requires at least one mandatory course to be selected.
- Each course is categorized as either Mandatory or Elective.
- The submission logic checks if the selection contains at least one item marked as mandatory.
- If no mandatory course is selected, an error message is displayed via a SnackBar.

### 3. Submission Flow
The `_validateAndSubmit` function acts as the gatekeeper. It uses a conditional logic flow:
- Check if any course is selected (Total > 0).
- Check if Total SKS is within the limit (Total <= 24).
- Check if the Mandatory requirement is met.
- Only when all conditions are true, the system navigates to the KRS Detail/Confirmation screen, passing the selected data as arguments.