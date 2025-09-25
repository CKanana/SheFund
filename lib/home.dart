import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const SheFundApp());
}

class SheFundApp extends StatelessWidget {
  const SheFundApp({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryPink = Color(0xFFe91e63);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SheFund',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryPink,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryPink,
          secondary: Colors.purpleAccent,
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: primaryPink,
        ),
        textTheme: const TextTheme(),
      ),
      home: const SheFundHomePage(),
    );
  }
}

class SheFundHomePage extends StatefulWidget {
  const SheFundHomePage({super.key});

  @override
  State<SheFundHomePage> createState() => _SheFundHomePageState();
}

class _SheFundHomePageState extends State<SheFundHomePage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const [
      HomeContent(),
      GroupsPage(),
      BudgetPage(),
      TipsPage(),
      AddDependantPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Groups'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Budget'),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.lightbulb),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Dependants',
          ),
        ],
      ),
    );
  }
}

// ------------------------- Home Content -------------------------
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final pink = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Good morning, Tracy',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Welcome to SheFund',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.notifications_none),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Balance card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink.shade200, Colors.pink.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.shade200.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your balance',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '\$0.00',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      onPressed: () => _showAddMoney(context),
                      child: Text('Add money', style: TextStyle(color: pink)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Quick actions
              Text(
                'Quick actions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ActionButton(
                    icon: Icons.send,
                    label: 'Send',
                    onTap: () => _notImplemented(context),
                  ),
                  _ActionButton(
                    icon: Icons.request_page,
                    label: 'Request',
                    onTap: () => _notImplemented(context),
                  ),
                  _ActionButton(
                    icon: Icons.savings,
                    label: 'Save',
                    onTap: () => _notImplemented(context),
                  ),
                  _ActionButton(
                    icon: Icons.group,
                    label: 'Groups',
                    onTap: () => _notImplemented(context),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Goals / Savings
              Text(
                'Savings goals',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    SavingsCard(
                      title: 'Emergency Fund',
                      target: 2000,
                      saved: 900,
                    ),
                    SizedBox(width: 12),
                    SavingsCard(
                      title: 'Business Seed',
                      target: 5000,
                      saved: 1200,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Your cards',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text('+ New card', style: TextStyle(color: Colors.pink)),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CardItem(number: '**** 4568', type: 'Debit'),
                    SizedBox(width: 12),
                    CardItem(number: '**** 1234', type: 'Credit'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Transactions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Transactions',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text('See all', style: TextStyle(color: Colors.pink)),
                ],
              ),
              const SizedBox(height: 12),
              const TransactionItem(
                title: 'Starbucks Coffee',
                subtitle: 'Oct 17, 9:00 PM',
                amount: '-\$44.80',
              ),
              const TransactionItem(
                title: 'Savings interest',
                subtitle: 'Oct 12',
                amount: '+\$1.65',
              ),

              const SizedBox(height: 24),

              // Empowerment section - learning + resources
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Empowerment',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Short courses, microloan tips and group saving resources to help you grow.',
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _notImplemented(context),
                          icon: const Icon(Icons.school),
                          label: const Text('Learn'),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton.icon(
                          onPressed: () => _notImplemented(context),
                          icon: const Icon(Icons.handshake),
                          label: const Text('Join Circle'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  static void _showAddMoney(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (c) => AlertDialog(
            title: const Text('Add money'),
            content: const Text('This is a placeholder for add-money flow.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  static void _notImplemented(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feature not implemented in the demo')),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.pink),
              const SizedBox(height: 6),
              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

class SavingsCard extends StatelessWidget {
  final String title;
  final double target;
  final double saved;
  const SavingsCard({
    required this.title,
    required this.target,
    required this.saved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (saved / target).clamp(0.0, 1.0);
    return Container(
      width: 260,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(blurRadius: 6, color: Colors.black12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            '\$${saved.toStringAsFixed(0)} saved of \$${target.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress, minHeight: 8),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${(progress * 100).toStringAsFixed(0)}%'),
              ElevatedButton(
                onPressed:
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Top up not implemented')),
                    ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                child: const Text('Top up'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String number;
  final String type;
  const CardItem({required this.number, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade100, Colors.pink.shade300],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(type, style: const TextStyle(color: Colors.black54)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                number,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text(
                  'Details',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  const TransactionItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.pink.shade100,
        child: Icon(FontAwesomeIcons.store, color: Colors.pink),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(
        amount,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: amount.startsWith('-') ? Colors.red : Colors.green,
        ),
      ),
    );
  }
}

// ------------------------- Groups Page -------------------------
class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final List<Map<String, dynamic>> _groups = [
    {'name': 'Mothers Circle', 'members': 8, 'pot': 1200.0},
    {'name': 'Entrepreneurs', 'members': 5, 'pot': 800.0},
  ];

  void _createGroup() {
    final nameCtrl = TextEditingController();
    showDialog(
      context: context,
      builder:
          (c) => AlertDialog(
            title: const Text('Create group'),
            content: TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(hintText: 'Group name'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = nameCtrl.text.trim();
                  if (name.isNotEmpty) {
                    setState(
                      () =>
                          _groups.add({'name': name, 'members': 1, 'pot': 0.0}),
                    );
                    Navigator.pop(c);
                  }
                },
                child: const Text('Create'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text('Groups'),
        backgroundColor: Colors.pink.shade300,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _createGroup,
              icon: const Icon(Icons.add),
              label: const Text('Create new group'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _groups.length,
                itemBuilder: (context, i) {
                  final g = _groups[i];
                  return Card(
                    child: ListTile(
                      title: Text(g['name']),
                      subtitle: Text(
                        '${g['members']} members • pot \$${g['pot']}',
                      ),
                      trailing: ElevatedButton(
                        onPressed:
                            () => ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Join flow not implemented'),
                              ),
                            ),
                        child: const Text('Join'),
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

// ------------------------- Budget Page -------------------------
class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final Map<String, double> _budgetCategories = {
    'Groceries': 300,
    'Transport': 100,
    'Savings': 400,
    'Entertainment': 80,
  };

  final Map<String, double> _spent = {
    'Groceries': 150,
    'Transport': 40,
    'Savings': 120,
    'Entertainment': 50,
  };

  @override
  Widget build(BuildContext context) {
    final totalBudget = _budgetCategories.values.fold(0.0, (a, b) => a + b);
    final totalSpent = _spent.values.fold(0.0, (a, b) => a + b);

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text('Budget'),
        backgroundColor: Colors.pink.shade300,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Monthly summary',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Budget: \$${totalBudget.toStringAsFixed(0)}  •  Spent: \$${totalSpent.toStringAsFixed(0)}',
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: (totalSpent / totalBudget).clamp(0.0, 1.0),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children:
                    _budgetCategories.keys.map((k) {
                      final bud = _budgetCategories[k]!;
                      final s = _spent[k] ?? 0.0;
                      final pct = (s / bud).clamp(0.0, 1.0);
                      return Card(
                        child: ListTile(
                          title: Text(k),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$${s.toStringAsFixed(0)} spent of \$${bud.toStringAsFixed(0)}',
                              ),
                              const SizedBox(height: 6),
                              LinearProgressIndicator(value: pct),
                            ],
                          ),
                          trailing: Text('${(pct * 100).toStringAsFixed(0)}%'),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------- Tips Page -------------------------
class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  final List<String> _tips = const [
    'Start a small emergency fund: even \$1 a day adds up.',
    'Track your spending for 7 days to find savings.',
    'Join a group/savings circle for accountability and loans.',
    'Automate transfers to savings right after payday.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text('Tips'),
        backgroundColor: Colors.pink.shade300,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Daily tips and articles',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _tips.length,
                itemBuilder:
                    (c, i) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.pink.shade100,
                          child: Text('${i + 1}'),
                        ),
                        title: Text(_tips[i]),
                        onTap:
                            () => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Open article not implemented'),
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
  }
}

// ------------------------- Add Dependant Page -------------------------
class AddDependantPage extends StatefulWidget {
  const AddDependantPage({super.key});

  @override
  State<AddDependantPage> createState() => _AddDependantPageState();
}

class _AddDependantPageState extends State<AddDependantPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _relationCtrl = TextEditingController();
  DateTime? _dob;

  void _pickDob() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 5),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) setState(() => _dob = picked);
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      // In real app you'd persist this
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Dependant saved')));
      _nameCtrl.clear();
      _relationCtrl.clear();
      setState(() => _dob = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text('Add Dependant'),
        backgroundColor: Colors.pink.shade300,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator:
                    (v) =>
                        (v == null || v.trim().isEmpty) ? 'Enter name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _relationCtrl,
                decoration: const InputDecoration(labelText: 'Relation'),
                validator:
                    (v) =>
                        (v == null || v.trim().isEmpty)
                            ? 'Enter relation'
                            : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _dob == null
                          ? 'Date of birth: not selected'
                          : 'DOB: ${_dob!.toLocal().toIso8601String().split('T').first}',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickDob,
                    child: const Text('Pick'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(child: Text('Save')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------- Utilities -------------------------
// Note: use Image.asset with errorBuilder where needed. For avatars we provide a safe widget.
class ProfileAvatar extends StatelessWidget {
  final String? assetPath;
  final String initials;
  final double radius;
  const ProfileAvatar({
    this.assetPath,
    this.initials = 'T',
    this.radius = 18,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (assetPath == null) {
      return CircleAvatar(radius: radius, child: Text(initials));
    }

    return ClipOval(
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: Image.asset(
          assetPath!,
          fit: BoxFit.cover,
          errorBuilder:
              (c, e, s) => CircleAvatar(radius: radius, child: Text(initials)),
        ),
      ),
    );
  }
}
