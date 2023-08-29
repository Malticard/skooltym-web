import '../../../controllers/MenuAppController.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<SchoolController>(context).getSchoolData();
    BlocProvider.of<TitleController>(context).showTitle();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SchoolController>(context, listen: true).getSchoolData();
    BlocProvider.of<TitleController>(context, listen: true).showTitle();
    BlocProvider.of<FirstTimeUserController>(context).getFirstTimeUser();
    return BlocConsumer<SchoolController, Map<String, dynamic>>(
      listener: (context, state) {
        setState(() {
          schoolData = state;
        });
      },
      builder: (context, state) {
        return Row(
          children: [
            if (!Responsive.isDesktop(context) &&
                context.read<FirstTimeUserController>().state)
              IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    context.read<MenuAppController>().controlMenu();
                  }),
            BlocBuilder<TitleController, String>(builder: (context, title) {
              return Text(
                title,
                style: Responsive.isMobile(context)
                    ? TextStyles(context)
                        .getRegularStyle()
                        .copyWith(fontSize: 18)
                    : TextStyles(context).getTitleStyle(),
              );
            }),
            if (!Responsive.isMobile(context))
              Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
            Expanded(child: Container()),
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
  void dispose() {
    super.dispose();
    context.read<MenuAppController>().disposeController();
  }

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
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context)
                  ? defaultPadding / 2
                  : defaultPadding,
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
                        ? Image.network(payload.data!, fit: BoxFit.cover)
                        : CircularProgressIndicator.adaptive(),
                  ),
                ),
                if (!Responsive.isMobile(context))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: Text(
                      "${schoolData['fname']} ${schoolData['lname']}",
                      style: TextStyles(context).getRegularStyle(),
                    ),
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
                          // context.read<MenuAppController>().disposeController();
                          // StaffPopUpOptions.options[index].title == 'Logout'
                          Routes.logout(context);
                          // : context
                          //     .read<WidgetController>()
                          //     .pushWidget(const AdminProfile());
                          // Navigator.pop(context);
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
