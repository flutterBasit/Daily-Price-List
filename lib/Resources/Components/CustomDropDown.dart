import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customdropdown extends StatefulWidget {
  final List<String> items;
  final String? hint;
  final String selectedValue;
  final bool enabled;
  final Function(String) onChanged;

  Customdropdown(
      {super.key,
      required this.items,
      this.hint,
      required this.selectedValue,
      this.enabled = true,
      required this.onChanged});

  @override
  State<Customdropdown> createState() => _CustomdropdownState();
}

class _CustomdropdownState extends State<Customdropdown> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.enabled,
      child: Opacity(
        opacity: widget.enabled ? 1.0 : 0.5,
        child: Container(
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 6,
                    offset: Offset(0, 3))
              ]),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
            value: widget.selectedValue.isEmpty ? null : widget.selectedValue,
            isExpanded: true,
            hint: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(widget.hint ?? ''),
            ),
            items: widget.items
                .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: InkWell(
                      onTap: () {
                        widget.onChanged(item);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        child: Text(item),
                      ),
                    )))
                .toList(),
            onChanged:
                (_) {}, // its a required one but ignored as because of we used INKWELL
            icon: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Icon(Icons.keyboard_arrow_down),
            ),
          )),
        ),
      ),
    );
  }
}
