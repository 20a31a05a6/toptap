import 'package:flutter/material.dart';
import 'package:flutter_camera_effects/flutter_camera_effects.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera SDK Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const CameraPage(),
    );
  }
}

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  final CameraSDK _cameraSDK = CameraSDK();
  bool _isCameraInitialized = false;
  bool _isRecording = false;
  Filter? _activeFilter;
  AREffect? _activeEffect;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraSDK.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle changes
    if (state == AppLifecycleState.inactive) {
      _cameraSDK.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    try {
      await _cameraSDK.init(
        options: const CameraOptions(
          resolution: CameraResolution.high,
          lens: CameraLens.back,
          enableFaceDetection: true,
          fps: 60,
        ),
      );

      // Listen for face detection events (optional)
      _cameraSDK.detectedFacesNotifier.addListener(() {
        // Handle detected faces if needed
      });

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      print('Failed to initialize camera: $e');
    }
  }

  Future<void> _takePhoto() async {
    try {
      final photo = await _cameraSDK.takePhoto(
        applyFilter: _activeFilter != null,
        applyAREffect: _activeEffect != null,
        saveToGallery: true,
      );
      
      // Display success message or preview
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Photo saved: ${photo.path}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to take photo: $e')),
      );
    }
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      try {
        final video = await _cameraSDK.stopVideoRecording(
          saveToGallery: true,
        );
        
        // Display success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Video saved: ${video.path}')),
        );
        
        setState(() {
          _isRecording = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to stop recording: $e')),
        );
      }
    } else {
      try {
        await _cameraSDK.startVideoRecording(
          applyFilter: _activeFilter != null,
          applyAREffect: _activeEffect != null,
          maxDuration: 30000, // 30 seconds
        );
        
        setState(() {
          _isRecording = true;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to start recording: $e')),
        );
      }
    }
  }

  Future<void> _switchCamera() async {
    try {
      await _cameraSDK.switchCamera();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to switch camera: $e')),
      );
    }
  }

  Future<void> _applyFilter(Filter filter) async {
    try {
      await _cameraSDK.applyFilter(filter);
      setState(() {
        _activeFilter = filter;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to apply filter: $e')),
      );
    }
  }

  Future<void> _clearFilter() async {
    try {
      await _cameraSDK.clearFilter();
      setState(() {
        _activeFilter = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to clear filter: $e')),
      );
    }
  }

  Future<void> _applyAREffect(AREffect effect) async {
    try {
      await _cameraSDK.applyAREffect(effect);
      setState(() {
        _activeEffect = effect;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to apply AR effect: $e')),
      );
    }
  }

  Future<void> _clearAREffect() async {
    try {
      await _cameraSDK.clearAREffect();
      setState(() {
        _activeEffect = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to clear AR effect: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isCameraInitialized
          ? Stack(
              children: [
                // Camera preview
                _cameraSDK.getPreviewWidget(
                  fit: BoxFit.cover,
                  enableFilters: true,
                  showFaceTracking: true,
                ),
                
                // Controls overlay
                SafeArea(
                  child: Column(
                    children: [
                      // Top controls
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: _switchCamera,
                              icon: const Icon(Icons.switch_camera, color: Colors.white, size: 30),
                            ),
                            IconButton(
                              onPressed: () {
                                // Toggle flash mode
                                // Implementation left as an exercise
                              },
                              icon: const Icon(Icons.flash_off, color: Colors.white, size: 30),
                            ),
                          ],
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Filter selector
                      SizedBox(
                        height: 100,
                        child: _cameraSDK.controller != null
                            ? FilterSelector(
                                controller: _cameraSDK.controller!,
                                onFilterSelected: (filter) {
                                  setState(() {
                                    _activeFilter = filter;
                                  });
                                },
                              )
                            : Container(),
                      ),
                      
                      // Bottom controls
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // AR Effects button
                            IconButton(
                              onPressed: () {
                                _showAREffectsModal();
                              },
                              icon: Icon(
                                Icons.face,
                                color: _activeEffect != null ? Colors.blue : Colors.white,
                                size: 30,
                              ),
                            ),
                            
                            // Capture button
                            GestureDetector(
                              onTap: _isRecording ? _toggleRecording : _takePhoto,
                              onLongPress: !_isRecording ? _toggleRecording : null,
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _isRecording ? Colors.red : Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                                child: _isRecording
                                    ? const Center(child: Icon(Icons.stop, color: Colors.white))
                                    : null,
                              ),
                            ),
                            
                            // Gallery button (placeholder)
                            IconButton(
                              onPressed: () {
                                // Open gallery functionality
                                // Implementation left as an exercise
                              },
                              icon: const Icon(Icons.photo_library, color: Colors.white, size: 30),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void _showAREffectsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('AR Effects', style: Theme.of(context).textTheme.titleLarge),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    // No effect option
                    _buildAREffectItem(
                      title: 'None',
                      icon: Icons.face_outlined,
                      onTap: _clearAREffect,
                      isActive: _activeEffect == null,
                    ),
                    
                    // Dog mask effect
                    _buildAREffectItem(
                      title: 'Dog',
                      icon: Icons.pets,
                      onTap: () => _applyAREffect(PresetAREffects.dogMask),
                      isActive: _activeEffect?.id == PresetAREffects.dogMask.id,
                    ),
                    
                    // Cat mask effect
                    _buildAREffectItem(
                      title: 'Cat',
                      icon: Icons.catching_pokemon,
                      onTap: () => _applyAREffect(PresetAREffects.catMask),
                      isActive: _activeEffect?.id == PresetAREffects.catMask.id,
                    ),
                    
                    // Beauty effect
                    _buildAREffectItem(
                      title: 'Beauty',
                      icon: Icons.face_retouching_natural,
                      onTap: () => _applyAREffect(PresetAREffects.beautyBasic),
                      isActive: _activeEffect?.id == PresetAREffects.beautyBasic.id,
                    ),
                    
                    // Beauty+ effect
                    _buildAREffectItem(
                      title: 'Beauty+',
                      icon: Icons.face_retouching_natural,
                      onTap: () => _applyAREffect(PresetAREffects.beautyPlus),
                      isActive: _activeEffect?.id == PresetAREffects.beautyPlus.id,
                    ),
                    
                    // Bulge effect
                    _buildAREffectItem(
                      title: 'Bulge',
                      icon: Icons.bubble_chart,
                      onTap: () => _applyAREffect(PresetAREffects.bulgeEffect),
                      isActive: _activeEffect?.id == PresetAREffects.bulgeEffect.id,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAREffectItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: isActive ? Colors.blue : Colors.white),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(color: isActive ? Colors.blue : Colors.white)),
          ],
        ),
      ),
    );
  }
} 