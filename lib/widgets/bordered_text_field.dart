import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:posts_app/helpers/constants.dart';
import 'package:posts_app/theme/colors.dart';
import 'package:posts_app/theme/text_styles.dart';

class BorderedTextField extends StatefulWidget {
  const BorderedTextField({
    Key? key,
    this.textStream,
    required this.onTextChanged,
    required this.title,
    this.textInputType = TextInputType.text,
    this.minLines = 1,
    this.maxLines,
    this.textInputAction,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.textAlignVertical = TextAlignVertical.center,
    this.alignLabelWithHint = false,
    this.errorStream,
    this.enabled = true,
    this.obscureText = false,
    this.enableSelection = true,
  }) : super(key: key);

  final Stream<String>? textStream;
  final void Function(String) onTextChanged;
  final TextInputType textInputType;
  final int minLines;
  final int? maxLines;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Stream<String>? errorStream;
  final bool enabled;
  final bool obscureText;
  final bool enableSelection;
  final bool alignLabelWithHint;
  final String title;

  @override
  _BorderedTextFieldState createState() => _BorderedTextFieldState();
}

class _BorderedTextFieldState extends State<BorderedTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.textStream == null) {
      _controller.clear();
    } else {
      widget.textStream?.listen((value) {
        if (value.isEmpty) {
          _controller.clear();
        } else if (_controller.text != value) {
          _controller.text = value;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyles.textFieldTitle(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        StreamBuilder<String>(
          stream: widget.errorStream,
          builder: (context, snapshot) {
            return TextField(
              textAlign: widget.textAlign,
              textAlignVertical: widget.textAlignVertical,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              enableInteractiveSelection: widget.enableSelection,
              enabled: widget.enabled,
              controller: _controller,
              cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
              keyboardType: widget.textInputType,
              textInputAction: widget.textInputAction,
              obscureText: widget.obscureText,
              inputFormatters: [
                ...?widget.inputFormatters,
              ],
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: AppColors.white,
                  ),
              decoration: InputDecoration(
                errorText: snapshot.data,
                errorMaxLines: 3,
                alignLabelWithHint: widget.alignLabelWithHint,
                labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: AppColors.tundora,
                    ),
                errorStyle: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: AppColors.red),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.white,
                  ),
                  borderRadius: BorderRadius.circular(Units.kCardBorderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.white,
                  ),
                  borderRadius: BorderRadius.circular(Units.kCardBorderRadius),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.red,
                  ),
                  borderRadius: BorderRadius.circular(Units.kCardBorderRadius),
                ),
                filled: true,
                fillColor: AppColors.tundora,
              ),
              onChanged: (text) => widget.onTextChanged(text),
            );
          },
        ),
      ],
    );
  }
}
