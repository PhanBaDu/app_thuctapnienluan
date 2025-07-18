import 'package:country_code_picker/country_code_picker.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodePickerWidget extends StatefulWidget {
  final ValueChanged<CountryCode>? onChanged;
  final ValueChanged<CountryCode>? onInit;
  final String? initialSelection;
  final List<String>? favorite;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final bool? showCountryOnly;
  final InputDecoration? searchDecoration;
  final TextStyle? searchStyle;
  final TextStyle? dialogTextStyle;
  final WidgetBuilder? emptySearchBuilder;
  final Function(CountryCode)? builder;
  final bool? enabled;
  final TextOverflow? textOverflow;
  final Icon? closeIcon;

  /// Barrier color of ModalBottomSheet
  final Color? barrierColor;

  /// Background color of ModalBottomSheet
  final Color? backgroundColor;

  /// BoxDecoration for dialog
  final BoxDecoration? boxDecoration;

  /// the size of the selection dialog
  final Size? dialogSize;

  /// Background color of selection dialog
  final Color? dialogBackgroundColor;

  /// used to customize the country list
  final List<String>? countryFilter;

  /// shows the name of the country instead of the dialcode
  final bool? showOnlyCountryWhenClosed;

  /// aligns the flag and the Text left
  ///
  /// additionally this option also fills the available space of the widgets.
  /// this is especially useful in combination with [showOnlyCountryWhenClosed],
  /// because longer country names are displayed in one line
  final bool? alignLeft;

  /// shows the flag
  final bool? showFlag;

  final bool? hideMainText;

  final bool? showFlagMain;

  final bool? showFlagDialog;

  /// Width of the flag images
  final double? flagWidth;

  /// Use this property to change the order of the options
  final Comparator<CountryCode>? comparator;

  /// Set to true if you want to hide the search part
  final bool? hideSearch;

  /// Set to true if you want to show drop down button
  final bool? showDropDownButton;

  /// [BoxDecoration] for the flag images
  final Decoration? flagDecoration;

  /// An optional argument for injecting a list of countries
  /// with customized codes.
  final List<Map<String, String>>? countryList;

  const CodePickerWidget({
    this.onChanged,
    this.onInit,
    this.initialSelection,
    this.favorite = const [],
    this.textStyle,
    this.padding = const EdgeInsets.all(8.0),
    this.showCountryOnly = false,
    this.searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.dialogTextStyle,
    this.emptySearchBuilder,
    this.showOnlyCountryWhenClosed = false,
    this.alignLeft = false,
    this.showFlag = true,
    this.showFlagDialog,
    this.hideMainText = false,
    this.showFlagMain,
    this.flagDecoration,
    this.builder,
    this.flagWidth = 32.0,
    this.enabled = true,
    this.textOverflow = TextOverflow.ellipsis,
    this.barrierColor,
    this.backgroundColor,
    this.boxDecoration,
    this.comparator,
    this.countryFilter,
    this.hideSearch = false,
    this.showDropDownButton = false,
    this.dialogSize,
    this.dialogBackgroundColor,
    this.closeIcon = const Icon(Icons.close),
    this.countryList = codes,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CodePickerWidgetState();
  }
}

class CodePickerWidgetState extends State<CodePickerWidget> {
  CountryCode? selectedItem;
  List<CountryCode>? elements = [];
  List<CountryCode>? favoriteElements = [];

  CodePickerWidgetState();

  @override
  Widget build(BuildContext context) {
    Widget buildWidget;
    // Bọc toàn bộ widget trong Material để hiệu ứng bấm rõ ràng hơn
    buildWidget = Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: widget.enabled! ? showCountryCodePickerDialog : null,
        child: Padding(
          padding: widget.padding ?? const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.showFlagMain != null
                  ? widget.showFlagMain!
                  : widget.showFlag!)
                Flexible(
                  flex: 0,
                  fit: widget.alignLeft! ? FlexFit.tight : FlexFit.loose,
                  child: Container(
                    clipBehavior: widget.flagDecoration == null
                        ? Clip.none
                        : Clip.hardEdge,
                    decoration: widget.flagDecoration,
                    margin: widget.alignLeft!
                        ? const EdgeInsets.only(right: 5.0, left: 0)
                        : const EdgeInsets.only(right: 5.0, left: 0),
                    child: Image.asset(
                      selectedItem!.flagUri!,
                      package: 'country_code_picker',
                      width: widget.flagWidth,
                    ),
                  ),
                ),
              if (!widget.hideMainText!)
                Flexible(
                  fit: widget.alignLeft! ? FlexFit.tight : FlexFit.loose,
                  child: Text(
                    widget.showOnlyCountryWhenClosed!
                        ? selectedItem!.toCountryStringOnly()
                        : selectedItem.toString(),
                    style: widget.textStyle ??
                        Theme.of(context).textTheme.labelLarge,
                    overflow: widget.textOverflow,
                  ),
                ),
              if (widget.showDropDownButton!)
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                  size: widget.flagWidth,
                ),
            ],
          ),
        ),
      ),
    );
    return buildWidget;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    elements = elements!.map((e) => e.localize(context)).toList();
    _onInit(selectedItem!);
  }

  @override
  void didUpdateWidget(CodePickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialSelection != widget.initialSelection) {
      if (widget.initialSelection != null) {
        selectedItem = elements!.firstWhere(
            (e) =>
                (e.code!.toUpperCase() ==
                    widget.initialSelection!.toUpperCase()) ||
                (e.dialCode == widget.initialSelection) ||
                (e.name!.toUpperCase() ==
                    widget.initialSelection!.toUpperCase()),
            orElse: () => elements![0]);
      } else {
        selectedItem = elements![0];
      }
      _onInit(selectedItem!);
    }
  }

  @override
  void initState() {
    super.initState();

    List<Map<String, String>> jsonList = widget.countryList!;

    List<CountryCode> elements =
        jsonList.map((json) => CountryCode.fromJson(json)).toList();

    if (widget.comparator != null) {
      elements.sort(widget.comparator);
    }

    if (widget.countryFilter != null && widget.countryFilter!.isNotEmpty) {
      final uppercaseCustomList =
          widget.countryFilter!.map((c) => c.toUpperCase()).toList();
      elements = elements
          .where((c) =>
              uppercaseCustomList.contains(c.code) ||
              uppercaseCustomList.contains(c.name) ||
              uppercaseCustomList.contains(c.dialCode))
          .toList();
    }

    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
          (e) =>
              (e.code!.toUpperCase() ==
                  widget.initialSelection!.toUpperCase()) ||
              (e.dialCode == widget.initialSelection) ||
              (e.name!.toUpperCase() == widget.initialSelection!.toUpperCase()),
          orElse: () => elements[0]);
    } else {
      selectedItem = elements[0];
    }

    favoriteElements = elements
        .where((e) =>
            widget.favorite!.firstWhereOrNull((f) =>
                e.code!.toUpperCase() == f.toUpperCase() ||
                e.dialCode == f ||
                e.name!.toUpperCase() == f.toUpperCase()) !=
            null)
        .toList();
  }

  void showCountryCodePickerDialog() {
    if (!UniversalPlatform.isAndroid && !UniversalPlatform.isIOS) {
      showDialog(
        barrierColor: widget.barrierColor ?? Colors.grey.withOpacity(0.5),
        context: context,
        builder: (context) => Center(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 500, maxWidth: 400),
            child: Dialog(
              child: SelectionDialog(
                elements!,
                favoriteElements!,
                showCountryOnly: widget.showCountryOnly,
                emptySearchBuilder: widget.emptySearchBuilder,
                searchDecoration: widget.searchDecoration!,
                searchStyle: widget.searchStyle,
                textStyle: widget.dialogTextStyle,
                boxDecoration: widget.boxDecoration,
                showFlag: widget.showFlagDialog ?? widget.showFlag,
                flagWidth: widget.flagWidth!,
                size: widget.dialogSize,
                backgroundColor: widget.dialogBackgroundColor,
                barrierColor: widget.barrierColor,
                hideSearch: widget.hideSearch!,
                closeIcon: widget.closeIcon,
                flagDecoration: widget.flagDecoration,
                hideHeaderText: false,
                headerAlignment: MainAxisAlignment.start,
                headerTextStyle: const TextStyle(),
                topBarPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ).then((e) {
        if (e != null) {
          setState(() {
            selectedItem = e;
          });

          _publishSelection(e);
        }
      });
    } else {
      // Hiện picker dưới dạng bottom sheet cho Android/iOS
      showModalBottomSheet(
        context: context,
        backgroundColor: widget.backgroundColor ?? Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SafeArea(
          child: SelectionDialog(
            elements!,
            favoriteElements!,
            showCountryOnly: widget.showCountryOnly,
            emptySearchBuilder: widget.emptySearchBuilder,
            searchDecoration: widget.searchDecoration!,
            searchStyle: widget.searchStyle,
            textStyle: widget.dialogTextStyle,
            boxDecoration: widget.boxDecoration,
            showFlag: widget.showFlagDialog ?? widget.showFlag,
            flagWidth: widget.flagWidth!,
            flagDecoration: widget.flagDecoration,
            size: widget.dialogSize,
            backgroundColor: widget.dialogBackgroundColor,
            barrierColor: widget.barrierColor,
            hideSearch: widget.hideSearch!,
            closeIcon: widget.closeIcon,
            hideHeaderText: false,
            headerAlignment: MainAxisAlignment.start,
            headerTextStyle: const TextStyle(),
            topBarPadding: EdgeInsets.zero,
          ),
        ),
      ).then((e) {
        if (e != null) {
          setState(() {
            selectedItem = e;
          });

          _publishSelection(e);
        }
      });
    }
  }

  void _publishSelection(CountryCode e) {
    if (widget.onChanged != null) {
      widget.onChanged!(e);
    }
  }

  void _onInit(CountryCode e) {
    if (widget.onInit != null) {
      widget.onInit!(e);
    }
  }
}
