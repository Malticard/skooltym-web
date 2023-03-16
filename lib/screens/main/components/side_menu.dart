import '/exports/exports.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          Expanded(
            child: ListView(
              children: List.generate(
                options.length,
                (index) => DrawerListTile(
                  title: options[index]['title'],
                  svgSrc: options[index]['icon'],
                  press: () => context
                      .read<WidgetController>()
                      .pushWidget(options[index]['page']),
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
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
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
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
