import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoRefScreen extends StatefulWidget {
  const VideoRefScreen({super.key});

  @override
  State<VideoRefScreen> createState() => _VideoRefScreenState();
}

class _VideoRefScreenState extends State<VideoRefScreen> {
  final List<Map<String, String>> youtubeVideos = [
    {
      'title': 'Overcome Anxiety – Motivation',
      'url': 'https://youtu.be/xRxT9cOKiM8',
      'thumbnail': 'https://img.youtube.com/vi/xRxT9cOKiM8/0.jpg',
    },
    {
      'title': 'Self Discipline – Daily Motivation',
      'url': 'https://youtu.be/1dbYduxIpwE',
      'thumbnail': 'https://img.youtube.com/vi/1dbYduxIpwE/0.jpg',
    },
    {
      'title': 'Focus Like a Monk – Motivation',
      'url': 'https://youtu.be/hAkgumAMOIg',
      'thumbnail': 'https://img.youtube.com/vi/hAkgumAMOIg/0.jpg',
    },
    {
      'title': 'Believe in Yourself – Uplifting',
      'url': 'https://youtu.be/H_uc-uQ3Nkc',
      'thumbnail': 'https://img.youtube.com/vi/H_uc-uQ3Nkc/0.jpg',
    },
  ];

  final List<Map<String, String>> activities = [
    {
      'text': 'Take a deep breath and relax.',
      'image':
          'https://images.pexels.com/photos/3759657/pexels-photo-3759657.jpeg?auto=compress&w=800',
    },
    {
      'text': 'Try 5 minutes of silent meditation.',
      'image':
          'https://images.pexels.com/photos/3822622/pexels-photo-3822622.jpeg?auto=compress&w=800',
    },
    {
      'text': 'Write 3 things you’re grateful for.',
      'image':
          'https://images.pexels.com/photos/636243/pexels-photo-636243.jpeg?auto=compress&w=800',
    },
  ];

  late Map<String, String> currentVideo;
  late Map<String, String> currentActivity;
  bool showAllVideos = false;
  bool showAllActivities = false;

  @override
  void initState() {
    super.initState();
    final random = Random();
    currentVideo =
        youtubeVideos.isNotEmpty
            ? youtubeVideos[random.nextInt(youtubeVideos.length)]
            : {};
    currentActivity =
        activities.isNotEmpty
            ? activities[random.nextInt(activities.length)]
            : {};
  }

  void _launchVideo(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _shuffleSuggestions() {
    final random = Random();
    setState(() {
      currentVideo =
          youtubeVideos.isNotEmpty
              ? youtubeVideos[random.nextInt(youtubeVideos.length)]
              : {};
      currentActivity =
          activities.isNotEmpty
              ? activities[random.nextInt(activities.length)]
              : {};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 40,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Motivational Space',
                style: TextStyle(color: Colors.white),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.indigo],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: _shuffleSuggestions,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video Section Heading
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Motivational Videos',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  _buildVideoCard(currentVideo),
                  if (showAllVideos)
                    ...youtubeVideos.map(
                      (video) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildVideoCard(video),
                      ),
                    ),
                  TextButton.icon(
                    onPressed:
                        () => setState(() => showAllVideos = !showAllVideos),
                    icon: Icon(
                      showAllVideos
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                    label: Text(
                      showAllVideos ? 'Show Less Videos' : 'Show More Videos',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Activities Section Heading
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Mindful Activities',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  if (showAllActivities)
                    ...activities.map(
                      (activity) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildActivityCard(activity),
                      ),
                    )
                  else
                    _buildActivityCard(currentActivity),
                  TextButton.icon(
                    onPressed:
                        () => setState(
                          () => showAllActivities = !showAllActivities,
                        ),
                    icon: Icon(
                      showAllActivities
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                    label: Text(
                      showAllActivities
                          ? 'Show Less Activities'
                          : 'Show More Activities',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(Map<String, String> video) {
    return GestureDetector(
      onTap: () => _launchVideo(video['url']!),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                video['thumbnail']!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                video['title']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(Map<String, String> activity) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              activity['image']!,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              activity['text']!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
