import 'package:flutter/material.dart';

///This Numpad uses the same TextEditingController as
///that of the input field that displays the texts.
class NumPad extends StatelessWidget {
  final TextEditingController? textEditingController;
  final int? maxLength;

  NumPad({
    super.key,
    this.textEditingController,
    this.maxLength,
  }) : controller = textEditingController ?? TextEditingController();

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          childAspectRatio: 2.3,
          children: List.generate(12, (index) {
            if (index == 9) {
              return TextButton(
                onPressed: null,
                child: SizedBox.shrink(),
              );
            }
            if (index == 10) {
              return _NumberButton(
                number: 0,
                controller: controller,
                maxLength: maxLength,
              );
            }
            if (index == 11) {
              return TextButton(
                onPressed: () {
                  if (controller.text.isNotEmpty)
                    controller.text = controller.text
                        .substring(0, controller.text.length - 1);
                },

                /// you can always change the delete icon.
                child: Assets.svgs.backSpaceIcon.svg(),
              );
            }

            return _NumberButton(
              number: index + 1,
              controller: controller,
              maxLength: maxLength,
            );
          }),
        ),
      ],
    );
  }
}

// define NumberButton widget
class _NumberButton extends StatelessWidget {
  final int number;
  final int? maxLength;
  final TextEditingController controller;

  const _NumberButton({
    Key? key,
    required this.number,
    required this.controller,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        onPressed: () {
          if (maxLength != null) {
            if (controller.text.length <= maxLength! - 1) {
              controller.text += number.toString();
            }
          } else {
            controller.text += number.toString();
          }
        },
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 32,
            ),
          ),
        ),
      ),
    );
  }
}
