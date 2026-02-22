import 'package:flutter/material.dart';
import 'package:sdui_project/sdui/product_detail_card.dart';
import 'product_card.dart';

class WidgetFactory {
  static Widget buildWidget(
    Map<String, dynamic> section,
    BuildContext context,
  ) {
    final String type = section['type'];
    final Map<String, dynamic> data = section['data'] ?? {};

    switch (type) {
      case 'carousel':
        return _buildCarousel(section['items'] ?? []);

      case 'category_grid':
        return _buildCategoryGrid(data);

      case 'product_list':
        return _buildProductList(data, context);

      case 'product_details_page':
        return _buildProductDetail(section, context);

      default:
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Component not supported yet"),
        );
    }
  }

  // -------------------- Carousel --------------------
  static Widget _buildCarousel(List items) {
    final PageController pageController = PageController();
    final ValueNotifier<int> currentPage = ValueNotifier<int>(0);

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: pageController,
            itemCount: items.length,
            onPageChanged: (index) => currentPage.value = index,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(items[index]['image_url']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        ValueListenableBuilder<int>(
          valueListenable: currentPage,
          builder: (context, activeIndex, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                items.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: activeIndex == index ? 20 : 8,
                  decoration: BoxDecoration(
                    color: activeIndex == index ? Colors.amber : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // -------------------- Category Grid --------------------
  static Widget _buildCategoryGrid(Map<String, dynamic> data) {
    IconData getIcon(String iconName) {
      switch (iconName) {
        case 'shirt':
          return Icons.checkroom;
        case 'phone':
          return Icons.smartphone;
        case 'home':
          return Icons.home;
        default:
          return Icons.help_outline;
      }
    }

    final categories = data['categories'] as List;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            data['title'],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) => Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  getIcon(categories[index]['icon']),
                  color: Colors.black,
                ),
              ),
              Text(categories[index]['label']),
            ],
          ),
        ),
      ],
    );
  }

  // -------------------- Product List --------------------
  static Widget _buildProductList(
    Map<String, dynamic> data,
    BuildContext context,
  ) {
    final products = data['products'] as List;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            data['title'],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            itemCount: products.length,
            itemBuilder: (context, index) => SDUIProductCard(
              data: products[index],
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        SDUIProductDetailCard(id: products[index]['id']),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // -------------------- Product Detail Page --------------------
  static Widget _buildProductDetail(
    Map<String, dynamic> section,
    BuildContext context,
  ) {
    final List sections = section['sections'] ?? [];
    final bottomBar = section['bottom_bar'];

    // Keep a controller for all carousels
    final Map<int, PageController> pageControllers = {};
    final Map<int, ValueNotifier<int>> pageNotifiers = {};

    return Scaffold(
      appBar: AppBar(title: const Text("Product Details"), centerTitle: true),
      bottomNavigationBar: bottomBar != null
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: ElevatedButton(
                onPressed: () {
                  debugPrint(
                    "Action: ${bottomBar['primary_button']?['action']}",
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(bottomBar['primary_button']?['text'] ?? "Button"),
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(sections.length, (index) {
            final sectionItem = sections[index];
            final type = sectionItem['type'];
            final sectionData = sectionItem['data'];

            switch (type) {
              case 'carousel':
                final items = sectionItem['items'] as List? ?? [];
                pageControllers[index] = PageController();
                pageNotifiers[index] = ValueNotifier<int>(0);

                return Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: PageView.builder(
                        controller: pageControllers[index],
                        itemCount: items.length,
                        onPageChanged: (i) => pageNotifiers[index]?.value = i,
                        itemBuilder: (context, i) => Image.network(
                          items[i]['image_url'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ValueListenableBuilder<int>(
                      valueListenable: pageNotifiers[index]!,
                      builder: (context, activeIndex, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            items.length,
                            (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 8,
                              width: activeIndex == i ? 20 : 8,
                              decoration: BoxDecoration(
                                color: activeIndex == i
                                    ? Colors.amber
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                );

              case 'text_block':
                final style = sectionData?['style'] ?? {};
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Text(
                    sectionData?['title'] ?? '',
                    style: TextStyle(
                      fontSize: (style['fontSize']?.toDouble() ?? 16),
                      fontWeight: style['fontWeight'] == 'bold'
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: style['color'] == 'green'
                          ? Colors.green
                          : style['color'] == 'grey'
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                );

              case 'rating':
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text("${sectionData?['rating'] ?? 0}"),
                      const SizedBox(width: 8),
                      Text("(${sectionData?['reviews_count'] ?? 0} reviews)"),
                    ],
                  ),
                );

              case 'specs_list':
                final specs = sectionData as List? ?? [];
                return Column(
                  children: specs
                      .map(
                        (spec) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(spec['label'] ?? ''),
                              Text(
                                spec['value'] ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );

              default:
                return const SizedBox.shrink();
            }
          }),
        ),
      ),
    );
  }
}
