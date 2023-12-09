import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_strings.dart';
import '../../core/constant/app_svg.dart';
import '../../core/functions/functions.dart';

class SearchTextFieldWidget extends StatefulWidget {
  const SearchTextFieldWidget({super.key, this.onSubmitted});

  final void Function(String)? onSubmitted;

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgImage(
            path: isEnglish() ? AppSvg.arrowLeft : AppSvg.arrowRight,
            color: AppColor.black,
            size: 26,
          ),
        ),
        Expanded(
          child: TextField(
            autofocus: true,
            controller: _controller,
            textDirection: getTextDirection(_controller.text),
            textInputAction: TextInputAction.search,
            onChanged: (_) => setState(() {}),
            onSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: AppStrings.search.tr,
            ),
          ),
        ),
        if (_controller.text.isNotEmpty)
          IconButton(
            onPressed: () => setState(() => _controller.text = ''),
            icon: const SvgImage(
              path: AppSvg.close,
              color: AppColor.black,
              size: 26,
            ),
          ),
      ],
    );
  }
}
