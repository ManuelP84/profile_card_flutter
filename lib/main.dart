import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Edit profile',
      home: EditProfileUI(),
    );
  }
}

class EditProfileUI extends StatefulWidget {
  const EditProfileUI({Key? key}) : super(key: key);
  @override
  State<EditProfileUI> createState() => _EditProfileUIState();
}

class _EditProfileUIState extends State<EditProfileUI> {
  String? documentTypeOption;
  final listTypeIdItems = ["CC", "CE"];
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ), onPressed: () {},
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {  },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Colors.white
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1)
                          )
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://wesofka.gointegro.com/scontent/1390/profile/6dfe9fc881c6d6e69873fe4703d46d9151d89bed?width=100&height=100'
                          )
                        )
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Colors.white
                          ),
                          color: Colors.blue
                        ),
                        child: InkWell(
                          onTap: () => {
                            showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet(context))
                            )
                          },
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(),
              buildTextField("Full name", "Manuel Pineda"),
              buildTextField("Rol", "Developer"),
              buildSelectField(),
              buildTextField("Document", "Document ID"),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal:  50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      child: const Text("DELETE", style: TextStyle(
                        fontSize: 17,
                        letterSpacing: 2,
                        color: Colors.black
                      )),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                      child: const Text("SAVE", style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white
                      )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /*
  * Input text Widget
  * */
  Widget buildTextField(String text, String placeHolder){
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: text,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          )
        ),
      ),
    );
  }

  /*
  * Selectable Widget
  * */
  Widget buildSelectField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DropdownButton<String>(
        hint: const Text("ID type"),
        value: documentTypeOption,
        iconSize: 36,
        isExpanded: true,
        style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
        ),
        onChanged: (newValue) {
          setState(() {
            documentTypeOption = newValue;
          });
        },
        items: listTypeIdItems.map((valueItem) {
          return DropdownMenuItem(
            value: valueItem,
            child: Text(valueItem),
          );
        }).toList(),
      )
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Select a Profile Photo",
            style: TextStyle(
                fontSize: 20
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
            ElevatedButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: const Text("Camera"),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: const Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  Future takePhoto(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
      );
      if (pickedFile == null) return;

      final file = File(pickedFile.path);
      setState(() {
        _imageFile = File(file.path);
      });
    } on PlatformException catch (e) {
      print("Failed to pick the picture! Sorry");
    }
  }
}







