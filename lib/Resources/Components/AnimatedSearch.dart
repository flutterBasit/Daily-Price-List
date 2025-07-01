import 'package:flutter/material.dart';

class AnimatedSearchBar extends StatefulWidget {
  final Function(String) onChanged;
  final String hintText;

  const AnimatedSearchBar({
    super.key,
    required this.onChanged,
    this.hintText = "Search...",
  });

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  bool _isExpanded = false;
  final TextEditingController _controller = TextEditingController();

  void _toggleSearch() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (!_isExpanded) {
        _controller.clear();
        widget.onChanged('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: _isExpanded ? MediaQuery.of(context).size.width * 0.9 : 64,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(_isExpanded ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
          if (_isExpanded)
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
