// import 'package:facecode/controller/pickImageCtr.dart';
// import 'package:facecode/providers/my_provider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// class PickImageWidget extends StatefulWidget {
//   const PickImageWidget({super.key});

//   @override
//   State<PickImageWidget> createState() => _ProfilePhotoState();
// }

// class _ProfilePhotoState extends State<PickImageWidget> {
//   Uint8List? _image;
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<MyProvider>(context);
//     return Center(
//       child: Stack(
//         children: [
//           _image != null
//               ? CircleAvatar(
//                   radius: 64,
//                   backgroundImage: MemoryImage(_image!),
//                 )
//               : CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   radius: 64,
//                   backgroundImage: AssetImage(
//                     "images/avatardefault.png",
//                   ),
//                 ),
//           Positioned(
//             bottom: -12,
//             left: 85,
//             child: IconButton(
//               onPressed: () async {
//                 Uint8List img = await PickImageCtr.pickImage(ImageSource.gallery);
//                 setState(() {
//                   _image = img;
//                   print(img);
//                 });
//               },
//               icon: Icon(
//                 color: provider.myTheme == ThemeMode.dark ? Colors.white : Color(0xFF2B2B2B),
//                 Icons.add_a_photo_sharp,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
