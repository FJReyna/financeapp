import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinInputField extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;
  final VoidCallback? onChanged;
  final bool obscureText;

  const PinInputField({
    super.key,
    this.length = 4,
    required this.onCompleted,
    this.onChanged,
    this.obscureText = true,
  });

  @override
  State<PinInputField> createState() => _PinInputFieldState();
}

class _PinInputFieldState extends State<PinInputField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        if (widget.onChanged != null) {
          widget.onChanged!();
        }
        if (_controller.text.length == widget.length) {
          widget.onCompleted(_controller.text);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void clear() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Stack(
        children: [
          Opacity(
            opacity: 0,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.number,
              maxLength: widget.length,
              autofocus: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.length, (index) {
              final isFilled = index < _controller.text.length;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isFilled
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                    width: 2,
                  ),
                  color: isFilled
                      ? Theme.of(context).colorScheme.primary.withAlpha(38)
                      : Colors.transparent,
                ),
                child: Center(
                  child: widget.obscureText
                      ? (isFilled
                            ? Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                            : null)
                      : (isFilled
                            ? Text(
                                _controller.text[index],
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                            : null),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
