import 'package:flutter/material.dart';
import 'package:workflow_manager/common/constants.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';

typedef Widget AppBarCallback(BuildContext context);
typedef void TextFieldSubmitCallback(String value);
typedef void TextFieldChangeCallback(String value);
typedef void SetStateCallback(void fn());

class SearchBar {
  /// Whether the search should take place "in the existing search bar", meaning whether it has the same background or a flipped one. Defaults to true.
  final bool inBar;

  /// A callback which should return an AppBar that is displayed until search is started. One of the actions in this AppBar should be a search button which you obtain from SearchBar.getSearchAction(). This will be called every time search is ended, etc. (like a build method on a widget)
  final AppBarCallback buildDefaultAppBar;

  /// A void callback which takes a string as an argument, this is fired every time the search is submitted. Do what you want with the result.
  final TextFieldSubmitCallback onSubmitted;

  /// A void callback which gets fired on search button press.
  final VoidCallback onOpened;

  /// A void callback which gets fired on close button press.
  final VoidCallback onClosed;

  /// Since this should be inside of a State class, just pass setState to this.
  final SetStateCallback setState;

  /// What the hintText on the search bar should be. Defaults to 'Search'.
  final String hintText;

  /// Whether search is currently active.
  final ValueNotifier<bool> isSearching = ValueNotifier(false);

  /// A callback which is invoked each time the text field's value changes
  final TextFieldChangeCallback onChanged;

  /// The type of keyboard to use for editing the search bar text. Defaults to 'TextInputType.text'.
  final TextInputType keyboardType;

  /// The controller to be used in the textField.
  TextEditingController controller;

  final ItemBuilder itemBuilder;

  final SuggestionsCallback suggestionsCallback;

  final dynamic suggestionSelectedPattern;

  SearchBar({
    this.setState,
    this.buildDefaultAppBar,
    this.itemBuilder,
    this.suggestionsCallback,
    this.suggestionSelectedPattern,
    this.onSubmitted,
    TextEditingController controller,
    this.hintText = 'Search',
    this.inBar = true,
    this.onOpened,
    this.onChanged,
    this.onClosed,
    this.keyboardType = TextInputType.text,
  }) {
    this.controller = controller ?? new TextEditingController();
  }

  /// Initializes the search bar.
  ///
  /// This adds a route that listens for onRemove (and stops the search when that happens), and then calls [setState] to rebuild and start the search.
  void beginSearch(context) {
    ModalRoute.of(context).addLocalHistoryEntry(LocalHistoryEntry(onRemove: () {
      setState(() {
        isSearching.value = false;
      });
    }));

    setState(() {
      isSearching.value = true;
    });
  }

  /// Builds, saves and returns the default app bar.
  ///
  /// This calls the [buildDefaultAppBar] provided in the constructor.
  AppBar buildAppBar(BuildContext context) {
    return buildDefaultAppBar(context) as AppBar;
  }

  /// Builds the search bar!
  ///
  /// The leading will always be a back button.
  /// backgroundColor is determined by the value of inBar
  /// title is always a [TextField] with the key 'SearchBarTextField', and various text stylings based on [inBar]. This is also where [onSubmitted] has its listener registered.
  ///
  AppBar buildSearchBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Directionality(
        textDirection: Directionality.of(context),
        child: SizedBox(
          height: 35,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              keyboardType: keyboardType,
              style:
                  kDefaultTextStyle.copyWith(color: Colors.white, fontSize: 15),
              decoration: InputDecoration(
                filled: true,
                fillColor: kBlue1,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0.0),
                    borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0.0),
                    borderRadius: BorderRadius.circular(12)),
                hintText: hintText,
              ),
              onChanged: this.onChanged,
              onSubmitted: (String val) async {
                onSubmitted?.call(val);
              },
              controller: controller,
            ),
            hideOnLoading: true,
            hideOnEmpty: true,
            hideOnError: true,
            hideSuggestionsOnKeyboardHide: true,
            itemBuilder: this.itemBuilder,
            suggestionsCallback: this.suggestionsCallback,
            onSuggestionSelected: (suggestion) {
              controller.text = suggestion.toJson()[suggestionSelectedPattern];
              onSubmitted?.call(suggestion.toJson()[suggestionSelectedPattern]);
            },
          ),
        ),
      ),
      actions: <Widget>[
        // Show an icon if clear is not active, so there's no ripple on tap
        InkWell(
          onTap: () {
            onClosed?.call();
            controller.clear();
            // if (_clearActive) Navigator.maybePop(context);
            Navigator.maybePop(context);
          },
          child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 20),
                child: new Text(
                  "Hủy",
                  style: kMediumWhiteTextStyle,
                ),
              )),
        ),
      ],
    );
  }

  /// Returns an [IconButton] suitable for an Action
  ///
  /// Put this inside your [buildDefaultAppBar] method!
  IconButton getSearchAction(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.only(right: 8),
        icon: SvgImage(svgName: 'ic_search_app_bar'),
        onPressed: () {
          onOpened?.call();
          beginSearch(context);
        });
  }

  /// Returns an AppBar based on the value of [isSearching]
  AppBar build(BuildContext context) {
    return isSearching.value ? buildSearchBar(context) : buildAppBar(context);
  }
}
