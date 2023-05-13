import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghmcofficerslogin/res/components/showtoast.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ImageViewPage extends StatefulWidget {
  final String filePath;
  final String filename;
  const ImageViewPage({
    super.key,
    required this.filePath,
    required this.filename,
  });

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.download, color: Colors.black),
            onPressed: () {
              downloadFile();
              print('${widget.filename}');
              print('${widget.filePath}');
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (() {
              Navigator.of(context).pop();
            })
            ),
        title: Center(
          child: Text(
            "Pdf",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: SfPdfViewer.network(
          widget.filePath
            // 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: shareFile,
        child: Icon(Icons.share),
      ),
    );
  }

  void downloadFile() async {
    if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
    }
    if (Platform.isAndroid) {
     /*  var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      } */
      //if (status.isGranted) {
        var filepath = "/storage/emulated/0/Download/pdf-${widget.filename}";
        var file = File(filepath);
        var res = await get(Uri.parse("${widget.filePath}"));
        file.writeAsBytes(res.bodyBytes);
        ShowToats.showToast("Download Successful",bgcolor: Colors.black, textcolor: Colors.white, gravity: ToastGravity.CENTER);
      //}
    }
  }

  void shareFile() async {
    var filepath;
    var file;
    //var file = await FilePicker.platform.pickFiles();
    //List<XFile>? files = file?.files.map((e) => e.path.toString()).cast<XFile>().toList();
   /*  List<XFile> files = file!.files.map((e) => XFile(e.path!)).cast<XFile>().toList();
    if(files == null) return;
    await Share.shareXFiles(files); */
    //await Share.shareFiles([file!.paths[0]!]);
    if (Platform.isAndroid) {
     /*  var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      } */
     // if (status.isGranted) {
         filepath = "/storage/emulated/0/Download/pdf-${widget.filename}";
        file = File(filepath);
        var res = await get(Uri.parse("${widget.filePath}"));
        file.writeAsBytes(res.bodyBytes);
        ShowToats.showToast("Download Successful",bgcolor: Colors.black, textcolor: Colors.white, gravity: ToastGravity.CENTER);
      //}
    }
     await Share.shareXFiles(
                      [XFile(filepath)],);
    // await Share.shareFiles([filepath]);
  }
}