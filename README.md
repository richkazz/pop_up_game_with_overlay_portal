```markdown
# CustomOverlayPortal Demo

This Flutter project demonstrates the use of custom overlay portals to create interactive and animated overlays in a mobile application. The overlays can be positioned at various locations on the screen and are controlled using custom controllers.

## Features

- **Custom Overlay Portals**: Easily create overlays that can appear from the top, bottom, left, or right.
- **Interactive Popups**: Each overlay can contain interactive content such as buttons and text.
- **Animated Transitions**: Smooth animations for showing and hiding overlays.
- **Backdrop Blur**: Adds a blur effect to the background when an overlay is active.

## Getting Started

### Prerequisites

- Flutter SDK: Ensure you have Flutter installed on your machine. You can download it from [flutter.dev](https://flutter.dev).

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/custom_overlay_portal_demo.git
   cd custom_overlay_portal_demo
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

## Project Structure

- **main.dart**: Entry point of the application. Sets up the `MaterialApp` and home screen.
- **OverlayPortalDemo**: Main widget demonstrating various overlay use cases.
- **CustomOverlayPortal**: Widget that manages the display and animation of overlays.
- **CustomOverlayWrapper**: Handles the animation and interaction of the overlay content.

## Usage

- **Show Overlays**: Tap the buttons on the main screen to display overlays from different directions.
- **Hide Overlays**: Tap outside the overlay or use the provided buttons within the overlay to hide it.

## Customization

- **Overlay Content**: Modify the `_buildPopupContent` method in `OverlayPortalDemo` to change the content of the overlays.
- **Animation Duration**: Adjust the `AnimationController` duration in `CustomOverlayWrapper` for faster or slower animations.
- **Entry Direction**: Use the `entryDirection` property to change where the overlay appears from.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any enhancements or bug fixes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any questions or feedback, please contact [your email](mailto:youremail@example.com).

```
