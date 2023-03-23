import '/exports/exports.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  var store;
  @override
  void initState() {
    store = context.read<SchoolController>().state['role'] == 'Admin'
        ? options
        : financeViews;
    super.initState();
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: context.read<MainController>().scaffoldKey,
      child: Column(
        children: [
          DrawerHeader(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Column(
                children: [
                  Space(space: 0.04),
                  Image.asset("assets/images/logo.png"),
                  Space(),
                  Text(
                      "${context.read<SchoolController>().state['school_name']}")
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: List.generate(
                store.length,
                (index) => DrawerListTile(
                  selected: selected == index,
                  title: store[index]['title'],
                  svgSrc: store[index]['icon'],
                  press: () {
                    setState(() => selected = index);
                    // update page title
                    context
                        .read<TitleController>()
                        .setTitle(store[index]['title']);
                    // update rendered page
                    context
                        .read<WidgetController>()
                        .pushWidget(store[index]['page']);
                  },
                ),
              ),
            ),
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
  DrawerListTile({
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
        side: selected ? BorderSide(color: Colors.white60) : BorderSide.none,
      ),
      horizontalTitleGap: 0.6,
      leading: SvgPicture.asset(
        svgSrc,
        // ignore: deprecated_member_use
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white54
            : Colors.black54,
        height: 18,
      ),
      title: Text(
        title,
        style: TextStyles(context).getDescriptionStyle(),
      ),
    );
  }
}
