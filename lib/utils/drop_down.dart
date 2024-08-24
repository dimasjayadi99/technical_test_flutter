import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownUtils extends StatefulWidget {
  final String? title;
  final String hintText;
  final String? selectedValue;
  final TextEditingController controller;
  final List<String> items;
  final Function(String?)? onChanged;
  final bool isRequired;

  const DropDownUtils({super.key,
    required this.hintText,
    required this.selectedValue,
    required this.controller,
    required this.items,
    this.onChanged,
    this.title,
    required this.isRequired
  });

  @override
  DropDownUtilsStates createState() => DropDownUtilsStates();
}

class DropDownUtilsStates extends State<DropDownUtils> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Text(
              widget.title!,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField2<String>(
              isExpanded: true,
              hint: Text(widget.hintText),
              items: widget.items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
              value: widget.selectedValue,
              onChanged: widget.onChanged,
              buttonStyleData: ButtonStyleData(
                height: 60,
                elevation: 0,
                padding: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  color: Colors.transparent,
                ),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                ),
                iconDisabledColor: Colors.black,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 300,
                isOverButton: true,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(5),
                  thickness: WidgetStateProperty.all<double>(6),
                  thumbVisibility: WidgetStateProperty.all<bool>(true),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.only(left: 14, right: 14),
              ),
              dropdownSearchData: DropdownSearchData<String>(
                searchMatchFn: (DropdownMenuItem<String> item, String searchString) {
                  return item.value!
                      .toLowerCase()
                      .contains(searchString.toLowerCase());
                },
                searchInnerWidget: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    maxLines: 1,
                    controller: widget.controller,
                    decoration: InputDecoration(
                      hintText: 'Cari...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                searchInnerWidgetHeight: 60.0,
                searchController: widget.controller,
              ),
              validator: (String? value) {
                if(widget.isRequired) {
                  if (value == null || value.isEmpty) {
                    return "${widget.hintText} masih kosong!";
                  }
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
