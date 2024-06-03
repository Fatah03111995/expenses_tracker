import 'package:expenses_tracker/components/input_text.dart';
import 'package:expenses_tracker/themes/textstyles.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(children: [
          Text(
            'Add Expense',
            style: TextStyles.m.copyWith(color: Colors.deepPurple),
          ),
          Form(
            key: _keyForm,
            child: Column(
              children: [
                InputText(
                  textController: titleController,
                  label: 'Title',
                  hint: 'your title expense...',
                ),
                InputText(
                  textController: amountController,
                  label: 'Amount',
                  hint: 'amount that you spend...',
                  prefixText: 'Rp  ',
                  keyboardType: TextInputType.number,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
