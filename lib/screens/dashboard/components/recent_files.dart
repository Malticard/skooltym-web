import '/exports/exports.dart';

class Data_Table extends StatefulWidget {
  final List<DataColumn>? columns;
  final List<DataRow>? rows;
  final Widget? header;
  final String? title;
  const Data_Table({
    Key? key,
    this.columns,
    this.header,
    this.title,
    this.rows,
  }) : super(key: key);

  @override
  State<Data_Table> createState() => _Data_TableState();
}

class _Data_TableState extends State<Data_Table> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width / 2,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.header ??
              Text(
                widget.title ?? "",
                style: Theme.of(context).textTheme.subtitle1,
              ),
          SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              height: size.width / 4,
              child: DataTable2(
                columnSpacing: defaultPadding,
                minWidth: size.width * 0.06,
                columns: widget.columns ?? [],
                rows: widget.rows ?? [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// DataRow recentFileDataRow(RecentFile fileInfo) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Row(
//           children: [
//             SvgPicture.asset(
//               fileInfo.icon!,
//               height: 30,
//               width: 30,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(fileInfo.title!),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text(fileInfo.date!)),
//       DataCell(Text(fileInfo.size!)),
//     ],
//   );
// }
