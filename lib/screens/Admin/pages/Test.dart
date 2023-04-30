// ignore_for_file: prefer_typing_uninitialized_variables

import '/exports/exports.dart';
class TestWidget extends StatefulWidget {
  final Color? fieldColor;
  final String fieldText;
  final bool enableBorder;

  const TestWidget({Key? key,  this.fieldColor,  this.fieldText = "",  this
      .enableBorder = false}) : super(key: key);

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {

  List<dynamic> selectedList = [];
  var selected;
  @override
  Widget build(BuildContext context) {
    // context.watch<MainController>().getAllStudents(context);
    return Card(
      elevation: 0,
      color: widget.fieldColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: widget.enableBorder
            ? BorderSide(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white12
              : Colors.black12,
        )
            : BorderSide.none,
      ),
      shadowColor: Colors.black26.withOpacity(
        Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.5,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: SizedBox(

          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text(widget.fieldText,
                  style: TextStyles(context).getDescriptionStyle(),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSearchableDropDown(
                  items: context.watch<MainController>().students,
                  label: 'Select student name',
                  multiSelectTag: 'Names',
                  multiSelectValuesAsWidget: true,

                  multiSelect: true,
                  menuMode: true,
                  prefixIcon:  const Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(Icons.search),
                  ),
                  dropDownMenuItems: context.watch<MainController>().students.map((item) {
                    return item.studentFname;
                  }).toList() ??
                      [],
                  onChanged: (value){
                    print(value.toString());
                    if(value!=null)
                    {
                      selectedList = jsonDecode(value);
                      debugPrint(selectedList.toString());
                    }
                    else{
                      selectedList.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

