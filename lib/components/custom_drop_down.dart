import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/material.dart';

import '../padding.dart';

typedef void SearchCallback(dynamic value);

class CustomDropdown extends StatefulWidget {
  final Map<String, List<String>> options;
  final ValueChanged<dynamic> onChange;
  final dynamic value;
  final bool isSearchable;
  final bool allowClear;
  final String placeholder;
  final Widget prefixIcon;
  final bool hideDropdownIcon;
  final Color fillColor;
  final bool disabled;
  final SearchCallback onSearchTap;

  CustomDropdown(
      {Key key,
      this.options,
      this.onChange,
      this.value,
      this.disabled = false,
      this.isSearchable = false,
      this.allowClear = false,
      this.hideDropdownIcon = false,
      this.prefixIcon,
      this.placeholder = "Select Item",
      this.fillColor,
      this.onSearchTap})
      : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final FocusNode _focusNode = FocusNode();
  String label;
  String labelType;

  OverlayEntry _overlayEntry;
  List<dynamic> list1Result = [];
  List<dynamic> list2Result = [];
  TextEditingController _searchController = new TextEditingController();

  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (this.widget.disabled == true) {
        print("Disabled");
      } else {
        if (_focusNode.hasFocus) {
          this._overlayEntry = this._createOverlayEntry();
          this.setState(() {
            list1Result = widget.options['list1'];
            list2Result = widget.options['list2'];
          });
          Overlay.of(context).insert(this._overlayEntry);
        } else {
          _searchController.text = "";
          this._overlayEntry?.remove();

          this._overlayEntry = null;
        }
      }
    });
    this.setState(() {
      list1Result = widget.options['list1'];
      list2Result = widget.options['list2'];
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    // print("options ${widget.options}");
    // print("result  $results");

    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: this._layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 5.0),
                child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(4),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          color: ANColor.backgroundText,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              child: Text(
                                "Option1",
                                style: header4
                                    .copyWith(color: ANColor.white),
                              )),
                        ),
                        Container(
                          constraints: BoxConstraints(maxHeight: 200),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: <Widget>[
                              ...list1Result.map((optionItem) {
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        label = optionItem.toString();
                                        labelType = "list1";
                                      });
                                      widget.onChange({
                                        "type": "list1",
                                        "value": optionItem
                                      });
                                      _searchController.text = optionItem ?? "";
                                      this.setState(() {
                                        list1Result =
                                            widget.options['list1'];
                                      });
                                      try {
                                        this._overlayEntry?.remove();
                                        this._overlayEntry = null;
                                        this._focusNode.unfocus();
                                      } catch (e) {
                                        // print("closing error ${e.toString()}");
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 8),
                                      child: Text(optionItem,
                                          style: header4),
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: ANColor.backgroundText,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              child: Text(
                                "Most Searched Doctors",
                                style: header4
                                    .copyWith(color: ANColor.primary),
                              )),
                        ),
                        Container(
                          constraints: BoxConstraints(maxHeight: 200),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: <Widget>[
                              ...list2Result.map((optionItem) {
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        label = optionItem.toString();
                                        labelType = "list2";
                                      });
                                      widget.onChange({
                                        "type": "list2",
                                        "value": optionItem
                                      });
                                      _searchController.text = optionItem ?? "";
                                      this.setState(() {
                                        list2Result =
                                            widget.options['list2'];
                                      });
                                      try {
                                        this._overlayEntry?.remove();
                                        this._overlayEntry = null;
                                        this._focusNode.unfocus();
                                      } catch (e) {
                                        // print("closing error ${e.toString()}");
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 8),
                                      child: Text(optionItem,
                                          style: header4),
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: Stack(children: [
        TextFormField(
          controller: _searchController,
          focusNode: this._focusNode,
          readOnly: widget.isSearchable ? false : true,
          onTap: () {
            if (_focusNode.hasFocus && !widget.isSearchable) {
              _focusNode.unfocus();
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            labelText: label,
            labelStyle: header3,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintStyle: TextStyle(color: ANColor.black),
            hintText: 'Address',
            suffixIcon: Container(
              decoration: BoxDecoration(
                color: ANColor.primary,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18.0),
                    bottomRight: Radius.circular(18.0)),
              ),
              child: InkWell(
                onTap: () {
                  widget.onSearchTap({'type': labelType, 'value': label});
                },
                child: Icon(
                  Icons.search,
                  color: ANColor.white,
                ),
              ),
            ),
            contentPadding:
                ANPadding.globalPadding.copyWith(top: 12.0, bottom: 12.0),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
                borderSide: BorderSide(
                    color: ANColor.primary, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
                borderSide: BorderSide(
                    color: ANColor.primary, style: BorderStyle.solid)),
          ),
          onChanged: (val) {
            this.setState(() {
              list2Result = widget.options['list2']
                  .where((element) => element
                      .toString()
                      .toLowerCase()
                      .contains(val.toLowerCase()))
                  .toList();
              list1Result = widget.options['list1']
                  .where((element) => element
                      .toString()
                      .toLowerCase()
                      .contains(val.toLowerCase()))
                  .toList();
            });
            this._overlayEntry.markNeedsBuild();
            // this._focusNode.requestFocus();
          },
        ),
      ]),
    );
  }
}
