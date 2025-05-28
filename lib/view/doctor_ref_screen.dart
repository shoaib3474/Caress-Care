import 'package:flutter/material.dart';

class DoctorRefScreen extends StatelessWidget {
  const DoctorRefScreen({super.key});

  final List<Map<String, String>> dummyDoctors = const [
    {
      "name": "Dr. Sarah Ali",
      "specialization": "Psychiatrist",
      "contact": "+92 300 1234567",
      "image":
          "https://img.freepik.com/free-photo/portrait-smiling-handsome-doctor-man_171337-5055.jpg",
    },
    {
      "name": "Dr. Hamza Khan",
      "specialization": "Clinical Psychologist",
      "contact": "+92 345 9876543",
      "image":
          "https://img.freepik.com/premium-photo/portrait-doctor_103420-211.jpg",
    },
    {
      "name": "Dr. Ayesha Noor",
      "specialization": "Therapist",
      "contact": "+92 333 4567890",
      "image":
          "https://img.freepik.com/free-photo/female-doctor-holding-stethoscope-her-hands-hospital_1303-17840.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor Reference"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE1BEE7), Color(0xFFBA68C8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: dummyDoctors.length,
          itemBuilder: (context, index) {
            final doctor = dummyDoctors[index];
            return Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(doctor["image"]!),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor["name"]!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doctor["specialization"]!,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doctor["contact"]!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
