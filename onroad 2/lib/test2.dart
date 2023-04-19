// import 'package:flutter/material.dart';
// import 'package:onroad/global/global.dart';
// import 'package:onroad/mainScreens/main_screens.dart';
//
// class ServicesTabPageTest extends StatefulWidget {
//   const ServicesTabPageTest({super.key});
//
//   @override
//   State<ServicesTabPageTest> createState() => _ServicesTabPageTestState();
// }
//
// class _ServicesTabPageTestState extends State<ServicesTabPageTest> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (c) => const MainScreen()));
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_rounded,
//             color: Colors.black,
//           ),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.all(14.0),
//             child: Text(
//               'Services',
//               style: TextStyle(
//                 fontSize: 25,
//                 fontFamily: 'Brand Bold',
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//         elevation: 0,
//       ),
//       body: ListView.builder(
//         itemCount: dList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Card(
//             color: Colors.white70,
//             elevation: 3,
//             shadowColor: Colors.black38,
//             margin: const EdgeInsets.all(8),
//             child: ListTile(
//               leading: const Padding(
//                 padding:  EdgeInsets.all(8.0),
//                 // child: Image.asset(
//                 //   "image/user.png",
//                 //   width: 20,
//                 // ),
//               ),
//               title: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     dList[index]["fname"] +" "+ dList[index]["lname"],
//                     style: const TextStyle(fontSize: 14, color: Colors.black87),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
