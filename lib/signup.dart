import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cinemagicx/raju.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:pinput/pinput.dart';

class MySignUp extends StatefulWidget {
  MySignUp({
    super.key,
  });

  @override
  State<MySignUp> createState() => _MySignUpState();
}

// 005EEA border 0381E9 btn

class _MySignUpState extends State<MySignUp> {
  bool isclick = false;
  final picker = ImagePicker();
  File? profilepic;

  final TextEditingController _textEditingController = TextEditingController();
  Future<void> pickImagex(String imgx) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    final dg = await pickedImage?.readAsBytes();

    Uint8List cx = dg != null ? dg : Uint8List(0);

    print(await uploadfile(cx));

    if (pickedImage != null) {
      setState(() {
        print(pickedImage.path);

        switch (imgx) {
          case 'profilepic':
            profilepic = File(pickedImage.path);
            break;
        }
      });
    }
  }

  // Future<void> uploadImage(File file) async {
  //   final Uri serverUri = Uri.parse("$backendurl/upload");
  // final http.MultipartRequest request =
  //     http.MultipartRequest('POST', serverUri);

  //   request.files.add(await http.MultipartFile.fromPath('file', file.path));

  //   try {
  //     final http.Response response =
  //         await http.Response.fromStream(await request.send());
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //   } catch (error) {
  //     print('Error uploading image: $error');
  //   }
  // }

  Future<String?> uploadfile(Uint8List bytes,
      {String fileName = "x.jpg"}) async {
    const url = '$backendurl/upload';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    var filey = http.MultipartFile.fromBytes("file", bytes, filename: fileName);

    request.files.add(filey);

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final up = jsonDecode(await response.stream.bytesToString());
        return up["name"];
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 120,
                width: 120,
                child: Stack(
                  children: [
                    profilepic != null
                        ? kIsWeb
                            ? Image.network(
                                profilepic!.path,
                                width: 80,
                                height: 80,
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                profilepic!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.fill,
                              )
                        : const ClipOval(
                            child: Image(
                              image: AssetImage("assets/bnr.png"),
                              width: 120,
                              height: 120,
                              fit: BoxFit.fill,
                            ),
                          ),
                    Positioned(
                        top: 80,
                        left: 80,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            pickImagex("profilepic");
                          },
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Name :",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 38, 15, 240)),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 38, 15, 240)),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "e.g:rajahasda@gmail.com",
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 120, 118, 110))),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Email ID :",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 38, 15, 240)),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 38, 15, 240)),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "e.g:rajahasda@gmail.com",
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 120, 118, 110))),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Phone Number :",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 38, 15, 240)),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 38, 15, 240)),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "e.g:+91 00000000",
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 120, 118, 110))),
            ),
          ]),
    ));
  }
}
