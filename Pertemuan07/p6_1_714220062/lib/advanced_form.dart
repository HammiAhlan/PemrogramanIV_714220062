import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class AdvancedForm extends StatefulWidget {
  const AdvancedForm({super.key});

  @override
  State<AdvancedForm> createState() => _AdvancedFormState();
}

class _AdvancedFormState extends State<AdvancedForm> {
  DateTime _dueDate = DateTime.now();
  final currentDate = DateTime.now();
  Color _currentColor = Colors.orange;
  String? _dataFile;
  File? _imageFile;

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    
    final file =  result.files.first;
    
    if (file.extension == 'jpg' ||
        file.extension == 'png' ||
        file.extension == 'jpeg'){
          setState(() {
            _imageFile = File(file.path!);
            
          });
        }

    _openFile(file);

    setState(() {
      
      _dataFile = file.name;
    });
  }

  void _openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
  void _selectDueDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(currentDate.year + 5),
    );
    if (selectedDate != null) {
      setState(() {
        _dueDate = selectedDate;
      });
    }
  }

  Widget buildDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Date'),
            TextButton(
              child: const Text('Select'),
              onPressed: _selectDueDate,
            ),
          ],
        ),
        Text(DateFormat('dd-MM-yyyy').format(_dueDate)),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Color'),
      const SizedBox(height: 10),
      Container(
        height: 100,
        width: double.infinity,
        color: _currentColor,
      ),
      const SizedBox(height: 10),
      Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _currentColor,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Pick your color'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: _currentColor,
                      onColorChanged: (color) {
                        setState(() {
                          _currentColor = color;
                        });
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Save'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Pick Color'),
        ),
      ),
    ],
  );
}
Widget buildFilePicker(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Pick File'),
      const SizedBox(height: 10),
      Center(
        child: ElevatedButton(
          onPressed: () {
            _pickFile();
          },
          child: const Text('Pick and Open File'),
        ), 
      ), 
      if (_dataFile != null) Text('File Name: $_dataFile'),
        const SizedBox(height: 10),

        if (_imageFile != null)
          Image.file(
            _imageFile!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          )
    ],
  ); 
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Widget'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildDatePicker(context),
            const SizedBox(height: 20),
            buildColorPicker(context),
            buildFilePicker(context),
            const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}