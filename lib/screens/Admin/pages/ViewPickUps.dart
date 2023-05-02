// import 'package:flutter/src/animation/animation_controller.dart';
import '/exports/exports.dart';

class ViewPickUps extends StatefulWidget {
  const ViewPickUps({super.key});

  @override
  State<ViewPickUps> createState() => _ViewPickUpsState();
}

class _ViewPickUpsState extends State<ViewPickUps>
    with SingleTickerProviderStateMixin {
  DataRow _dataRow(PickUpModel pickUp, int i) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Image.network(
                AppUrls.liveImages + (pickUp.studentN.studentProfilePic),
                height: 35,
                width: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                    "${pickUp.studentN.studentFname} ${pickUp.studentN.studentLname}"),
              ),
            ],
          ),
        ),
        DataCell(Text(
            "${pickUp.pickedBy.guardianFname} ${pickUp.pickedBy.guardianLname}")),
        DataCell(Text(
            "${pickUp.overtimeCharge}")),
            DataCell(Text(
            pickUp.pickUpTime.toString().split(" ").first)),
            DataCell(Text(
            "${pickUp.authorizedBy.staffFname} ${pickUp.authorizedBy.staffLname}")),
        DataCell(Text(pickUp.pickUpTime.toString().split(" ").last)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<PickUpsController>(context, listen: false)
        .getPickUps(context.read<SchoolController>().state['school']);
    return SizedBox(
      width: size.width,
      height: size.width / 2.39,
      child: BlocBuilder<PickUpsController, List<PickUpModel>>(
        builder: (context, pickups) {
          return Data_Table(
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
                        // Provider.of<MainController>(context, listen: false)
                        //     .searchPickUps(value ?? "");
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
              ),  DataColumn(
                label: Text("Overtime Charge"),
              ),  DataColumn(
                label: Text("Date"),
              ),
              DataColumn(
                label: Text("Time Of PickUp"),
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
              pickups.length,
              (index) => _dataRow(
                  pickups[index],
                  index),
            ),
          );
        },
      ),
    );
  }
}
