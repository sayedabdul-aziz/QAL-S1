// 1) BE => list of products (List<Map>)
// Example:
// [
//   {
//     "id": 1,
//     "name": "Apple",
//     "price": 10,
//     "image": "https://example.com/apple.jpg"
//   },
//   {
//     "id": 2,
//     "name": "Banana",
//     "price": 5,
//     "image": "https://example.com/banana.jpg"
//   }
// ]

// data[index]["name"] => Wrong

// 2) FE => list of products (List<Product>)
// Example:
// [
//   Product(
//     id: 1,
//     name: "Apple",
//     price: 10,
//     image: "https://example.com/apple.jpg"
//   ),
//   Product(
//     id: 2,
//     name: "Banana",
//     price: 5,
//     image: "https://example.com/banana.jpg"
//   )
// ]

// data[index].name => Right

import 'package:flutter/material.dart';
import 'package:greenmart/features/shop/data/product_model.dart';

List<ProductModel> offersList = [
  ProductModel(
    id: 1,
    categoryId: 1,
    name: 'Apple',
    price: 10,
    image: 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
  ProductModel(
    id: 2,
    categoryId: 1,
    name: 'Banana',
    price: 5,
    image:
        'https://www.sharbatlyfruit.com/fruits/media-gallery/Banana%20baby.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
  ProductModel(
    id: 3,
    categoryId: 1,
    name: 'Orange',
    price: 15,
    image: 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
  ProductModel(
    id: 4,
    categoryId: 1,
    name: 'Mango',
    price: 20,
    image:
        'https://img.magnific.com/free-photo/mango-still-life_23-2151542114.jpg?w=360',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
  ProductModel(
    id: 5,
    categoryId: 1,
    name: 'Pineapple',
    price: 25,
    image: 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
];

List<ProductModel> bestSellingList = [
  ProductModel(
    id: 4,
    categoryId: 1,
    name: 'Mango',
    price: 20,
    image:
        'https://img.magnific.com/free-photo/mango-still-life_23-2151542114.jpg?w=360',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),

  ProductModel(
    id: 3,
    categoryId: 1,
    name: 'Orange',
    price: 15,
    image: 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
  ProductModel(
    id: 2,
    categoryId: 1,
    name: 'Banana',
    price: 5,
    image:
        'https://www.sharbatlyfruit.com/fruits/media-gallery/Banana%20baby.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
  ProductModel(
    id: 1,
    categoryId: 1,
    name: 'Apple',
    price: 10,
    image: 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),

  ProductModel(
    id: 5,
    categoryId: 1,
    name: 'Pineapple',
    price: 25,
    image: 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
];

List<ProductModel> allProducts = [
  ProductModel(
    id: 1,
    name: 'Apple',
    categoryId: 1,
    price: 10,
    image: 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
  ProductModel(
    id: 2,
    categoryId: 1,
    name: 'Banana',
    price: 5,
    image:
        'https://www.sharbatlyfruit.com/fruits/media-gallery/Banana%20baby.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
  ProductModel(
    id: 3,
    categoryId: 1,
    name: 'Orange',
    price: 15,
    image: 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
  ProductModel(
    id: 4,
    categoryId: 1,
    name: 'Mango',
    price: 20,
    image:
        'https://img.magnific.com/free-photo/mango-still-life_23-2151542114.jpg?w=360',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
  ProductModel(
    id: 5,
    categoryId: 1,
    name: 'Pineapple',
    price: 25,
    image: 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
  ProductModel(
    id: 6,
    categoryId: 1,
    name: 'Watermelon',
    price: 8,
    image: 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
  ProductModel(
    id: 7,
    categoryId: 1,
    name: 'Orange',
    price: 15,
    image: 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple.jpg',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
  ProductModel(
    id: 8,
    categoryId: 1,
    name: 'Mango',
    price: 20,
    image:
        'https://img.magnific.com/free-photo/mango-still-life_23-2151542114.jpg?w=360',
    unit: "1 kg",
    heroTag: UniqueKey().toString(),
  ),
];
