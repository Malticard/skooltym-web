// ignore_for_file: prefer_typing_uninitialized_variables

import '/exports/exports.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SideMenu({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  var store;
  @override
  void initState() {
    context.read<SchoolController>().getSchoolData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<SchoolController>().getSchoolData();
    store = context.read<SchoolController>().state['role'] == 'Admin'
        ? options
        : context.read<SchoolController>().state['role'] == 'Finance'
            ? financeViews
            : [];
    return Drawer(
      key: widget.scaffoldKey,
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? const Color.fromRGBO(6, 109, 161, 1.0)
          : Theme.of(context).canvasColor,
      child: Column(
        children: [
          DrawerHeader(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: BlocConsumer<SchoolController,Map<String,dynamic>>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, school) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const Space(space: 0.04),
                        Image.network(
                            "${AppUrls.liveImages}${school['school_badge']}",
                            height: 40,
                            width: 40),
                        const Space(), //
                        Text(
                          "${school['schoolName']}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles(context)
                              .getBoldStyle()
                              .copyWith(color: Colors.white, fontSize: 19),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          BlocBuilder<SideBarController, int>(
            builder: (context, selected) {
              return Expanded(
                child: ListView(
                  children: List.generate(
                    store.length,
                    (index) => DrawerListTile(
                      selected: selected == index,
                      title: store[index]['title'],
                      svgSrc: store[index]['icon'],
                      press: () {
                        context.read<SideBarController>().changeSelected(index);
                        if (context.read<SchoolController>().state['role'] ==
                            'Admin') {
                          context
                              .read<TitleController>()
                              .setTitle(store[index]['title']);
                          // update rendered page
                          context
                              .read<WidgetController>()
                              .pushWidget(store[index]['page']);
                        } else {
                          context
                              .read<FinanceTitleController>()
                              .setTitle(store[index]['title']);
                          // update rendered page
                          context
                              .read<FinanceViewController>()
                              .pushWidget(store[index]['page']);
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          // DrawerListTile(
          //   title: "Transaction",
          //   svgSrc: "assets/icons/menu_tran.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Task",
          //   svgSrc: "assets/icons/menu_task.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Documents",
          //   svgSrc: "assets/icons/menu_doc.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Store",
          //   svgSrc: "assets/icons/menu_store.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Notification",
          //   svgSrc: "assets/icons/menu_notification.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Profile",
          //   svgSrc: "assets/icons/menu_profile.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Settings",
          //   svgSrc: "assets/icons/menu_setting.svg",
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    this.selected = false,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  });
  final bool selected;
  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedTileColor: Colors.blueAccent.withOpacity(0.1),
      onTap: press,
      shape: RoundedRectangleBorder(
        side: selected
            ? const BorderSide(color: Colors.white60)
            : BorderSide.none,
      ),
      horizontalTitleGap: 0.6,
      leading: SvgPicture.asset(
        svgSrc,
        // ignore: deprecated_member_use
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white54
            : Colors.white,
        height: 18,
      ),
      title: Text(
        title,
        style: TextStyles(context).getRegularStyle().copyWith(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.white54),
      ),
    );
  }
}
