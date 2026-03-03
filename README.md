# Personal Finance Management App

> **Work In Progress**

A personal finance management application built with Flutter, designed to help users track their income and expenses, visualize spending patterns, and maintain financial health.

## Features

### Transaction Management
- Add, view, edit, and delete financial transactions
- Support for both income and expense tracking
- Detailed transaction information including title, amount, category, date, and description
- Swipe-to-delete functionality for quick transaction removal

### Categories
- Customizable expense and income categories
- Pre-defined categories: Housing, Food, Transportation, Entertainment, and Other
- Visual category representation with icons and colors
- Category-based spending analysis
- Add custom categories to fit personal needs

### Dashboard
- Real-time total balance calculation
- Quick summary of today's income and expenses
- Income vs. Expense comparison
- Top expense tracking
- Spending breakdown by category with visual pie chart representation
- Monthly trend analysis with interactive charts

### Statistics & Analytics
- Comprehensive statistics view with multiple time periods (week, month, year)
- Interactive bar charts showing income and expense trends
- Top spending categories with percentage breakdown
- Visual representation of financial patterns
- Historical data analysis

### Settings & Customization
- Multi-language support (English and Spanish)
- Theme customization (Light, Dark, System)
- Currency selection
- PIN security for app access

### Security
- Optional PIN protection
- 4-digit PIN setup and verification
- Secure local data storage

## Technical Stack

### Architecture
- Clean Architecture with clear separation of concerns
- Feature-based modular structure
- Domain-driven design principles

### State Management
- BLoC (Business Logic Component) pattern
- flutter_bloc for reactive state management
- Event-driven architecture

### Data Persistence
- Hive NoSQL database for local storage
- Type adapters for custom data models
- Efficient data retrieval and caching

### UI/UX
- Material Design principles
- Font Awesome icons
- Custom themed components

### Localization
- flutter_localizations for internationalization
- Support for multiple languages
- Easy extension for additional languages

### Navigation
- go_router for declarative routing
- Deep linking support
- Named routes for maintainability

### Visualization
- fl_chart for interactive charts and graphs
- Custom bar charts and pie charts
- Real-time data visualization

### Dependencies
```yaml
- flutter_bloc: State management
- get_it: Dependency injection
- go_router: Navigation
- hive_ce: Local database
- fl_chart: Data visualization
- dartz: Functional programming
- intl: Internationalization
- font_awesome_flutter: Icons
- uuid: Unique identifiers
```

## Project Structure

```
lib/
├── core/                    # Core functionality
│   ├── app.dart            # Main app widget
│   ├── dependency_injection.dart
│   ├── constants/          # App constants
│   ├── database/           # Database configuration
│   ├── routes/             # Route definitions
│   └── widgets/            # Shared widgets
├── features/               # Feature modules
│   ├── dashboard/          # Dashboard feature
│   ├── transactions/       # Transaction management
│   ├── category/           # Category management
│   ├── stats/              # Statistics and analytics
│   └── settings/           # App settings
└── l10n/                   # Localization files
```

Each feature follows Clean Architecture:
- `data/` - Data sources and repositories
- `domain/` - Business logic and entities
- `presentation/` - UI and BLoC

## Getting Started

### Prerequisites
- Flutter SDK (>=3.10.4)
- Dart SDK
- Android Studio / VS Code
- Android SDK / Xcode (for iOS)

### Installation

1. Clone the repository
```bash
git clone https://github.com/FJReyna/financeapp.git
cd financeapp
```

2. Install dependencies
```bash
flutter pub get
```

3. Generate required files
```bash
flutter pub run build_runner build
```

4. Run the app
```bash
flutter run
```

### Running Tests
```bash
flutter test
```

## Development Practices

- **Clean Code**: Following SOLID principles and clean code practices
- **Testing**: Unit tests for business logic and use cases
- **Type Safety**: Strong typing with Dart
- **Error Handling**: Functional programming for error handling using dartz
- **Dependency Injection**: Using get_it for loose coupling
- **Code Generation**: Hive type adapters and localization files

## Future Enhancements

- Filter and search transactions by date or category
- Data management options (export, import, cloud sync)
- Cloud synchronization across devices
- Budget planning and alerts
- Recurring transactions
- Export data to CSV/PDF
- Biometric authentication
- Receipt scanning and attachment
- Financial goals and savings tracker
- Multi-currency support with exchange rates
- Detailed reports and insights

## License

This project is licensed under the MIT License - see below for details:

```
MIT License

Copyright (c) 2026 Francisco Reyna

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
