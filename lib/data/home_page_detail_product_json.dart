class HomePageDetailProductJson {
  static Map<String, dynamic> productDetails = {
    "product_id": "p1",
    "type": "product_details_page",
    "sections": [
      {
        "type": "carousel",
        "items": [
          {"image_url": "https://picsum.photos/800/400?random=5"},
          {"image_url": "https://picsum.photos/800/400?random=6"},
          {"image_url": "https://picsum.photos/800/400?random=7"},
          {"image_url": "https://picsum.photos/800/400?random=8"},
        ],
      },
      {
        "type": "text_block",
        "data": {
          "title": "AudioTech",
          "subtitle": "Brand",
          "style": {"fontSize": 14, "color": "grey"},
        },
      },
      {
        "type": "text_block",
        "data": {
          "title": "Wireless Headphones Pro",
          "style": {"fontSize": 20, "fontWeight": "bold"},
        },
      },
      {
        "type": "text_block",
        "data": {
          "title": "₹999.99",
          "style": {"fontSize": 22, "fontWeight": "bold", "color": "green"},
        },
      },
      {
        "type": "rating",
        "data": {"rating": 4.5, "reviews_count": 128},
      },
      {
        "type": "text_block",
        "data": {
          "title":
              "Experience crystal clear sound with active noise cancellation and 40-hour battery life.",
          "style": {"fontSize": 16},
        },
      },
      {
        "type": "specs_list",
        "data": [
          {"label": "Bluetooth", "value": "5.2"},
          {"label": "Battery", "value": "40 Hours"},
          {"label": "Weight", "value": "250g"},
        ],
      },
      {
        "type": "text_block",
        "data": {
          "title": "In Stock",
          "style": {"fontWeight": "bold", "color": "green"},
        },
      },
    ],
    "bottom_bar": {
      "primary_button": {
        "text": "Add to Cart",
        "action": "add_to_cart",
        "id": "p1",
      },
    },
  };
}
