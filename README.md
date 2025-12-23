# Flutter Chat Application

## Project Overview

The application provides:
- A home screen with tab-based navigation
- A users list and chat history
- A chat screen with real-time message flow and typing indicator
- Translation support on selected message text

The app follows a **feature-based architecture**, where each feature owns its UI, state management, and business logic.  
This makes the codebase easier to scale and reason about as the app grows.

---

## State Management

- **Bloc** is used for features that involve asynchronous operations and complex state transitions (chat, users, chat history).
- **Cubit** is used for small, isolated logic such as text translation.

All state logic is separated from UI, and services are injected through constructors to keep the code test-friendly.

---

## Navigation

- **Go Router** is used for navigation

---

## External APIs

- **Random Chat Reply**  
  API: https://dummyjson.com/comments/  
  Purpose: Fetches a random comment to simulate an automated chat reply

- **Text Translation**  
  API: https://ftapi.pythonanywhere.com/translate  
  Default Language: French  
  Purpose: Translates selected chat text into French


## Testing Approach

### Unit & Widget Tests
- Test business logic and UI behavior in isolation
- External services are mocked
- Focus on state transitions, error handling, and edge cases
- Designed to be fast and deterministic

### Integration Tests
- Run the real application
- Verify complete user flows (navigation, chat, message sending)
- Network interactions can be mocked at the HTTP level
- Ensure different parts of the app work together correctly

---

## ✅ Design Principles

- Clear separation of concerns
- No business logic inside widgets
- Predictable state management
- Testability as a first-class concern

---
