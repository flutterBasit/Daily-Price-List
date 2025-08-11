// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Customdropdown extends StatefulWidget {
//   final List<String> items;
//   final String? hint;
//   final String selectedValue;
//   final bool enabled;
//   final Function(String) onChanged;

//   Customdropdown(
//       {super.key,
//       required this.items,
//       this.hint,
//       required this.selectedValue,
//       this.enabled = true,
//       required this.onChanged});

//   @override
//   State<Customdropdown> createState() => _CustomdropdownState();
// }

// class _CustomdropdownState extends State<Customdropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return IgnorePointer(
//       ignoring: !widget.enabled,
//       child: Opacity(
//         opacity: widget.enabled ? 1.0 : 0.5,
//         child: DropdownButton<String>(
//           value: widget.selectedValue.isEmpty ? null : widget.selectedValue,
//           isExpanded: true,
//           hint: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: Text(widget.hint ?? ''),
//           ),
//           items: widget.items
//               .map((item) => DropdownMenuItem<String>(
//                   value: item,
//                   child: Container(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//                     child: Text(item),
//                   )))
//               .toList(),
//           onChanged: widget.enabled
//               ? (val) {
//                   if (val != null) widget.onChanged(val);
//                 }
//               : null, // its a required one but ignored as because of we used INKWELL
//           icon: Padding(
//             padding: EdgeInsets.only(right: 16.w),
//             child: Icon(Icons.keyboard_arrow_down),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customdropdown extends StatefulWidget {
  final List<String> items;
  final String? hint;
  final String selectedValue;
  final bool enabled;
  final Function(String) onChanged;

  Customdropdown({
    super.key,
    required this.items,
    this.hint,
    required this.selectedValue,
    this.enabled = true,
    required this.onChanged,
  });

  @override
  State<Customdropdown> createState() => _CustomdropdownState();
}

class _CustomdropdownState extends State<Customdropdown> {
  @override
  Widget build(BuildContext context) {
    // Validate selected value against items
    final isValidValue = widget.items.contains(widget.selectedValue);
    final currentValue = isValidValue ? widget.selectedValue : null;

    return IgnorePointer(
      ignoring: !widget.enabled,
      child: Opacity(
        opacity: widget.enabled ? 1.0 : 0.5,
        child: DropdownButton<String>(
          value: currentValue,
          isExpanded: true,
          hint: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(widget.hint ?? ''),
          ),
          items: widget.items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      child: Text(item),
                    ),
                  ))
              .toList(),
          onChanged: widget.enabled
              ? (val) {
                  if (val != null) widget.onChanged(val);
                }
              : null,
          icon: Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ),
    );
  }
}
