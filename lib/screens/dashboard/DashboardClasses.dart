import '/exports/exports.dart';

class name extends StatefulWidget {
  const name({super.key});

  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  List<Map<String, dynamic>> cols = [
    {
      "label": "#",
    },
    {
      "label": "Class",
    },
    {
      "label": "Students",
    },
    {
      "label": "Streams",
    }
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.width / 2.5,
      // child: CustomDataTable(
      //   columns: List.generate(
      //     cols.length,
      //     (index) => DataColumn(
      //       label: Text(
      //         cols[index]['label'],
      //       ),
      //     ),
      //   ),
      //   rows: [],
      // ),
    );
  }
}
