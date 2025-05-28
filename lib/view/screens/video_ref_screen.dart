import 'package:flutter/material.dart';

class VideoRefScreen extends StatelessWidget {
  const VideoRefScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.video_library, size: 100, color: Colors.deepPurple),
          const SizedBox(height: 20),
          const Text(
            'YouTube Video Reference',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'For more information and resources, please visit our YouTube channel.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
