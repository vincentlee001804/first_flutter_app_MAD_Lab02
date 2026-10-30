import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentInfoApp());
}

// Main Application
class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

// Student Profile Screen
class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),

      // Adaptive Layout
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }

  // Portrait Layout
  Widget _buildPortraitView() {
    return ListView(
      children: const [
        StudentDetailsSection(),

        TitleSection(
          name: 'University of Technology Sarawak',
          location: 'Sibu, Sarawak',
          starCount: 41,
        ),

        // UTS Campus Image
        ImageSection(),

        // Pickers Section (Exercise 2.2 Pickers)
        PickerSection(),
      ],
    );
  }

  // Landscape Layout
  Widget _buildLandscapeView() {
    return Row(
      children: [
        // Left Side: Student Details & Pickers
        Expanded(
          child: ListView(
            children: const [
              StudentDetailsSection(),
              PickerSection(),
            ],
          ),
        ),

        // Right Side: Location Details and Image
        Expanded(
          child: ListView(
            children: const [
              TitleSection(
                name: 'University of Technology Sarawak',
                location: 'Sibu, Sarawak',
                starCount: 41,
              ),

              ImageSection(),
            ],
          ),
        ),
      ],
    );
  }
}

// Student Details Section
class StudentDetailsSection extends StatelessWidget {
  const StudentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo,
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),

            const SizedBox(height: 20),

            const Text(
              'VINCENT LEE CHENG HONG',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Student ID: BCS24020018',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),

            const Divider(
              height: 32,
              thickness: 1,
              color: Colors.white54,
            ),

            const Text(
              'Personal Life Goal / Quote:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              '"Have a job"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Exercise 2.1: Title Section
class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.star,
            color: Colors.indigo[400],
          ),

          const SizedBox(width: 4),

          Text('$starCount'),
        ],
      ),
    );
  }
}

// UTS Campus Image Section
class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/uts_sibu.png',
          width: double.infinity,
          height: 180,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Section 2.2: Pickers (Material vs. Cupertino)
class PickerSection extends StatefulWidget {
  const PickerSection({super.key});

  @override
  State<PickerSection> createState() => _PickerSectionState();
}

class _PickerSectionState extends State<PickerSection> {
  DateTime _selectedDate = DateTime.now();
  String _selectedRole = 'Student';

  final List<String> _roles = ['Student', 'Developer', 'Designer'];

  // Material Date Picker
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Cupertino Date Picker (Modal Sheet)
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 240,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: _selectedDate,
          onDateTimeChanged: (DateTime newDate) {
            setState(() => _selectedDate = newDate);
          },
        ),
      ),
    );
  }

  // Selection Pickers: Cupertino Picker (Wheel)
  void _showCupertinoRolePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 200,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoPicker(
          itemExtent: 32,
          scrollController: FixedExtentScrollController(
            initialItem: _roles.contains(_selectedRole)
                ? _roles.indexOf(_selectedRole)
                : 0,
          ),
          onSelectedItemChanged: (int index) {
            setState(() => _selectedRole = _roles[index]);
          },
          children: _roles.map((role) => Center(child: Text(role))).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pickers: Material vs Cupertino',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),

            // Display current selected values
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 6,
                children: [
                  Text(
                    'Date: ${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Role: $_selectedRole',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 1. Date Pickers Section
            const Text(
              'Date Pickers',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 300) {
                  return Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _selectMaterialDate(context),
                          icon: const Icon(Icons.calendar_today, size: 18),
                          label: const Text('Material Date'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CupertinoButton.filled(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          onPressed: () => _showCupertinoDatePicker(context),
                          child: const Text(
                            'Cupertino Date',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _selectMaterialDate(context),
                        icon: const Icon(Icons.calendar_today, size: 18),
                        label: const Text('Material Date'),
                      ),
                      const SizedBox(height: 8),
                      CupertinoButton.filled(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        onPressed: () => _showCupertinoDatePicker(context),
                        child: const Text(
                          'Cupertino Date',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),

            const SizedBox(height: 16),

            // 2. Selection Pickers Section
            const Text(
              'Role / Selection Pickers',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                Widget dropdownWidget = Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedRole,
                      isExpanded: true,
                      items: _roles.map((String role) {
                        return DropdownMenuItem<String>(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() => _selectedRole = newValue);
                        }
                      },
                    ),
                  ),
                );

                Widget cupertinoWheelButton = CupertinoButton.filled(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  onPressed: () => _showCupertinoRolePicker(context),
                  child: const Text(
                    'Cupertino Wheel',
                    style: TextStyle(fontSize: 14),
                  ),
                );

                if (constraints.maxWidth > 300) {
                  return Row(
                    children: [
                      Expanded(child: dropdownWidget),
                      const SizedBox(width: 8),
                      Expanded(child: cupertinoWheelButton),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      dropdownWidget,
                      const SizedBox(height: 8),
                      cupertinoWheelButton,
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
