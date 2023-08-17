// ignore_for_file: prefer_typing_uninitialized_variables

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
    context.read<SchoolController>().getSchoolData();
    BlocProvider.of<SideBarController>(context)
        .showCurrentSelection(context.read<SchoolController>().state['role']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<SchoolController>().getSchoolData();
    BlocProvider.of<SideBarController>(context)
        .showCurrentSelection(context.read<SchoolController>().state['role']);
    store = context.read<SchoolController>().state['role'] == 'Admin'
        ? options
        : context.read<SchoolController>().state['role'] == 'Finance'
            ? financeViews
            : [];
    return Drawer(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? const Color.fromRGBO(6, 109, 161, 1.0)
          : Theme.of(context).canvasColor,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: BlocConsumer<SchoolController, Map<String, dynamic>>(
              listener: (context, state) {},
              builder: (context, school) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(
                          "${AppUrls.liveImages}${school['school_badge']}",
                          height: Responsive.isMobile(context) ? 40 : 60,
                          width: Responsive.isMobile(context) ? 40 : 60),
                    ),
                    // const Space(), //
                    Text(
                      "${school['schoolName']}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles(context).getBoldStyle().copyWith(
                          color: Colors.white,
                          fontSize: Responsive.isMobile(context) ? 13 : 16),
                    ),
                  ],
                );
              },
            ),
          ),
          Divider(
            color: Colors.white24,
          ),
          BlocBuilder<SideBarController, int>(
            builder: (context, selected) {
              return Expanded(
                flex: 5,
                child: ListView(
                  children: List.generate(
                    store.length,
                    (index) => DrawerListTile(
                      selected: index == selected,
                      title: store[index]['title'],
                      svgSrc: store[index]['icon'],
                      press: () {
                        context.read<SideBarController>().changeSelected(index,
                            context.read<SchoolController>().state['role']);
                        if (Responsive.isMobile(context) ||
                            Responsive.isTablet(context)) {
                          Routes.popPage(context);
                        }
                        context.read<TitleController>().setTitle(
                            store[index]['title'],
                            context.read<SchoolController>().state['role']);
                        if (context.read<SchoolController>().state['role'] ==
                            'Admin') {
                          // update rendered page
                          context.read<WidgetController>().pushWidget(index);
                        } else {
                          context
                              .read<FinanceViewController>()
                              .pushWidget(index);
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          ),
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
      iconColor: selected ? Colors.blue : Colors.white54,
      textColor: selected ? Colors.blue : Colors.white54,
      // tileColor: selected ?Colors.grey[200]: const Color.fromRGBO(6, 109, 161, 1.0),
      selectedTileColor: Theme.of(context).brightness == Brightness.light
          ? Color.fromARGB(71, 46, 47, 47)
          : Color.fromARGB(70, 166, 172, 172),

      onTap: press,
      leading: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: SvgPicture.asset(
          svgSrc,
          // ignore: deprecated_member_use
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white54
              : Colors.white,
          height: 18,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text(
          title,
          style: TextStyles(context).getRegularStyle().copyWith(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.white54),
        ),
      ),
    );
  }
}
