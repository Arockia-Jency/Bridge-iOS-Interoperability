Bridge: UIKit & SwiftUI Hybrid Architecture
A high-performance iOS application demonstrating the seamless integration of SwiftUI components within a legacy UIKit navigation stack. This project serves as a technical showcase for modernizing iOS applications through framework interoperability.

🚀 Key Technical Features
🛠 Framework Interoperability
UIHostingController Integration: Successfully bridged the imperative UIKit world with declarative SwiftUI by wrapping views in a hosting environment.

Dynamic Data Injection: Implemented safe data passing from UITableView delegates to SwiftUI view initializers.

🎨 Advanced UI/UX
Custom UIKit Cells: Programmatic implementation of UITableViewCell using XIBs, featuring custom layer styling (Shadow Paths, Corner Radii, and Dynamic Tints).

Modern SwiftUI Layouts: Detailed screens built using ZStack, VStack, and LinearGradients to achieve a "Glassmorphism" effect.

SF Symbols Mastery: Utilized a consistent iconography system across both frameworks.

🏗 Architecture & Clean Code
Modular Folder Structure: Organized into Models, Modules, and Resources to ensure scalability and maintainability.

Type-Safe Models: Used a unified Topic model to act as the "Source of Truth" for the entire application.

📱 How it Works
The app launches into a UIKit UINavigationController containing a table of advanced Swift topics.

Upon user interaction, the app initializes a SwiftUI View.

The SwiftUI view is presented via a UIHostingController, maintaining a smooth, native transition within the navigation stack.
