import '/exports/exports.dart';

class CustomDataTable extends StatefulWidget {
  final List<DataColumn>? columns;
  final List<DataRow>? rows;
  final Widget? header;
  final String loaderText;
  final Widget? empty;
  final String? title;
  final bool asyncTable;
  final int rowsPerPage;
  final DataTableSource source;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int?>? onRowsPerPageChanged;
  final PaginatorController? paginatorController;
  const CustomDataTable({
    Key? key,
    this.columns,
    this.header,
    this.title,
    this.empty,
    this.rows,
    required this.source,
    this.loaderText = "Data",
    this.asyncTable = false,
    this.onPageChanged,
    this.onRowsPerPageChanged,
    this.paginatorController,
    this.rowsPerPage = 20,
  }) : super(key: key);

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.width / 1.4,
      child: PaginatedDataTable2(
        controller: widget.paginatorController,
        onPageChanged: widget.onPageChanged,
        onRowsPerPageChanged: widget.onRowsPerPageChanged,
        header: widget.header,
        // loading:Loader(text: widget.loaderText),
        horizontalMargin: 20,
        columnSpacing: 5, //defaultPadding,
        dividerThickness:
            1, // this one will be ignored if [border] is set above
        minWidth: 900,
        dataRowHeight: 60,
        sortColumnIndex: 2,
        rowsPerPage: widget.rowsPerPage,
        sortAscending: true,
        sortArrowIcon: Icons.keyboard_arrow_up, // custom arrow
        sortArrowAnimationDuration: const Duration(milliseconds: 500),
        columns: widget.columns ?? [],
        empty: widget.empty,
        source: widget.source,
      ),
    );
  }
}
