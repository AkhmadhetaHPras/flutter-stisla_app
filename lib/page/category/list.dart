import 'package:flutter/material.dart';

import '../../models/category.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(categories[index].name),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
