// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expenses_tracker/components/util_component.dart';
import 'package:flutter/material.dart';

import 'package:expenses_tracker/themes/textstyles.dart';
import 'package:expenses_tracker/utility/time.dart';

class DateFilter extends StatefulWidget {
  final Function onFilter;

  const DateFilter({
    super.key,
    required this.onFilter,
  });

  @override
  State<DateFilter> createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  DateTime? _startPickedDate;
  DateTime? _endPickedDate;

  void selectStartDate() async {
    DateTime? pickedDate = await Time.selectDate(context);
    setState(() {
      _startPickedDate = pickedDate;
    });
  }

  void selectEndDate() async {
    DateTime? pickedDate = await Time.selectDate(context);
    setState(() {
      _endPickedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    String startPickedDateString = _startPickedDate == null
        ? 'No Date Selected'
        : Time.dateFormatYmd(_startPickedDate!);
    String endPickedDateString = _endPickedDate == null
        ? 'No Date Selected'
        : Time.dateFormatYmd(_endPickedDate!);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Start Date',
                style: TextStyles.smBold.copyWith(color: Colors.white),
              ),
              TextButton(
                onPressed: () {
                  selectStartDate();
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(startPickedDateString),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'End Date',
                style: TextStyles.smBold.copyWith(color: Colors.white),
              ),
              TextButton(
                onPressed: () {
                  selectEndDate();
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(endPickedDateString),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.deepPurple)),
              onPressed: () {
                if (_startPickedDate == null || _endPickedDate == null) {
                  UtilComponent.showSnackBar(
                      context: context,
                      text: 'Please Fill All',
                      color: Colors.red);
                  return;
                }
                widget.onFilter(start: _startPickedDate, end: _endPickedDate);
                Navigator.pop(context);
              },
              child: Text(
                'FILTER',
                style: TextStyles.sm.copyWith(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
