// add_expense.dart
import 'package:flutter/material.dart';

void addExpense(BuildContext context) {
  String name = '';
  double amount = 0;
  String description = '';
  String category = 'Ăn uống';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Thêm Chi Tiêu'),
        content: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Tên khoản chi'),
              onChanged: (value) {
                name = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Số tiền'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                amount = double.tryParse(value) ?? 0;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Mô tả'),
              onChanged: (value) {
                description = value;
              },
            ),
            DropdownButton<String>(
              value: category,
              onChanged: (String? newCategory) {
                category = newCategory!;
              },
              items: <String>['Ăn uống', 'Giải trí', 'Mua sắm']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // Lưu thông tin chi tiêu ở đây
              Navigator.of(context).pop();
            },
            child: const Text('Lưu'),
          ),
        ],
      );
    },
  );
}
