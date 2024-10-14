import 'package:boiler_plate/src/features/home/data/model/product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:utils_package/utils/utils.dart';

class ScrollebleWidget extends StatelessWidget {
  final ProductDataModel data;
  const ScrollebleWidget({super.key, required this.data});
  // ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 1.0,
      minChildSize: 0.1,
      // controller: ,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(14.0),
          controller: scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "₹ ${data.price.toString()}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const Height(height: 10),
              Text(
                data.title!,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Height(height: 10),
              Text(
                data.description!,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              )
            ],
          ),
        );
      },
    );
  }
}
