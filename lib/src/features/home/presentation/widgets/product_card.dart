import 'package:boiler_plate/src/features/home/data/model/product_data_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductDataModel data;
  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AspectRatio(
          //   aspectRatio: 18.0 / 13.0,
          //   child:
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                data.image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data.title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
