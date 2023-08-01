import '/exports/exports.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Map<String, dynamic> schoolData = {};
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SchoolController>(context, listen: true).getSchoolData();

    return BlocConsumer<SchoolController, Map<String, dynamic>>(
      listener: (context, state) {
        setState(() {
          schoolData = state;
        });
      },
      builder: (context, state) {
        return Row(
          children: [
            if (!Responsive.isDesktop(context))
              IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    // debugPrint("Scaffold state => ${scaffoldKey.currentWidget}");
                  } //context.read<MainController>().controlMenu(scaffoldKey),
                  ),
            if (!Responsive.isMobile(context))
              if (schoolData['role'] == 'Finance')
                BlocBuilder<FinanceTitleController, String>(
                    builder: (context, title) {
                  return Text(
                    title,
                    style: TextStyles(context).getTitleStyle(),
                  );
                }),
            if (schoolData['role'] != 'Finance')
              BlocBuilder<TitleController, String>(builder: (context, title) {
                return Text(
                  title,
                  style: TextStyles(context).getTitleStyle(),
                );
              }),
            if (!Responsive.isMobile(context))
              Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
            CommonButton(
              width: 50,
              buttonTextWidget: Icon(
                Theme.of(context).brightness == Brightness.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: Colors.white70,
              ),
              onTap: () => BlocProvider.of<ThemeController>(context)
                  .toggleDarkLightTheme(),
            ),
            const ProfileCard()
          ],
        );
      },
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  Map<String, dynamic> schoolData = {};
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SchoolController>(context, listen: true).getSchoolData();
    return BlocConsumer<SchoolController, Map<String, dynamic>>(
      listener: (context, state) {
        setState(() {
          schoolData = state;
        });
      },
      builder: (context, state) {
        return Container(
            margin: const EdgeInsets.only(left: defaultPadding),
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: FutureBuilder(
                    future: fetchAndDisplayImage(
                        schoolData['profile_pic'] ?? "profile.png"),
                    builder: (context, payload) => payload.hasData
                        ? Image.memory(payload.data!)
                        : CircularProgressIndicator.adaptive(),
                  ),
                ),
                if (!Responsive.isMobile(context))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child:
                        Text("${schoolData['fname']} ${schoolData['lname']}"),
                  ),
                PopupMenuButton(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  itemBuilder: (BuildContext context) {
                    return List.generate(
                      StaffPopUpOptions.options.length,
                      (index) => PopupMenuItem(
                          child: ListTile(
                        leading: Icon(StaffPopUpOptions.options[index].icon),
                        title: Text(StaffPopUpOptions.options[index].title!),
                        onTap: () {
                          StaffPopUpOptions.options[index].title == 'Logout'
                              ? Routes.logout(context)
                              : context
                                  .read<WidgetController>()
                                  .pushWidget(const AdminProfile());
                          Navigator.pop(context);
                        },
                      )),
                    );
                  },
                ),
              ],
            ));
      },
    );
  }
}

class SearchField extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  const SearchField({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: Theme.of(context).canvasColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
