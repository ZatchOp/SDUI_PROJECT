import 'package:flutter/material.dart';
import 'package:sdui_project/SDUI/widget_factory.dart';
import 'package:sdui_project/data/home_json_data.dart';

void main() {
  runApp(const ShopMaxApp());
}

class ShopMaxApp extends StatelessWidget {
  const ShopMaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDUI E-Commerce',

      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,

        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      debugShowCheckedModeBanner: false,
      home: const SDUIScreen(),
    );
  }
}

class SDUIScreen extends StatelessWidget {
  const SDUIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> schema = HomeJsonData.homePage;

    return Scaffold(
      appBar: AppBar(
        title: Text(schema['page_title'] ?? "Shop"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: (schema['sections'] as List).map((section) {
            return WidgetFactory.buildWidget(section, context);
          }).toList(),
        ),
      ),
    );
  }
}
