import 'package:expenses_tracker/components/input_text.dart';
import 'package:expenses_tracker/utility/time.dart';
import 'package:expenses_tracker/themes/textstyles.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;

  void selectDate() async {
    DateTime? pickedDate = await Time.selectDate(context);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String inputDate = _selectedDate == null
        ? 'No Date Selected'
        : Time.dateFormatYmd(_selectedDate!);

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
                  textController: _titleController,
                  label: 'Title',
                  hint: 'your title expense...',
                ),
                InputText(
                  textController: _amountController,
                  label: 'Amount',
                  hint: 'amount that you spend...',
                  prefixText: 'Rp  ',
                  keyboardType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            selectDate();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                size: 20,
                                color: Colors.deepPurple,
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  inputDate,
                                  style: TextStyles.s
                                      .copyWith(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('dropdown'))),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
