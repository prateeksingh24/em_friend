import 'package:flutter/material.dart';

import '../utils/AppColor.dart';

class RememberCheckBox extends StatefulWidget {
  final void Function(bool) onRememberChanged;

  const RememberCheckBox({super.key, required this.onRememberChanged});

  @override
  State<RememberCheckBox> createState() => _RememberCheckBoxState();
}

class _RememberCheckBoxState extends State<RememberCheckBox> {
  bool isRemember = false;

  void onClicked(){
    setState(() {
      isRemember = !isRemember;
    });

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                  color: isRemember ? AppColors.kPrimary : null,
                  borderRadius: BorderRadius.circular(6),
                  border: !isRemember
                      ? Border.all(color: const Color(0xFFB6B6B8))
                      : null),
              child: isRemember
                  ? Icon(
                Icons.done,
                size: 14,
                color: AppColors.kLightWhite,
              )
                  : null,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          const Text(
            'Remember',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
