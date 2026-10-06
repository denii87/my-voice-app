import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F1318),
        textTheme: GoogleFonts.kantumruyProTextTheme(ThemeData.dark().textTheme),
      ),
      home: const AudioDubbingScreen(),
    );
  }
}

class AudioDubbingScreen extends StatefulWidget {
  const AudioDubbingScreen({super.key});

  @override
  State<AudioDubbingScreen> createState() => _AudioDubbingScreenState();
}

class _AudioDubbingScreenState extends State<AudioDubbingScreen> {
  double originalVolume = 0.0;
  double ttsVolume = 100.0;
  bool removeVocal = false;
  String selectedSpeaker = 'sreymom';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.bolt, color: Colors.cyanAccent),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('AI Dubbing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('នៅសល់ ...', style: TextStyle(fontSize: 12, color: Colors.greenAccent)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.download_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.g_translate_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.wb_sunny_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.info_outline), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'បកប្រែវីដេអូស្វ័យប្រវត្តិតាមរយៈ Edge TTS (ពិសិដ្ឋ & ស្រីមុំ)',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
            const SizedBox(height: 16),
            _buildFileCard(
              icon: Icons.video_file_rounded,
              iconColor: Colors.cyanAccent,
              title: 'វីដេអូដើម (Original Video)',
              subtitle: 'មិនទាន់ជ្រើសរើសវីដេអូនៅឡើយទេ',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _buildFileCard(
              icon: Icons.subtitles_rounded,
              iconColor: Colors.cyanAccent,
              title: 'ឯកសារអត្ថបទ (SRT Subtitles)',
              subtitle: 'មិនទាន់ជ្រើសរើសឯកសារ SRT នៅឡើយ...',
              onTap: () {},
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1B1E26),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.volume_up_rounded, color: Colors.cyanAccent, size: 20),
                      SizedBox(width: 8),
                      Text('កម្រិតសំឡេង (Volume Mixer)', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('សំឡេងដើម (Original)', style: TextStyle(color: Colors.white70)),
                      Text('${originalVolume.toInt()}%', style: const TextStyle(color: Colors.cyanAccent)),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Colors.cyanAccent,
                      activeTrackColor: Colors.cyanAccent,
                      inactiveTrackColor: Colors.white24,
                    ),
                    child: Slider(
                      value: originalVolume,
                      min: 0,
                      max: 100,
                      onChanged: (val) => setState(() => originalVolume = val),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('សំឡេងបកប្រែ (TTS)', style: TextStyle(color: Colors.white70)),
                      Text('${ttsVolume.toInt()}%', style: const TextStyle(color: Colors.cyanAccent)),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: const Color(0xFF6C63FF),
                      activeTrackColor: const Color(0xFF6C63FF),
                      inactiveTrackColor: Colors.white24,
                    ),
                    child: Slider(
                      value: ttsVolume,
                      min: 0,
                      max: 100,
                      onChanged: (val) => setState(() => ttsVolume = val),
                    ),
                  ),
                  const Divider(color: Colors.white12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('លុបសំឡេងច្រៀង/និយាយដើម', style: TextStyle(fontSize: 14)),
                          Text('Auto Remove Vocal (Stereo Only)', style: TextStyle(color: Colors.white38, fontSize: 11)),
                        ],
                      ),
                      Switch(
                        value: removeVocal,
                        activeColor: Colors.cyanAccent,
                        onChanged: (val) => setState(() => removeVocal = val),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1B1E26),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.person_pin_rounded, color: Colors.cyanAccent, size: 20),
                      SizedBox(width: 8),
                      Text('សំឡេងលំនាំដើម (Default Speaker)', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSpeakerButton(
                          id: 'sreymom',
                          name: 'ស្រីមុំ (Sreymom)',
                          gender: 'ស្រី (Female)',
                          isSelected: selectedSpeaker == 'sreymom',
                          onTap: () => setState(() => selectedSpeaker = 'sreymom'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSpeakerButton(
                          id: 'piseth',
                          name: 'ពិសិដ្ឋ (Piseth)',
                          gender: 'ប្រុស (Male)',
                          isSelected: selectedSpeaker == 'piseth',
                          onTap: () => setState(() => selectedSpeaker = 'piseth'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1B1E26),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white30, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeakerButton({
    required String id,
    required String name,
    required String gender,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF14171E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.cyanAccent : Colors.white10,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(Icons.face_rounded, color: isSelected ? Colors.cyanAccent : Colors.white54, size: 28),
            const SizedBox(height: 8),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isSelected ? Colors.white : Colors.white70)),
            const SizedBox(height: 2),
            Text(gender, style: const TextStyle(fontSize: 11, color: Colors.white38)),
          ],
        ),
      ),
    );
  }
}
