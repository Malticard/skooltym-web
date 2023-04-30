// import 'package:flutter/src/animation/animation_controller.dart';
import '/exports/exports.dart';

class ViewPickUps extends StatefulWidget {
  const ViewPickUps({super.key});

  @override
  State<ViewPickUps> createState() => _ViewPickUpsState();
}

class _ViewPickUpsState extends State<ViewPickUps>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    Provider.of<MainController>(context, listen: false)
        .availablePickUps(context.read<SchoolController>().state['school']);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DataRow _dataRow(PickUpModel pickUp, int i) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Image.network(
                AppUrls.liveImages + (pickUp.studentName_.studentProfilePic),
                height: 45,
                width: 45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                    "${pickUp.studentName_.studentFname} ${pickUp.studentName_.studentLname}"),
              ),
            ],
          ),
        ),
        DataCell(Text(
            "${pickUp.pickedBy.guardianFname} ${pickUp.pickedBy.guardianLname}")),
        DataCell(Text(
            "${pickUp.authorizedBy_.staffFname} ${pickUp.authorizedBy_.staffLname}")),
        DataCell(Text(pickUp.pickUpTime.toString())),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Provider.of<MainController>(context, listen: false)
        .availablePickUps(context.read<SchoolController>().state['school']);
    return SizedBox(
      width: size.width,
      height: size.width / 2.39,
      child: Data_Table(
        header: Row(
          children: [
            Text(
              "Available PickUps",
              style: TextStyles(context).getTitleStyle(),
            ),
            if (!Responsive.isMobile(context))
              Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
            if (context.watch<MainController>().pickUpData.isNotEmpty)
              Expanded(
                child: SearchField(
                  onChanged: (value) {
                    Provider.of<MainController>(context, listen: false)
                        .searchPickUps(value ?? "");
                  },
                ),
              ),
          ],
        ),
        columns: const [
          DataColumn(
            label: Text("Student Name"),
          ),
          DataColumn(
            label: Text("PickedUp By"),
          ),
          DataColumn(
            label: Text("Cleared by"),
          ),
          DataColumn(
            label: Text("Time Of PickOff"),
          ),
        ],
        empty: Center(
            child: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 5)),
                builder: (context, y) {
                  return y.connectionState == ConnectionState.waiting
                      ? const Loader(
                          text: "PickUp data",
                        )
                      : const NoDataWidget(
                          text: "No PickUps recorded..",
                        );
                })),
        rows: List.generate(
          context.watch<MainController>().sPickUp.isEmpty
              ? context.watch<MainController>().pickUpData.length
              : context.watch<MainController>().sPickUp.length,
          (index) => _dataRow(
              context.watch<MainController>().sPickUp.isEmpty
                  ? context.watch<MainController>().pickUpData[index]
                  : context.watch<MainController>().sPickUp[index],
              index),
        ),
      ),
    );
  }
}
