import 'package:flutter/material.dart';

import '../widget/add_expense.dart';
import '../widget/add_income.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> expenses = [];
  List<Map<String, dynamic>> incomes = [];

  double totalExpenses = 0;
  double totalIncomes = 0;
  double balance = 0;

  // Hàm tính tổng chi tiêu và thu nhập
  void calculateTotals() {
    totalExpenses = expenses.fold(0, (sum, item) => sum + item['amount']);
    totalIncomes = incomes.fold(0, (sum, item) => sum + item['amount']);
    balance = totalIncomes - totalExpenses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Chi '),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Mở màn hình cài đặt hoặc thông tin người dùng
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tổng quan tài chính',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet,
                    color: Colors.green),
                title: const Text('Tổng thu nhập'),
                subtitle: Text('${totalIncomes.toStringAsFixed(0)} VND'),
                trailing: const Icon(Icons.arrow_upward, color: Colors.green),
              ),
            ),
            const SizedBox(height: 10),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.red),
                title: const Text('Tổng chi tiêu'),
                subtitle: Text('${totalExpenses.toStringAsFixed(0)} VND'),
                trailing: const Icon(Icons.arrow_downward, color: Colors.red),
              ),
            ),
            const SizedBox(height: 10),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.account_balance, color: Colors.blue),
                title: const Text('Số dư hiện tại'),
                subtitle: Text('${balance.toStringAsFixed(0)} VND'),
                trailing: const Icon(Icons.check, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 30),

            // Nút điều hướng đến màn hình thêm chi tiêu/thu nhập
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Gọi addExpense khi nhấn nút
                      addExpense(context);
                    },
                    child: const Text('Thêm Chi Tiêu'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Gọi addIncome khi nhấn nút
                      addIncome(context);
                    },
                    child: const Text('Thêm Thu Nhập'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Danh sách các khoản chi tiêu
            const Text(
              'Danh sách Chi Tiêu:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(expense['name']),
                      subtitle: Text(
                          '${expense['amount']} VND - ${expense['category']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            expenses.removeAt(index);
                            calculateTotals();
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
