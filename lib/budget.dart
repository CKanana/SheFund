import 'package:flutter/material.dart';
// Optional: for localized currency formatting, uncomment and add `intl` to pubspec.yaml
// import 'package:intl/intl.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  String _incomeType = 'Salary';
  double _income = 0.0;
  String _currency = 'KES'; // Default currency

  final List<String> _currencies = ['KES', 'USD', 'EUR', 'GBP'];

  final Map<String, double> _expenses = {
    'Food': 0,
    'Transport': 0,
    'Entertainment': 0,
    'Rent': 0,
    'Other': 0,
  };

  final TextEditingController _incomeController = TextEditingController();
  final Map<String, TextEditingController> _expenseControllers = {};

  @override
  void initState() {
    super.initState();
    // create controllers for each expense field so we can dispose later
    for (final k in _expenses.keys) {
      _expenseControllers[k] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _incomeController.dispose();
    for (final c in _expenseControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  // Helper to parse user input robustly (removes commas)
  double _parse(String val) =>
      double.tryParse(val.replaceAll(',', '').trim()) ?? 0.0;

  @override
  Widget build(BuildContext context) {
    final totalExpenses = _expenses.values.fold(0.0, (a, b) => a + b);
    final savings = _income - totalExpenses;
    final recommendedSavings = _income * 0.2;

    // Determine period based on income type
    final period = _incomeType == "Salary" ? "Monthly" : "Weekly";

    // Optional: format currency values (requires intl)
    // final formatter = NumberFormat.simpleCurrency(locale: 'en_KE', name: _currency);
    // String fmt(double v) => formatter.format(v);

    String fmtSimple(double v) {
      // Basic formatting with thousands separators
      final s = v.round().toString();
      return v == v.roundToDouble() ? s : v.toStringAsFixed(0);
    }

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text("Smart Budget Tracker"),
        backgroundColor: Colors.pink.shade400,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // INCOME CARD
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Income",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _incomeType,
                            items:
                                ['Salary', 'Allowance']
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                            onChanged:
                                (val) => setState(() {
                                  _incomeType = val!;
                                }),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _currency,
                            items:
                                _currencies
                                    .map(
                                      (c) => DropdownMenuItem(
                                        value: c,
                                        child: Text(c),
                                      ),
                                    )
                                    .toList(),
                            onChanged:
                                (val) => setState(() {
                                  _currency = val!;
                                }),
                            decoration: InputDecoration(
                              labelText: "Currency",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _incomeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter $period Income",
                        prefixText: "$_currency ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _income = _parse(val);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // EXPENSES CARD
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$period Expenses",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Divider(),
                    ..._expenses.keys.map((k) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: TextField(
                          controller: _expenseControllers[k],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: k,
                            prefixText: "$_currency ",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              _expenses[k] = _parse(val);
                            });
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // SUMMARY CARD
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Summary",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),

                    // Income row
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.shade100,
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: Colors.green.shade700,
                        ),
                      ),
                      title: Text("Income ($_incomeType - $period)"),
                      trailing: Text(
                        "$_currency ${fmtSimple(_income)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Expenses row
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red.shade100,
                        child: Icon(
                          Icons.money_off,
                          color: Colors.red.shade700,
                        ),
                      ),
                      title: const Text("Total Expenses"),
                      trailing: Text(
                        "$_currency ${fmtSimple(totalExpenses)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Savings row
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            savings < 0
                                ? Colors.red.shade100
                                : Colors.blue.shade100,
                        child: Icon(
                          savings < 0 ? Icons.warning : Icons.savings,
                          color:
                              savings < 0
                                  ? Colors.red.shade700
                                  : Colors.blue.shade700,
                        ),
                      ),
                      title: const Text("Savings"),
                      trailing: Text(
                        "$_currency ${fmtSimple(savings)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: savings < 0 ? Colors.red : Colors.green,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Progress bar (rounded)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value:
                            (_income > 0)
                                ? (totalExpenses / _income).clamp(0.0, 1.0)
                                : 0.0,
                        minHeight: 12,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          savings < 0 ? Colors.red : Colors.pink.shade400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Advice / message
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            savings < 0
                                ? Colors.red.shade50
                                : (savings < recommendedSavings
                                    ? Colors.orange.shade50
                                    : Colors.green.shade50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        savings < 0
                            ? "⚠️ Overspending by $_currency ${fmtSimple(savings.abs())} this $period."
                            : (savings < recommendedSavings
                                ? "💡 Try to save at least $_currency ${fmtSimple(recommendedSavings)} this $period."
                                : "✅ Great! You're saving enough for this $period."),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color:
                              savings < 0
                                  ? Colors.red.shade700
                                  : (savings < recommendedSavings
                                      ? Colors.orange.shade700
                                      : Colors.green.shade700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Small tips / actions row
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              final goal = recommendedSavings.round();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Set KES $goal as savings goal (not implemented)',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.flag),
                            label: const Text('Set savings goal'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // reset inputs
                              _incomeController.clear();
                              for (final c in _expenseControllers.values) {
                                c.clear();
                              }
                              setState(() {
                                _income = 0.0;
                                for (final k in _expenses.keys) {
                                  _expenses[k] = 0.0;
                                }
                              });
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reset'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
