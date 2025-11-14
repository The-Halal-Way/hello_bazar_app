import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class CmOtpField extends StatefulWidget {
  const CmOtpField({super.key, required this.length, required this.onSubmit});
  final int length;
  final Function(String val) onSubmit;
  @override
  State<CmOtpField> createState() => _CmOtpFieldState();
}

class _CmOtpFieldState extends State<CmOtpField> {
  final _formKey = GlobalKey<FormState>();
  final _otpController1 = TextEditingController();
  final _otpController2 = TextEditingController();
  final _otpController3 = TextEditingController();
  final _otpController4 = TextEditingController();
  final List<TextEditingController> _otpControllerList = [];
  final _otpFocusNode1 = FocusNode();
  final _otpFocusNode2 = FocusNode();
  final _otpFocusNode3 = FocusNode();
  final _otpFocusNode4 = FocusNode();
  final List<FocusNode> _otpFocusList = [];

  @override
  void initState() {
    super.initState();
    _otpFocusList.add(_otpFocusNode1);
    _otpFocusList.add(_otpFocusNode2);
    _otpFocusList.add(_otpFocusNode3);
    _otpFocusList.add(_otpFocusNode4);
    _otpControllerList.add(_otpController1);
    _otpControllerList.add(_otpController2);
    _otpControllerList.add(_otpController3);
    _otpControllerList.add(_otpController4);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              widget.length,
              (i) {
                final isLastItem = i == widget.length - 1;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: isLastItem ? 0 : 8),
                    child: _getCmOtpField(
                      cntrl: _otpControllerList[i],
                      currentFocus: _otpFocusList[i],
                      // if it's last otp-field then we don't need nextFocus
                      nextFocus: isLastItem ? null : _otpFocusList[i + 1],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    String confirmedOTP = '';
    for (int i = 0; i < widget.length; i++) {
      confirmedOTP = [confirmedOTP, _otpControllerList[i].text].join();
    }
    widget.onSubmit(confirmedOTP);
  }

  TextFormField _getCmOtpField(
      {required TextEditingController cntrl,
      required FocusNode currentFocus,
      FocusNode? nextFocus}) {
    return TextFormField(
      controller: cntrl,
      focusNode: currentFocus,
      keyboardType: TextInputType.number,
      textInputAction:
          nextFocus == null ? TextInputAction.done : TextInputAction.next,
      textAlign: TextAlign.center,
      style: const TextStyle(height: 0),
      // setiing maximum length of each field is 1
      inputFormatters: [LengthLimitingTextInputFormatter(1)],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: MyColor.gray300, width: 2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: MyColor.gray400, width: .3),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorStyle: const TextStyle(height: 0),
      ),
      onChanged: (val) {
        if (val.isEmpty) {
          // if we remove a OTP-text, we may wanna stay on the same field, so doing nothing
        } else if (nextFocus != null) {
          // goint to next-Field if it's not the last OTP-Field
          FocusScope.of(context).nextFocus();
        } else if (nextFocus == null) {
          // for last OTP-Field, we r removing focus automatically
          FocusManager.instance.primaryFocus?.unfocus();
          _onSubmit();
        } else {
          FocusScope.of(context).canRequestFocus;
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) return '';
        return null;
      },
      // if user press somewhere but on textfield then keyboard & focus dismissed
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

  @override
  void dispose() {
    _otpFocusNode1.dispose();
    _otpFocusNode2.dispose();
    _otpFocusNode3.dispose();
    _otpFocusNode4.dispose();
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    super.dispose();
  }
}
