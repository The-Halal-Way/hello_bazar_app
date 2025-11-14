import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class CmFilePicker extends StatefulWidget {
  const CmFilePicker(
      {super.key, required this.label, required this.onFilePick});
  final String label;
  final Function onFilePick;
  @override
  State<CmFilePicker> createState() => _CmFilePickerState();
}

class _CmFilePickerState extends State<CmFilePicker> {
  FilePickerResult? _result1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // add button, box, fileName, fileType
    return Row(
      children: [
        // section title
        SizedBox(
          width: size.width * .4,
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        // file-box & file name at bottom
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.white30,
                      Color(0xB3FFFFFF),
                      Color(0x62FFFFFF)
                    ],
                  ),
                  //boxShadow: CmRepo.bodyShadow,
                  border: Border.all(color: MyColor.gray500),
                ),
                child: Center(
                  child: Text(
                    "${_getName(_result1)}.${_getExtension(_result1)}",
                    style: TextStyle(fontSize: _result1 != null ? 25 : 12),
                  ),
                ),
              ),
              Positioned(
                bottom: -5,
                right: -8,
                child: OutlinedButton(
                  onPressed: () => _pickFile(context),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF01204E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _pickFile(BuildContext context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(onFileLoading: (_) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Text('Uploading please wait!'),
        backgroundColor: (Colors.black45),
      ));
    });
    if (result != null) {
      // final pickedFile = File(result.files.single.path!);
      // final file = result.files.first;
      // print("size: ${file.size}");
      // print("size: ${file.extension}");
      // print("size: ${file.path}");
      // ignore: use_build_context_synchronously

      _result1 = result;
      setState(() {});
      widget.onFilePick(File(result.files.single.path!));
    }
  }

  String _getName(FilePickerResult? result) {
    if (result == null) {
      return "";
    } else {
      return result.files.first.name;
    }
  }

  String _getExtension(FilePickerResult? result) {
    if (result == null) {
      return "No File added yet!";
    } else {
      return ".${result.files.first.extension!}";
    }
  }
}
