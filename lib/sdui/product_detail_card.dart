import 'package:flutter/material.dart';
import 'package:sdui_project/SDUI/widget_factory.dart';
import 'package:sdui_project/data/home_page_detail_product_json.dart';

class SDUIProductDetailCard extends StatelessWidget {
  final String id;

  const SDUIProductDetailCard({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final schema = HomePageDetailProductJson.productDetails;

    return WidgetFactory.buildWidget(schema, context);
  }
}
