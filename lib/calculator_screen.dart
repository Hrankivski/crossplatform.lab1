import 'package:flutter/material.dart';
import 'logic.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Контролери з дефолтними значеннями для Завдання 1
  late final Map<String, TextEditingController> _ctrl1 = {
    'hp': TextEditingController(text: '1.9'),
    'cp': TextEditingController(text: '21.1'),
    'sp': TextEditingController(text: '2.6'),
    'np': TextEditingController(text: '0.2'),
    'op': TextEditingController(text: '7.1'),
    'wp': TextEditingController(text: '53.0'),
    'ap': TextEditingController(text: '14.1'),
  };

  // Повні назви для Завдання 1
  final Map<String, String> _labels1 = {
    'cp': 'Вуглець (%)', 'hp': 'Водень (%)', 'sp': 'Сірка (%)',
    'np': 'Азот (%)', 'op': 'Кисень (%)', 'wp': 'Волога (%)', 'ap': 'Зола (%)',
  };

  // Контролери з дефолтними значеннями для Завдання 2
  late final Map<String, TextEditingController> _ctrl2 = {
    'cg': TextEditingController(text: '85.5'),
    'hg': TextEditingController(text: '11.2'),
    'og': TextEditingController(text: '0.8'),
    'sg': TextEditingController(text: '2.5'),
    'qg': TextEditingController(text: '40.40'),
    'wp': TextEditingController(text: '2.0'),
    'ad': TextEditingController(text: '0.15'),
    'v': TextEditingController(text: '333.3'),
  };

  // Повні назви для Завдання 2
  final Map<String, String> _labels2 = {
    'cg': 'Вуглець (%)', 'hg': 'Водень (%)', 'og': 'Кисень (%)',
    'sg': 'Сірка (%)', 'qg': 'Теплота (МДж/кг)', 'wp': 'Вологість (%)',
    'ad': 'Зольність суха (%)', 'v': 'Ванадій (мг/кг)',
  };

  String _res1 = "";
  String _res2 = "";

  void _calculate1() {
    final res = FuelLogic.calculateTask1(
      cp: double.parse(_ctrl1['cp']!.text),
      hp: double.parse(_ctrl1['hp']!.text),
      sp: double.parse(_ctrl1['sp']!.text),
      np: double.parse(_ctrl1['np']!.text),
      op: double.parse(_ctrl1['op']!.text),
      wp: double.parse(_ctrl1['wp']!.text),
      ap: double.parse(_ctrl1['ap']!.text),
    );
    setState(() =>
    _res1 =
    "QpH: ${res['qph']!.toStringAsFixed(4)} МДж/кг\n"
        "Qch: ${res['qch']!.toStringAsFixed(2)} МДж/кг\n"
        "Qgh: ${res['qgh']!.toStringAsFixed(2)} МДж/кг");
  }

  void _calculate2() {
    final res = FuelLogic.calculateTask2(
      cg: double.parse(_ctrl2['cg']!.text),
      hg: double.parse(_ctrl2['hg']!.text),
      og: double.parse(_ctrl2['og']!.text),
      sg: double.parse(_ctrl2['sg']!.text),
      qg: double.parse(_ctrl2['qg']!.text),
      wp: double.parse(_ctrl2['wp']!.text),
      ad: double.parse(_ctrl2['ad']!.text),
      v: double.parse(_ctrl2['v']!.text),
    );
    setState(() =>
    _res2 =
    "Склад робочої маси: Cp=${res['cp']!.toStringAsFixed(2)}%, Hp=${res['hp']!
        .toStringAsFixed(2)}%, Sp=${res['sp']!.toStringAsFixed(
        2)}%, Op=${res['op']!.toStringAsFixed(2)}%, Ap=${res['ap']!
        .toStringAsFixed(2)}%, Vp=${res['vp']!.toStringAsFixed(2)} мг/кг\n"
        "QpH = ${res['qph']!.toStringAsFixed(2)} МДж/кг");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Fuel Calculator Pro"),
          centerTitle: true,
          bottom: const TabBar(tabs: [
            Tab(text: "Завдання 1"),
            Tab(text: "Завдання 2")
          ]),
        ),
        body: TabBarView(children: [
          _buildTaskPage(
              _ctrl1, _labels1, _calculate1, _res1, "Тверде та рідке паливо"),
          _buildTaskPage(_ctrl2, _labels2, _calculate2, _res2, "Склад мазуту"),
        ]),
      ),
    );
  }

  Widget _buildTaskPage(Map<String, TextEditingController> ctrls,
      Map<String, String> labels, VoidCallback onCalc, String result,
      String title) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(title, style: Theme
            .of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),

        // Сітка з 2 колонками
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 коробки в ряд
            crossAxisSpacing: 10, // Відступ між колонками
            mainAxisSpacing: 10, // Відступ між рядками
            childAspectRatio: 2.2, // Співвідношення ширини до висоти
          ),
          itemCount: ctrls.length,
          itemBuilder: (context, index) {
            String key = ctrls.keys.elementAt(index);
            return TextField(
              controller: ctrls[key],
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true),
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                labelText: labels[key],
                labelStyle: const TextStyle(fontSize: 12),
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
              ),
            );
          },
        ),

        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: onCalc,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .primaryContainer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text("Виконати розрахунок",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),

        if (result.isNotEmpty) ...[
          const SizedBox(height: 20),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(result, style: const TextStyle(
                  fontSize: 15, height: 1.4, fontFamily: 'monospace')),
            ),
          ),
        ],
      ]),
    );
  }
}