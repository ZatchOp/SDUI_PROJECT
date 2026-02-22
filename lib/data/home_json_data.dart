class HomeJsonData {
  static const Map<String, dynamic> homePage = {
    "page_title": "SDUI SHOP",
    "sections": [
      // Heder carousel
      {
        "type": "carousel",
        "items": [
          {
            "image_url": "https://picsum.photos/800/400?random=1",
            "action": "action-1",
          },
          {
            "image_url": "https://picsum.photos/800/400?random=2",
            "action": "action-2",
          },
          {
            "image_url": "https://picsum.photos/800/400?random=3",
            "action": "action-3",
          },
          {
            "image_url": "https://picsum.photos/800/400?random=4",
            "action": "action-4",
          },
        ],
      },
      {
        "type": "category_grid",
        "data": {
          //item type category
          "title": "Shop by Category",
          "categories": [
            {"id": 1, "label": "Fashion", "icon": "shirt"},
            {"id": 2, "label": "Electronics", "icon": "phone"},
          ],
        },
      },
      {
        // flash sale products list
        "type": "product_list",
        "data": {
          "title": "Flash Sale",
          "products": [
            {
              "id": "p1",
              "name": "Wireless Headphones",
              "price": 99.99,
              "image": "https://picsum.photos/200/200?random=10",
              "badge": "20% OFF",
              "action": "Navigation",
            },
            {
              "id": "p2",
              "name": "Smart Watch S9",
              "price": 249.50,
              "image": "https://picsum.photos/200/200?random=11",
              "badge": "LIMITED",
            },
            {
              "id": "p3",
              "name": "Running Shoes",
              "price": 120.00,
              "image": "https://picsum.photos/200/200?random=12",
              "badge": "HOT",
            },
            {
              "id": "p4",
              "name": "Bluetooth Speaker",
              "price": 45.99,
              "image": "https://picsum.photos/200/200?random=13",
              "badge": "SAVE \$10",
            },
            {
              "id": "p5",
              "name": "Mechanical Keyboard",
              "price": 89.00,
              "image": "https://picsum.photos/200/200?random=14",
              "badge": "NEW",
            },
          ],
        },
      },
    ],
  };
}
