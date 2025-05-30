// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class DoctorRefScreen extends StatelessWidget {
  const DoctorRefScreen({super.key});

  static const List<Map<String, String>> dummyDoctors = [
    {
      "name": "Dr. Sarah Ali",
      "specialization": "Psychiatrist",
      "contact": "+92 300 1234567",
      "image":
          "https://media.istockphoto.com/id/1861987838/photo/smiling-female-doctor-looking-at-camera-in-the-medical-consultation.webp?a=1&b=1&s=612x612&w=0&k=20&c=um_usOsshRUn1qaLFF-5wyD9u_A4Wj2BhOFW2xsrkJ8=",
      "experience": "12 years",
      "hospital": "City Hospital, Lahore",
      "about":
          "Expert in anxiety, depression, and mood disorders. Empathetic listener and CBT specialist.",
    },
    {
      "name": "Dr. Hamza Khan",
      "specialization": "Clinical Psychologist",
      "contact": "+92 345 9876543",
      "image":
          "https://plus.unsplash.com/premium_photo-1661634265749-20267b28e13d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8bWFsZSUyMGRvY3RvcnxlbnwwfHwwfHx8MA%3D%3D",
      "experience": "8 years",
      "hospital": "Mind Care Clinic, Karachi",
      "about":
          "Specializes in adolescent therapy and stress management. Uses modern therapy techniques.",
    },
    {
      "name": "Dr. Ayesha Noor",
      "specialization": "Therapist",
      "contact": "+92 333 4567890",
      "image":
          "https://images.unsplash.com/photo-1638202993928-7267aad84c31?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8ZmVtYWxlJTIwZG9jdG9yfGVufDB8fDB8fHww",
      "experience": "10 years",
      "hospital": "Wellness Center, Islamabad",
      "about":
          "Focus on family counseling and trauma recovery. Known for her compassionate approach.",
    },
    {
      "name": "Dr. Bilal Ahmed",
      "specialization": "Psychiatrist",
      "contact": "+92 321 1122334",
      "image":
          "https://images.unsplash.com/photo-1612531386530-97286d97c2d2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFsZSUyMGRvY3RvcnxlbnwwfHwwfHx8MA%3D%3D",
      "experience": "15 years",
      "hospital": "Punjab Medical Complex, Lahore",
      "about":
          "Renowned for treating severe mental illnesses and addiction recovery.",
    },
    {
      "name": "Dr. Maria Siddiqui",
      "specialization": "Clinical Psychologist",
      "contact": "+92 300 9988776",
      "image":
          "https://images.unsplash.com/photo-1659353888906-adb3e0041693?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8ZmVtYWxlJTIwZG9jdG9yfGVufDB8fDB8fHww",
      "experience": "7 years",
      "hospital": "Hope Clinic, Karachi",
      "about": "Expert in cognitive behavioral therapy and mindfulness.",
    },
    {
      "name": "Dr. Usman Tariq",
      "specialization": "Therapist",
      "contact": "+92 322 3344556",
      "image":
          "https://plus.unsplash.com/premium_photo-1664476459351-59625a0fef11?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bWFsZSUyMGRvY3RvcnxlbnwwfHwwfHx8MA%3D%3D",
      "experience": "9 years",
      "hospital": "Peace Hospital, Multan",
      "about": "Focuses on relationship counseling and anger management.",
    },
    {
      "name": "Dr. Sana Javed",
      "specialization": "Psychiatrist",
      "contact": "+92 301 4455667",
      "image":
          "https://media.istockphoto.com/id/1962812776/photo/portrait-of-smiling-female-doctor-at-medical-clinic-looking-at-camera.webp?a=1&b=1&s=612x612&w=0&k=20&c=cv_EpcSp17R6JXw04QK1BtUV9w_h6rMuvFgAeaJXVQY=",
      "experience": "11 years",
      "hospital": "Shifa International, Islamabad",
      "about":
          "Specializes in women’s mental health and postpartum depression.",
    },
  ];

  void _launchCaller(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    // Request permission
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
    }

    if (status.isGranted) {
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar("Error", "Cannot open dialer for this number.");
      }
    } else {
      Get.snackbar("Permission Denied", "Phone call permission is required.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF7B2FF7), Color(0xFFF357A8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    "Doctor Reference",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7B2FF7), Color(0xFFfbc2eb)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: dummyDoctors.length,
          itemBuilder: (context, index) {
            final doctor = dummyDoctors[index];
            return Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 18),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            doctor["image"] ?? "",
                            width: 70,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  width: 70,
                                  height: 90,
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.person,
                                    size: 38,
                                    color: Colors.grey,
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor["name"] ?? "",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF7B2FF7),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                doctor["specialization"] ?? "",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF9F44D3),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.work,
                                    size: 15,
                                    color: Colors.indigo,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    doctor["experience"] ?? "",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.local_hospital,
                                    size: 15,
                                    color: Colors.pink,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      doctor["hospital"] ?? "",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                doctor["about"] ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap:
                                    () =>
                                        _launchCaller(doctor["contact"] ?? ""),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF7B2FF7,
                                    ).withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        size: 18,
                                        color: Color(0xFF7B2FF7),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        doctor["contact"] ?? "",
                                        style: const TextStyle(
                                          color: Color(0xFF7B2FF7),
                                          letterSpacing: 1,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
