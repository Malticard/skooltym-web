import '/exports/exports.dart';

class Data_Table extends StatefulWidget {
  final List<DataColumn>? columns;
  final List<DataRow>? rows;
  final Widget? header;
  final String loaderText;
  final Widget? empty;
  final String? title;
  final DataTableSource? source;
  const Data_Table({
    Key? key,
    this.columns,
    this.header,
    this.title,
    this.empty,
    this.rows,
    this.source,
    this.loaderText = "Loading...",
  }) : super(key: key);

  @override
  State<Data_Table> createState() => _Data_TableState();
}

class _Data_TableState extends State<Data_Table> {
   int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool _sortAscending = true;
  int? _sortColumnIndex;
  // DessertDataSourceAsync? _dessertsDataSource;
  final PaginatorController _controller = PaginatorController();

  bool _dataSourceLoading = false;
  int _initialRow = 0;

  @override
  void didChangeDependencies() {
    // initState is to early to access route options, context is invalid at that stage
    // _dessertsDataSource ??= getCurrentRouteOption(context) == noData
    //     ? DessertDataSourceAsync.empty()
    //     : getCurrentRouteOption(context) == asyncErrors
    //         ? DessertDataSourceAsync.error()
    //         : DessertDataSourceAsync();

    if (getCurrentRouteOption(context) == goToLast) {
      _dataSourceLoading = true;
      // _dessertsDataSource!.getTotalRecords().then((count) => setState(() {
      //       _initialRow = count - _rowsPerPage;
      //       _dataSourceLoading = false;
      //     }));
    }
    super.didChangeDependencies();
  }

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
          widget.header ??
              Text(
                widget.title ?? "",
                style: Theme.of(context).textTheme.subtitle1,
              ),
          Expanded(
            child: SizedBox(
              width: size.width,
              height: size.width / 4,
              child: DataTable2(
                horizontalMargin: 20,
                columnSpacing: 5, //defaultPadding,
                dividerThickness:
                    1, // this one will be ignored if [border] is set above
                bottomMargin: 10,
                minWidth: 900,
                dataRowHeight: 60,
                sortColumnIndex: 2,
                sortAscending: false,
                showBottomBorder: true,
                sortArrowIcon: Icons.keyboard_arrow_up, // custom arrow
                sortArrowAnimationDuration: const Duration(milliseconds: 500),
                columns: widget.columns ?? [],
                empty: widget.empty ,
                rows: widget.rows ?? [],
              ),
            ),
          ),

          // Expanded(
          //   child: SizedBox(
          //      width: size.width,
          //     height: size.width / 4,
          //     child: AsyncPaginatedDataTable2(
          //         horizontalMargin: 20,
          //         checkboxHorizontalMargin: 12,
          //         columnSpacing: 0,
          //         wrapInCard: false,
          //         rowsPerPage: _rowsPerPage,
          //         autoRowsToHeight: getCurrentRouteOption(context) == autoRows,
          //         // Default - do nothing, autoRows - goToLast, other - goToFirst
          //         pageSyncApproach: getCurrentRouteOption(context) == dflt
          //             ? PageSyncApproach.doNothing
          //             : getCurrentRouteOption(context) == autoRows
          //                 ? PageSyncApproach.goToLast
          //                 : PageSyncApproach.goToFirst,
          //         minWidth: 800,
          //         fit: FlexFit.tight,
          //         border: TableBorder(
          //             top: const BorderSide(color: Colors.black),
          //             bottom: BorderSide(color: Colors.grey[300]!),
          //             left: BorderSide(color: Colors.grey[300]!),
          //             right: BorderSide(color: Colors.grey[300]!),
          //             verticalInside: BorderSide(color: Colors.grey[300]!),
          //             horizontalInside:
          //                 const BorderSide(color: Colors.grey, width: 1)),
          //         onRowsPerPageChanged: (value) {
          //           // No need to wrap into setState, it will be called inside the widget
          //           // and trigger rebuild
          //           //setState(()
          //           _rowsPerPage = value!;
          //           //});
          //         },
          //         initialFirstRowIndex: _initialRow,
          //         onPageChanged: (rowIndex) {
          //           //print(rowIndex / _rowsPerPage);
          //         },
          //         sortColumnIndex: _sortColumnIndex,
          //         sortAscending: _sortAscending,
          //         sortArrowIcon: Icons.keyboard_arrow_up,
          //         sortArrowAnimationDuration: const Duration(milliseconds: 0),
          //         // onSelectAll: (select) => select != null && select
          //         //     ? (getCurrentRouteOption(context) != selectAllPage
          //         //         ? _dessertsDataSource!.selectAll()
          //         //         : _dessertsDataSource!.selectAllOnThePage())
          //         //     : (getCurrentRouteOption(context) != selectAllPage
          //         //         ? _dessertsDataSource!.deselectAll()
          //         //         : _dessertsDataSource!.deselectAllOnThePage()),
          //         controller: _controller,
          //         hidePaginator: getCurrentRouteOption(context) == custPager,
          //         columns: widget.columns ?? [],
          //         empty: widget.empty,
          //         loading: Loader(
          //           text: widget.loaderText,
          //         ),
          //         // errorBuilder: (e) => _ErrorAndRetry(
          //         //     e.toString(), () => _dessertsDataSource!.refreshDatasource()),
          //         source: widget.source!),
          //   ),
          // )
        
        ],
      ),
    );
  }
}
