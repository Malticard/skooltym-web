// ignore_for_file: must_be_immutable

import '/exports/exports.dart';

class DropDownWidget extends StatefulWidget {
  ValueChanged<String?>? selectedValue;
  String? titleText;
  List<String> elements;
  final EdgeInsets padding;
  IconData mustIcon;
  String displayText;
  DropDownWidget(
      {Key? key,
      this.selectedValue,
      this.mustIcon = Icons.star,
      this.padding =
          const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
      required this.elements,
      this.displayText = "",
      this.titleText})
      : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  // String v = "Food";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 18, right: 18, top: 4, bottom: 4),
            child: RichText(
              text: TextSpan(
                text: "${widget.titleText}   ",
                style: TextStyles(context).getDescriptionStyle(),
                children: [
                  WidgetSpan(
                    child: Icon(
                      widget.mustIcon,
                      size: 12,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: size.width,
            height: size.height / 20,
            // height: 48,
            child: Card(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color.fromARGB(66, 75, 74, 74),
              borderOnForeground: false,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: DropdownButton<String>(
                value: widget.displayText,
                underline: Container(),
                elevation: 0,
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
                items: List.generate(
                  widget.elements.length,
                  (index) => DropdownMenuItem(
                    value: widget.elements[index],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.elements[index],
                        style: TextStyles(context).getDescriptionStyle(),
                      ),
                    ),
                  ),
                ),
                onChanged: widget.selectedValue ?? (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
