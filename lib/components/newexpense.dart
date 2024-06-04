import 'package:expenses_tracker/components/input_text.dart';
import 'package:expenses_tracker/controller/category.dart';
import 'package:expenses_tracker/utility/time.dart';
import 'package:expenses_tracker/themes/textstyles.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  final Function onAdd;
  const NewExpense({super.key, required this.onAdd});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  Category category = Category.others;

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
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: DropdownButton(
                              items: Category.values
                                  .map((el) => DropdownMenuItem(
                                        value: el,
                                        child: Text(
                                          el.name,
                                          style: TextStyles.s,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) => setState(() {
                                    category = value!;
                                  }),
                              dropdownColor: Colors.deepPurple,
                              value: category),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.deepPurple),
                      // Colors.deepPurple,
                    ),
                    onPressed: () {
                      if (_keyForm.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          'title': _titleController.text,
                          'amount': _amountController.text,
                          'category': category.name,
                          'createdAt': _selectedDate == null
                              ? Time.timeNow.millisecondsSinceEpoch
                              : _selectedDate!.millisecondsSinceEpoch,
                        };
                        widget.onAdd(data, context);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'save',
                      style: TextStyles.smBold.copyWith(color: Colors.white),
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
