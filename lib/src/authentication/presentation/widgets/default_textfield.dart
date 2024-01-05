import 'package:flutter/material.dart';
import 'package:house_rental_admin/core/size/sizes.dart';
import 'package:house_rental_admin/core/spacing/whitspacing.dart';

class DefaultTextfield extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final String? hintText;
  final String? errorText;
  final String? label;
  final TextInputType? textInputType;
  const DefaultTextfield(
      {super.key,
      this.onChanged,
      required this.controller,
      this.hintText,
      this.textInputType,
      this.errorText,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //height: Sizes().height(context, 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label!),
          Space().height(context, 0.004),
          SizedBox(
            height: Sizes().height(context, 0.06),
            child: TextField(
              keyboardType: textInputType,
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                errorText: errorText,
                contentPadding: const EdgeInsets.all(10),
                hintText: hintText,
                hintStyle: const TextStyle(color:Colors.grey),
                //label: Text(label!),
                border:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Sizes().height(context,0.04)),
                  borderSide:const BorderSide(color: Colors.black26),
                ),
                enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(Sizes().height(context,0.04)),
                  borderSide: const BorderSide(color: Colors.black26),
                ),
                errorBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(Sizes().height(context,0.04)),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
            ),
          ),
          Space().height(context, 0.03)
        ],
      ),
    );
  }
}
