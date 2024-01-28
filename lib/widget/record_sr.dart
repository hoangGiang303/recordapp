import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class RecordSr extends StatefulWidget {
  const RecordSr({super.key});

  @override
  State<RecordSr> createState() => _RecordSrState();
}

class _RecordSrState extends State<RecordSr> {
  Future<String> _getAppDocumentsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _startRecording() async {
    try {

      // Lấy đường dẫn thư mục ứng dụng
      final appDocDir = await _getAppDocumentsDirectory();

      // Tạo đường dẫn đầy đủ cho output
      final String output = '$appDocDir/output.mp4';

      // Sử dụng FFmpegKit để ghi màn hình và âm thanh
      final String command =
          '-f android_camera -i /dev/video0 -c:v mpeg4 -b:v 500k -c:a aac $output';
      await FFmpegKit.executeAsync(command, (session) {
        // Xử lý kết quả nếu cần thiết
      });
    } catch (e) {
      print('FFmpeg execution failed. Details: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Record"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _startRecording,
          child: const Text('Start Recording'),
        ),
      ),
    );
  }
}
