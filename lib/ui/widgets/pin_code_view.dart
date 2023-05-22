import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeView extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String> onChanged;
  final int length;
  final bool obscureText;
  final bool autoFocus;
  final String? label;
  const PinCodeView({
    required this.controller,
    this.validator,
    this.length=4,
    this.obscureText=false,
    this.autoFocus=false,
    this.onCompleted,
    required this.onChanged,
    this.label,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label!=null)...[
          Text(label!,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              )),
          const SizedBox(height: 15)
        ],
        PinCodeTextField(
          controller: controller,
          length: length,
          obscureText: obscureText,
          autoFocus: autoFocus,
          keyboardType: TextInputType.number,
          animationType: AnimationType.fade,
          autoDismissKeyboard: true,
          validator: validator,
          enablePinAutofill: true,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10.0),
            borderWidth: 1.0,
            fieldHeight: 60,
            fieldWidth: 60,
            activeFillColor: Theme.of(context).canvasColor,
            selectedFillColor: Theme.of(context).canvasColor,
            inactiveFillColor: Theme.of(context).canvasColor,
            inactiveColor: Theme.of(context).canvasColor
          ),
          enableActiveFill: true,
          animationDuration: const Duration(milliseconds: 300),
          onCompleted: onCompleted,
          onChanged: onChanged,
          beforeTextPaste: (text) {
            return true;
          },
          appContext: context,
        )
      ],
    );
  }
}
