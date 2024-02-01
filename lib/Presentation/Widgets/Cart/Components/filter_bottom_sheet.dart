import 'package:filterapi/Presentation/Widgets/Cart/Controller/cart_cubit.dart';
import 'package:filterapi/Presentation/Widgets/Cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FilterBottomSheet extends StatefulWidget {
  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now();
    endDate = DateTime.now();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: DateTimeRange(start: startDate, end: endDate),
    );

    if (picked != null && picked != DateTimeRange(start: startDate, end: endDate)) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });

      context.read<CartsCubit>().getCubitCartsData(startDate, endDate);


    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _selectDateRange(context),
              child: Text('Select Date Range'),
            ),
            SizedBox(height: 20),
            Text(
              '${startDate}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '${endDate}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}



