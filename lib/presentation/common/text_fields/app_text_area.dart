import 'package:flutter/material.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';

class AppTextArea extends StatefulWidget {
  final Function(String value) onChanged;
  final String? hintText;
  final String? initialValue;
  final int? maxLines;
  final bool readOnly;

  const AppTextArea(
      {super.key,
      required this.onChanged,
      this.hintText,
      this.initialValue,
      this.maxLines = 1,
      this.readOnly = false});

  @override
  State<AppTextArea> createState() => _AppTextAreaState();
}

class _AppTextAreaState extends State<AppTextArea> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  InputDecoration _inputdecoration() => InputDecoration(
      contentPadding: const EdgeInsets.all(8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      hintText: widget.hintText,
      filled: true,
      fillColor: widget.readOnly ? Colors.grey[400] : AppColors.secondary);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      minLines: widget.maxLines,
      readOnly: widget.readOnly,
      initialValue: widget.initialValue,
      cursorColor: Colors.black,
      focusNode: _focusNode,
      onTapOutside: (event) => _focusNode.unfocus(),
      onChanged: widget.onChanged,
      decoration: _inputdecoration(),
    );
  }
}
