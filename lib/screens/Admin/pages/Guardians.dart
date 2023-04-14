// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class ViewGuardians extends StatefulWidget {
  const ViewGuardians({super.key});

  @override
  State<ViewGuardians> createState() => _ViewGuardiansState();
}

class _ViewGuardiansState extends State<ViewGuardians> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<MainController>(context).newGuardians(context);
    super.didChangeDependencies();
  }

  List<String> staffs = ["Guardian Name", "Address", "Gender", "Actions"];
  DataRow _dataRow(Guardians guardians, int i) {
    return DataRow(
      cells: [
        DataCell(
            Row(
            children: [
          CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  AppUrls.liveImages + guardians.guardianProfilePic,
                ),
              ),
               Padding(
            padding:  const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
                "${guardians.guardianFname} ${guardians.guardianLname}"),
          ),
            ],
          )
         
        ),
        DataCell(Text(guardians.guardianEmail)),
        DataCell(Text(guardians.guardianGender)),
        DataCell(buildActionButtons(context,(){
          showDialog(
              context: context,
              builder: (context) {
                return UpdateGuardian(guardianModel: guardians);
              });
        },(){
          showDialog(
              context: context,
              builder: (context) {
                return CommonDelete(title: "${guardians.guardianFname} ${guardians.guardianLname}", url: AppUrls.deleteGuardian + guardians.id,);
              });
        },)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MainController>(context).newGuardians(context);
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.width / 2.5,
      child: Data_Table(
        header: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(context.watch<MainController>().guardians.isNotEmpty)
                 const Expanded(child: SearchField()),
              if (!Responsive.isMobile(context))
                Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
             const SizedBox(),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AddGuardian();
                      });
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Guardian"),
              ),
            ],
          ),
        ),
        columns: List.generate(
          staffs.length,
          (index) => DataColumn(
            label: Text(
              staffs[index],
            ),
          ),
        ),
        empty: const NoDataWidget(text:"No guardians registered yet.."),
        rows:context.read<MainController>().guardians.isEmpty ?
            []
            : List.generate(
                context.watch<MainController>().guardians.length,
                (index) => _dataRow(
                    context.watch<MainController>().guardians[index], index),
              ),
      ),
    );
  }
}
