// import 'package:flutter/src/animation/animation_controller.dart';
import '/exports/exports.dart';

class ViewPickUps extends StatefulWidget {
  const ViewPickUps({super.key});

  @override
  State<ViewPickUps> createState() => _ViewPickUpsState();
}

class _ViewPickUpsState extends State<ViewPickUps> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<PickUpsController>(context, listen: true)
        .getPickUps(context.read<SchoolController>().state['school']);
    return SizedBox(
      width: size.width,
      height: size.width / 2.39,
      child: BlocConsumer<PickUpsController, List<PickUpModel>>(
        listener: (context, pickups) {},
        builder: (context, pickups) {
          return CustomDataTable(
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
            columns: [
              DataColumn2(
                numeric: true,
                label: Text("Student Name"),
              ),
              DataColumn2(
                numeric: true,
                label: Text("PickedUp By"),
              ),
              DataColumn2(
                numeric: true,
                label: Text("Cleared by"),
              ),
              DataColumn2(
                numeric: true,
                label: Text("Overtime Charge"),
              ),
              DataColumn2(
                numeric: true,
                label: Text("Date"),
              ),
              DataColumn2(
                numeric: true,
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
                  }),
            ),
            source: PickUpDataSource(pickUpModel: pickups, context: context),
          );
        },
      ),
    );
  }
}
