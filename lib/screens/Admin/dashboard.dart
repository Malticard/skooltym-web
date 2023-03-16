// import 'dart:convert';

// import '/exports/exports.dart';

// ///  Created by bruno on 15/02/2023.
// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});

//   @override
//   _DashboardState createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard>
//     with SingleTickerProviderStateMixin {
//   AnimationController? _dashboardController;

//   @override
//   void initState() {
//     _dashboardController = AnimationController(
//         vsync: this, value: 0, duration: const Duration(milliseconds: 1000));
//     _dashboardController!.forward();
//     // register user session after loginning
//     registerUserSession();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // _dashboardController!.dispose();
//     super.dispose();
//   }

//   registerUserSession() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(
//         "token", "${context.read<SchoolController>().state['_token']}");
//     prefs.setString(
//         'role', "${context.read<SchoolController>().state['role']}");
//   }

//   bool _isShowDial = false;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       floatingActionButton: (Responsive.isDesktop(context) || kIsWeb)
//           ? null
//           : _getFloatingActionButton(),
//     );
//   }

//   Widget _buildSidebar(BuildContext context) {
    
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
        
//         const SizedBox(height: 15), // Padding(// Padding(
//         //   padding: const EdgeInsets.symmetric(horizontal: 10),
//         //   child: _MainMenu(onSelected: controller.onSelectedMainMenu),
//         // )
//         //   padding: const EdgeInsets.symmetric(horizontal: 10),
//         //   child: _MainMenu(onSelected: controller.onSelectedMainMenu),
//         // )// Padding(
//         //   padding: const EdgeInsets.symmetric(horizontal: 10),
//         //   child: _MainMenu(onSelected: controller.onSelectedMainMenu),
//         // )
//         // Padding(
//         //   padding: const EdgeInsets.symmetric(horizontal: 10),
//         //   child: _MainMenu(onSelected: controller.onSelectedMainMenu),
//         // ),

//         const SizedBox(height: kSpacing),
//         Padding(
//           padding: const EdgeInsets.all(kSpacing),
//           child: Text(
//             "Powered by Malticard",
//             style: Theme.of(context).textTheme.caption,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBody({Function()? onPressedMenu}) {
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: kSpacing),
//       child: Column(
//         children: [
//           const SizedBox(height: kSpacing),
//           Row(
//             children: [
//               if (onPressedMenu != null)
//                 Padding(
//                   padding: const EdgeInsets.only(right: kSpacing / 2),
//                   child: IconButton(
//                     onPressed: onPressedMenu,
//                     icon: const Icon(Icons.menu),
//                   ),
//                 ),
//               Expanded(
//                 child: SearchField(
//                   hintText: "Search Task .. ",
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: kSpacing),
//           Row(
//             children: [
//               const SizedBox(width: kSpacing / 2),
//               SizedBox(
//                 width: size.width,
//                 child: FutureBuilder(
//                     future: fetchDashboardMetaData(),
//                     builder: (context, snapshot) {
//                       var data = snapshot.data ?? [];
//                       return snapshot.connectionState == ConnectionState.waiting
//                           ? Center(child: Loader(text: "Dashboard"))
//                           : snapshot.hasData
//                               ? SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: Row(
//                                     children: List.generate(
//                                       data.length,
//                                       (index) => SizedBox(
//                                         width: size.width * 0.123,
//                                         height: size.width * 0.123,
//                                         child: DashboardCard(
//                                           label: data[index]['label'],
//                                           value: data[index]['value'],
//                                           icon: data[index]['icon'],
//                                           color: data[index]['color'],
//                                           last_updated: data[index]
//                                               ['last_updated'],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               : Center(
//                                   child: Text("No Data"),
//                                 );
//                     }),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _getFloatingActionButton() {
//     List<Map<String, dynamic>> options = [
//       {
//         "icon": "assets/icons/003-student.svg",
//         "route": Routes.newStudent,
//       },
//       {
//         "icon": "assets/icons/002-add-group.svg",
//         "route": Routes.newStaff,
//       },
//       {
//         "icon": "assets/images/guardian.svg",
//         "route": Routes.newGuardian,
//       }
//     ];
//     return SpeedDialMenuButton(
//       //if needed to close the menu after clicking sub-FAB
//       isShowSpeedDial: _isShowDial,
//       //manually open or close menu
//       updateSpeedDialStatus: (isShow) {
//         //return any open or close change within the widget
//         _isShowDial = isShow;
//       },
//       //general init
//       isMainFABMini: false,
//       mainMenuFloatingActionButton: MainMenuFloatingActionButton(
//           mini: false,
//           child: Icon(Icons.add),
//           onPressed: () {},
//           elevation: 4,
//           closeMenuChild: Icon(Icons.close),
//           closeMenuForegroundColor: Colors.white,
//           closeMenuBackgroundColor: Colors.blue),
//       floatingActionButtonWidgetChildren: List.generate(
//         options.length,
//         (index) => FloatingActionButton(
//           heroTag: null,
//           // mini: true,
//           // label: Text(options[index]['title']),
//           child: SvgPicture.asset(
//             options[index]['icon'],
//             color: Colors.white,
//             width: 20,
//             height: 20,
//           ),
//           onPressed: () {
//             //if need to toggle menu after click
//             _isShowDial = !_isShowDial;
//             setState(() {});
//             Routes.namedRoute(context, options[index]['route']);
//           },
//           backgroundColor: Colors.blue,
//         ),
//       ),
//       isSpeedDialFABsMini: true,
//       paddingBtwSpeedDialButton: 40.0,
//     );
//   }
// }

// class MobileView extends StatefulWidget {
//   const MobileView({super.key});

//   @override
//   State<MobileView> createState() => _MobileViewState();
// }

// class _MobileViewState extends State<MobileView> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CommonAppbarView(
//           titleTextSize: 30,
//           titlePadding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 3),
//           headerWidget: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(0.0),
//                 child: Text(
//                   "${greetUser()} ${context.read<SchoolController>().state['lname']},",
//                   style: TextStyles(context).getRegularStyle().copyWith(
//                         fontSize: 19,
//                         fontWeight: FontWeight.w400,
//                       ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     right: 5.0, top: 5, left: 5, bottom: 5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     IconButton(
//                       iconSize: 35,
//                       icon:
//                           // context
//                           //             .read<SchoolController>()
//                           //             .state['role'] ==
//                           //         null
//                           SvgPicture.asset(
//                         "assets/icons/006-user.svg",
//                         fit: BoxFit.cover,
//                       ),
//                       // : Image.memory(jsonDecode(context
//                       //     .read<SchoolController>()
//                       //     .state['profile_pic'])),
//                       onPressed: () =>
//                           Routes.namedRoute(context, Routes.profile),
//                     ),
//                     PopupMenuButton<PopUpOptions>(
//                       icon: Iconify(
//                         slidersIcon,
//                         color: Theme.of(context).brightness == Brightness.dark
//                             ? Colors.white
//                             : Colors.black54,
//                         size: 20,
//                       ),
//                       itemBuilder: (context) => List.generate(
//                         PopUpOptions.options.length,
//                         (index) => PopupMenuItem(
//                           child: ListTile(
//                             leading: Icon(PopUpOptions.options[index].icon),
//                             title: Text(
//                               "${PopUpOptions.options[index].title}",
//                               style: TextStyles(context).getRegularStyle(),
//                             ),
//                             onTap: () {
//                               Routes.popPage(context);
//                               if (PopUpOptions.options[index].title ==
//                                   'Logout') {
//                                 Routes.logout(context);
//                               } else {
//                                 Routes.namedRoute(
//                                     context, PopUpOptions.options[index].route);
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           titleText: "Dashboard",
//         ),
//         // Space(space: 0.03),
//         Padding(
//           padding: const EdgeInsets.only(
//             bottom: 8.0,
//             top: 0,
//           ),
//           child: Card(
//             color: Theme.of(context).brightness == Brightness.dark
//                 ? Theme.of(context).cardColor
//                 : Colors.grey[300],
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//               side: BorderSide(
//                 color: Theme.of(context).brightness == Brightness.dark
//                     ? Theme.of(context).cardColor
//                     : Colors.grey[300]!,
//                 width: 1,
//               ),
//             ),
//             elevation: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: SvgPicture.asset(
//                     "assets/icons/006-user.svg",
//                     width: 90,
//                     height: 90,
//                   ),
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text:
//                             "${context.read<SchoolController>().state['school_name']}\n",
//                         style: TextStyles(context).getTitleStyle().copyWith(
//                               fontSize: 22,
//                               fontWeight: FontWeight.w400,
//                             ),
//                       ),
//                       TextSpan(
//                         text:
//                             "${context.read<SchoolController>().state['school_motto']}",
//                         style:
//                             TextStyles(context).getDescriptionStyle().copyWith(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           child: FutureBuilder(
//               future: fetchDashboardMetaData(),
//               builder: (context, snapshot) {
//                 var data = snapshot.data ?? [];
//                 return snapshot.connectionState == ConnectionState.waiting
//                     ? Loader(text: "Dashboard")
//                     : snapshot.hasData
//                         ? GridView.count(
//                             crossAxisCount: 2,
//                             children: List.generate(
//                               data.length,
//                               (index) => DashboardCard(
//                                 label: data[index]['label'],
//                                 value: data[index]['value'],
//                                 icon: data[index]['icon'],
//                                 color: data[index]['color'],
//                                 last_updated: data[index]['last_updated'],
//                               ),
//                             ),
//                           )
//                         : NoDataWidget();
//               }),
//         ),
//       ],
//     );
//   }
// }
