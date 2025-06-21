# 📱 Tracker App

A simple expense tracking app built with Flutter. It allows users to add, view, and paginate through expenses, using a clean architecture and modern development practices.

---

## 🧠 State Management

The app uses **Flutter BLoC** (`flutter_bloc` package) for state management.

- **BLoCs** handle business logic and emit UI states

---

## 🌐 API Integration

The app integrates with a RESTful API to fetch expenses.

- Uses **`http`** package for network calls
- Data layer contains:
  - **DTOs** (Data Transfer Objects) for decoding JSON
  - **Repositories** abstract the API layer
- Error handling with `Either` (via `dartz`) or simple try/catch based on complexity

---

## 🔄 Pagination Strategy

Pagination is handled **locally** and/or **via API**, depending on the mode.

### 🔁 Local Pagination (Fallback)

- In offline mode or small data sets, local list slicing is used
- Ideal for mock/test data or very limited storage

---

## 🖼️ UI Screenshots

![Simulator Screenshot - iPhone 16 Pro Max - 2025-06-21 at 22 11 51](https://github.com/user-attachments/assets/244e1090-b39e-43fd-af77-7960184ff444)
![Simulator Screenshot - iPhone 16 Pro Max - 2025-06-21 at 22 11 59](https://github.com/user-attachments/assets/9ee09008-d4ea-4864-b49b-aa0d413def98)
![Simulator Screenshot - iPhone 16 Pro Max - 2025-06-21 at 22 12 18](https://github.com/user-attachments/assets/320131a9-b652-4527-8591-866824bb5df9)


## ⚖️ Trade-offs & Assumptions

- **No authentication** implemented to keep focus on core features
- Simple REST API assumed to be stable and well-structured
- Local database (e.g., Hive) skipped for demo purposes
- UI prioritizes function over design polish (can be themed easily)

---

## 🚀 How to Run the Project

### Prerequisites:

- Flutter SDK >= 3.22.x
- Dart >= 3.x
- Android Studio or VSCode
