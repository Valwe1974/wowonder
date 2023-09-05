// import 'package:floating_action_bubble/floating_action_bubble.dart';
// import 'package:flutter/material.dart';

// class InmatedIconAdd extends StatefulWidget {
//   const InmatedIconAdd({super.key});

//   @override
//   State<InmatedIconAdd> createState() => _InmatedIconAddState();
// }

// class _InmatedIconAddState extends State<InmatedIconAdd>
//     with TickerProviderStateMixin {
//   late Animation<double> _animation;
//   late AnimationController _animationController;
//   bool _isPlay = false;
//   late AnimationController _controller;
//   @override
//   void initState() {
//     _controller =
//         AnimationController(duration: Duration(seconds: 1), vsync: this);
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 260),
//     );

//     final curvedAnimation =
//         CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
//     _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation:
//           FloatingActionButtonLocation.miniCenterDocked,

//       //Init Floating Action Bubble
//       floatingActionButton: FloatingActionBubble(
//         // Menu items
//         items: <Bubble>[
//           // Floating action menu item
//           Bubble(
//             title: "Settings",
//             iconColor: Colors.white,
//             bubbleColor: Colors.blue,
//             icon: Icons.settings,
//             titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//             onPress: () {
//               _animationController.reverse();
//             },
//           ),
//           // Floating action menu item
//           Bubble(
//             title: "Profile",
//             iconColor: Colors.white,
//             bubbleColor: Colors.blue,
//             icon: Icons.people,
//             titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//             onPress: () {
//               _animationController.reverse();
//             },
//           ),
//           //Floating action menu item
//           Bubble(
//             title: "Home",
//             iconColor: Colors.white,
//             bubbleColor: Colors.blue,
//             icon: Icons.home,
//             titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//             onPress: () {
//               Navigator.push(
//                   context,
//                   new MaterialPageRoute(
//                       builder: (BuildContext context) => Container()));
//               _animationController.reverse();
//             },
//           ),
//         ],

//         // animation controller
//         animation: _animation,

//         // On pressed change animation state
//         onPress: () => _animationController.isCompleted
//             ? _animationController.reverse()
//             : _animationController.forward(),

//         // Floating Action button Icon color
//         iconColor: Colors.blue,

//         // Flaoting Action button Icon
//         iconData: Icons.ac_unit,
//         backGroundColor: Colors.white,
//       ),
//     );
//   }
// }
// //  Center(
// //     child: GestureDetector(
// //       onTap: () {
// //         if (_isPlay == false) {
// //           _controller.forward();
// //           _isPlay = true;
// //         } else {
// //           _controller.reverse();
// //           _isPlay = false;
// //         }
// //       },
// //       child: AnimatedIcon(
// //         icon: AnimatedIcons.menu_close,
// //         progress: _controller,
// //         textDirection: TextDirection.ltr,
// //       ),
// //     ),
// //   );
