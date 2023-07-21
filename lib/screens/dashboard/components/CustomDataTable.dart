import '/exports/exports.dart';

class CustomDataTable extends StatefulWidget {
  final List<DataColumn>? columns;
  final List<DataRow>? rows;
  final Widget? header;
  final String loaderText;
  final Widget? empty;
  final String? title;
  final DataTableSource source;
  const CustomDataTable({
    Key? key,
    this.columns,
    this.header,
    this.title,
    this.empty,
    this.rows,
    required this.source,
    this.loaderText = "Data",
  }) : super(key: key);

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width / 2,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // widget.header ??
          //     Text(
          //       widget.title ?? "",
          //       style: Theme.of(context).textTheme.subtitle1,
          //     ),
          SizedBox(
            width: size.width,
            height: size.width / 4,
            child: PaginatedDataTable2(
              header: widget.header,
              // loading:Loader(text: widget.loaderText),
              horizontalMargin: 20,
              columnSpacing: 5, //defaultPadding,
              dividerThickness: 1, // this one will be ignored if [border] is set above
              minWidth: 900,
              dataRowHeight: 60,
              sortColumnIndex: 2,
              sortAscending: false,
              sortArrowIcon: Icons.keyboard_arrow_up, // custom arrow
              sortArrowAnimationDuration: const Duration(milliseconds: 500),
              columns: widget.columns ?? [],
              empty: widget.empty,
              source: widget.source,
            ),
          ),

        ],
      ),
    );
  }
}
