import 'package:finance/core/util/extensions.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:flutter/material.dart';

class TransactionTypeSwitch extends StatefulWidget {
  final TransactionType transactionType;
  final ValueChanged<TransactionType> onChanged;

  const TransactionTypeSwitch({
    super.key,
    required this.transactionType,
    required this.onChanged,
  });

  @override
  State<TransactionTypeSwitch> createState() => _TransactionTypeSwitchState();
}

class _TransactionTypeSwitchState extends State<TransactionTypeSwitch>
    with SingleTickerProviderStateMixin {
  late Animation<Alignment> animation;
  late AnimationController animationController;

  bool val = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    animation =
        AlignmentTween(
          begin: widget.transactionType == TransactionType.income
              ? Alignment.centerRight
              : Alignment.centerLeft,
          end: widget.transactionType == TransactionType.income
              ? Alignment.centerLeft
              : Alignment.centerRight,
        ).animate(
          CurvedAnimation(parent: animationController, curve: Curves.linear),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (animationController.isCompleted) {
              animationController.reverse();
            } else {
              animationController.forward();
            }
            widget.onChanged(
              widget.transactionType == TransactionType.income
                  ? TransactionType.expense
                  : TransactionType.income,
            );
          },
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.lerp(
                    Alignment.centerLeft,
                    Alignment.center,
                    0.5,
                  )!,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(context.translate.expenses),
                  ),
                ),
                Align(
                  alignment: Alignment.lerp(
                    Alignment.center,
                    Alignment.centerRight,
                    0.5,
                  )!,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(context.translate.income),
                  ),
                ),
                Align(
                  alignment: animation.value,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.475 - 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius:
                            widget.transactionType == TransactionType.income
                            ? BorderRadius.only(
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              )
                            : BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                        border: Border.all(
                          color:
                              widget.transactionType == TransactionType.income
                              ? Theme.of(
                                  context,
                                ).colorScheme.primary.withAlpha(200)
                              : Theme.of(
                                  context,
                                ).colorScheme.secondary.withAlpha(200),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.transactionType == TransactionType.income
                              ? context.translate.income
                              : context.translate.expenses,
                          style: TextStyle(
                            color:
                                widget.transactionType == TransactionType.income
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
