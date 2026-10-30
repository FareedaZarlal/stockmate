# StockMate

**A simple inventory app for small shop owners.**

Built with Flutter as the final project of the **Stack & Scale Remote Internship 2026** (Mobile App Development track).

| Domain | Project Period | Delivery |
| --- | --- | --- |
| Mobile App Development | 26–30 October 2026 | Friday Final Project |

---

## Overview

StockMate helps small shop owners track product names, prices, quantities, and low-stock items directly on their phone. It is a beginner-friendly app with local product management and clear, color-coded stock indicators. No account or internet connection is needed.

**Target user:** Small shop owners who need a simple way to manage their stock.

---

## Features

| Feature | Status | Description |
| --- | --- | --- |
| Product List | Done | Shows name, price, quantity, and stock status |
| Add Product | Done | Form with input validation |
| Edit Product | Done | Update existing product details |
| Delete Product | Done | Confirmation dialog before deletion |
| Quantity +/- Controls | Done | Quick adjustments; prevents negative quantities |
| Low / Out of Stock | Done | Color-coded badges (low-stock threshold = 5) |
| Local Persistence | Done | `shared_preferences` + JSON serialization |
| Search | Done | Search by product name or category |
| Summary Cards | Done | Total Products, Low Stock, Total Value |
| Empty State | Done | Friendly message when no products exist |

---

## Screenshots

Add your screenshots to a `screenshots/` folder and update the paths below.

| Empty State | Add Product Form | Product List |
| --- | --- | --- |
| ![Empty State](<img width="375" height="452" alt="1" src="https://github.com/user-attachments/assets/dc73539d-b201-4bb8-bcca-f10d42ee8047" />
) | ![Add Product](<img width="376" height="452" alt="2" src="https://github.com/user-attachments/assets/3eecee60-239f-4ef0-a884-d0a6b6d5e985" />
) | ![Product List](<img width="370" height="446" alt="Capture" src="https://github.com/user-attachments/assets/441fc9d2-9a73-4362-bc64-331af6b3c21b" />
) |

| Low Stock Indicator | Search |
| --- | --- |
| ![Low Stock](<img width="370" height="446" alt="Capture" src="https://github.com/user-attachments/assets/508ea66b-0606-4714-b42b-9bd84e29a347" />
) | ![Search](<img width="372" height="448" alt="3" src="https://github.com/user-attachments/assets/c7025ca4-f12d-459b-a08d-c9760eeba642" />)
 |

---

## Tech Stack

| Area | Technology |
| --- | --- |
| Framework | Flutter |
| Language | Dart |
| State Management | `setState()` |
| Local Storage | `shared_preferences` + JSON serialization |
| Architecture | Clean folder structure (models, services, screens, widgets) |

---

## Project Structure

```
lib/
├── main.dart
├── models/
│   └── product.dart
├── services/
│   └── storage_service.dart
├── screens/
│   ├── home_screen.dart
│   └── product_form_screen.dart
└── widgets/
    ├── product_card.dart
    ├── summary_cards.dart
    └── empty_state.dart
```

| File | Purpose |
| --- | --- |
| `main.dart` | App entry point |
| `models/product.dart` | Product data model with JSON conversion |
| `services/storage_service.dart` | Saves and loads products via `shared_preferences` |
| `screens/home_screen.dart` | Product list, search, and summary cards |
| `screens/product_form_screen.dart` | Add and edit product form with validation |
| `widgets/product_card.dart` | Product tile with stock badge and quantity controls |
| `widgets/summary_cards.dart` | Total Products, Low Stock, and Total Value cards |
| `widgets/empty_state.dart` | Message shown when there are no products |

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- An emulator, a physical device, or Chrome (for Flutter Web)

### Run the project

```bash
# 1. Clone the repository
git clone <your-repository-url>
cd stockmate

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

---

## Known Limitations

- **Flutter Web:** Data persists within the same browser session. Fully closing and reopening the browser may clear data during development (normal Flutter Web behavior). On a real mobile device, data persists properly.
- **No cloud sync:** There is no cloud synchronization or multi-device support.

---

## What I Learned

- Building multiple screens and reusable widgets in Flutter
- Managing UI state with `setState()`
- Creating and validating forms
- Implementing local data persistence with `shared_preferences`
- Designing a clean and user-friendly interface
- Handling empty states and user feedback (SnackBars, confirmation dialogs)

---

## Author

**Fareeda Zarlal**
Mobile App Development Intern, Stack & Scale Remote Internship 2026
Submitted: 30 October 2026
