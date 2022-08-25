import 'package:flutter/material.dart';
import 'package:weather_app/core/resources/app_resources.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = TextEditingController();

  String get _text => _textController.text;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringsApp.citySearch)),
      body: Padding(
        padding: const EdgeInsets.all(ConstApp.mPadding),
        child: Column(
          children: [
            TextFieldSearchWidget(
              controller: _textController,
              onPressed: () => Navigator.pop(context, _text),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldSearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;

  const TextFieldSearchWidget({
    Key? key,
    required this.controller,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      style: const TextStyle(color: ColorsApp.whiteColor),
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: ColorsApp.whiteColor),
        labelText: StringsApp.city,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(ConstApp.borderRadius),
          ),
          borderSide: BorderSide(color: ColorsApp.whiteColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(ConstApp.borderRadius),
          ),
          borderSide: BorderSide(color: ColorsApp.whiteColor),
        ),
        suffixIcon: IconButton(
          onPressed: onPressed,
          color: ColorsApp.whiteColor,
          icon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
