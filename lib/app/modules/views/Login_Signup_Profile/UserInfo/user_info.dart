import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:flutter/material.dart';

class UserInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, color: MyColors.white),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14, color: MyColors.white),
          ),
        ],
      ),
    );
  }
}
