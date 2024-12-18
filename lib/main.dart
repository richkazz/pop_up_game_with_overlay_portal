import 'package:flutter/material.dart';
import 'custom_overlay_portal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CustomOverlayPortal Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OverlayPortalDemo(),
    );
  }
}

class OverlayPortalDemo extends StatefulWidget {
  const OverlayPortalDemo({super.key});

  @override
  State<OverlayPortalDemo> createState() => _OverlayPortalDemoState();
}

class _OverlayPortalDemoState extends State<OverlayPortalDemo> {
  final topController = CustomOverLayPortalController();
  final bottomController = CustomOverLayPortalController();
  final leftController = CustomOverLayPortalController();
  final rightController = CustomOverLayPortalController();
  final centerController = CustomOverLayPortalController();
  final bottomSheetController = CustomOverLayPortalController();
  final drawerUseCaseController = CustomOverLayPortalController();

  Widget _buildPopupContent(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          const Text(
            'This is a popup content example',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomOverlayPortal Demo'),
        leading: CustomOverlayPortal(
          controller: drawerUseCaseController,
          entryDirection: CustomOverlayEntryDirection.left,
          alignment: Alignment.topLeft,
          popUpContent: SizedBox(
              width: 200,
              height: 600,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      drawerUseCaseController.hide();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Help'),
                    onTap: () {
                      drawerUseCaseController.hide();
                    },
                  ),
                ],
              )),
          child: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => drawerUseCaseController.show(),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top aligned overlay
            CustomOverlayPortal(
              controller: topController,
              entryDirection: CustomOverlayEntryDirection.top,
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 20),
              popUpContent: _buildPopupContent('Top Popup'),
              child: ElevatedButton(
                onPressed: () => topController.show(),
                child: const Text('Show Top Overlay'),
              ),
            ),
            const SizedBox(height: 20),

            // Left and Right overlays in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomOverlayPortal(
                  controller: leftController,
                  entryDirection: CustomOverlayEntryDirection.left,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  popUpContent: _buildPopupContent('Left Popup'),
                  child: ElevatedButton(
                    onPressed: () => leftController.show(),
                    child: const Text('Show Left'),
                  ),
                ),
                const SizedBox(width: 40),
                CustomOverlayPortal(
                  controller: rightController,
                  entryDirection: CustomOverlayEntryDirection.right,
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 20),
                  popUpContent: _buildPopupContent('Right Popup'),
                  child: ElevatedButton(
                    onPressed: () => rightController.show(),
                    child: const Text('Show Right'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Bottom aligned overlay
            CustomOverlayPortal(
              controller: bottomController,
              entryDirection: CustomOverlayEntryDirection.bottom,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 20),
              popUpContent: _buildPopupContent('Bottom Popup'),
              child: ElevatedButton(
                onPressed: () => bottomController.show(),
                child: const Text('Show Bottom Overlay'),
              ),
            ),
            const SizedBox(height: 20),

            // Center aligned overlay
            CustomOverlayPortal(
              controller: centerController,
              entryDirection: CustomOverlayEntryDirection.top,
              alignment: Alignment.center,
              popUpContent: _buildPopupContent('Center Popup'),
              child: ElevatedButton(
                onPressed: () => centerController.show(),
                child: const Text('Show Center Overlay'),
              ),
            ),
            const SizedBox(height: 20),

            // Bottom sheet
            CustomOverlayPortal(
              controller: bottomSheetController,
              entryDirection: CustomOverlayEntryDirection.bottom,
              alignment: Alignment.bottomCenter,
              popUpContent: SizedBox(
                width: double.infinity,
                height: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Bottom Sheet'),
                    ElevatedButton(
                        onPressed: () {
                          bottomSheetController.hide();
                        },
                        child: Text('Hide Bottom Sheet')),
                  ],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  bottomSheetController.show();
                },
                child: const Text('Show Bottom Sheet'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    topController.dispose();
    bottomController.dispose();
    leftController.dispose();
    rightController.dispose();
    centerController.dispose();
    bottomSheetController.dispose();
    drawerUseCaseController.dispose();
    super.dispose();
  }
}
