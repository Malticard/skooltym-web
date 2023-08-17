// ignore_for_file: prefer_typing_uninitialized_variables

import '/exports/exports.dart';
import 'CustomSearchDropDown.dart';

class CommonMenuWidget extends StatefulWidget {
  final Color? fieldColor;
  final String fieldText;
  final String fieldHeaderTitle;
  final bool enableBorder;
  final List<dynamic> data;
  final List<dynamic> dropdownList;
  final String hint;
  final EdgeInsets padding;
  final ValueChanged onChange;
  const CommonMenuWidget(
      {Key? key,
      this.fieldColor,
      this.fieldText = "",
      this.enableBorder = false,
      required this.onChange,
      required this.hint,
      required this.padding,
      required this.data,
      required this.dropdownList,
      required this.fieldHeaderTitle})
      : super(key: key);

  @override
  State<CommonMenuWidget> createState() => _CommonMenuWidgetState();
}

class _CommonMenuWidgetState extends State<CommonMenuWidget> {
  List<dynamic> selectedList = [];
  var selected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: widget.padding,
            child: Text(
              widget.fieldText,
              style: TextStyles(context).getDescriptionStyle(),
            ),
          ),
          Card(
            elevation: 0,
            color: widget.fieldColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
              // side: widget.enableBorder
              //     ? BorderSide(
              //         color: Theme.of(context).brightness == Brightness.dark
              //             ? Colors.white12
              //             : Colors.black12,
              //       )
              //     : BorderSide.none,
            ),
            shadowColor: Colors.black26.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.5,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 5,
                bottom: 5,
              ),
              child: CustomSearchableDropDown(
                items: widget.data,
                label: widget.hint,
                menuPadding: Responsive.isMobile(context)
                    ? EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.width / 3,
                        top: MediaQuery.of(context).size.width / 3,
                        left: 20,
                        right: 20)
                    : EdgeInsets.all(150).copyWith(right: 180, left: 180),
                multiSelectTag: 'Names',
                multiSelectValuesAsWidget: true,
                multiSelect: true,

                prefixIcon: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey.shade300,
                  ),
                ),
                dropDownMenuItems: widget.dropdownList,
                dropdownItemStyle: TextStyles(context).getRegularStyle(),
                onChanged: widget.onChange, //(value){
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                title: widget.fieldHeaderTitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
