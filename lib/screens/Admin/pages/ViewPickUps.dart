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
              Image.asset(
                StaffIcons.profile,
                height: 45,
                width: 45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(pickUp.studentName!),
              ),
            ],
          ),
        ),
        DataCell(Text(pickUp.pickedBy)),
        DataCell(Text(pickUp.pickUpTime)),
        DataCell(Text(pickUp.authorizedBy)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            width: size.width,
            height: size.width / 2.5,
            child: Data_Table(
              header:  Row(
                children: [

                  Text(
                    "Available PickUps",
                    style: TextStyles(context).getTitleStyle(),
                  ),
                  if (!Responsive.isMobile(context))
                    Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                  if(context.watch<MainController>().pickUpData.length > 0)
                    const Expanded(child: SearchField()),

                ],
              ),
              columns: [
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
              empty: NoDataWidget(text: "No PickUps recorded..",),
              rows: List.generate(
                context.watch<MainController>().pickUpData.length,
                (index) => _dataRow(
                    context.watch<MainController>().pickUpData[index], index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
