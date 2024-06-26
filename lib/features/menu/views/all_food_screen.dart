import 'package:cached_network_image/cached_network_image.dart';
import 'package:ddnangcao_project/features/menu/views/add_food_screen.dart';
import 'package:ddnangcao_project/features/menu/views/edit_food_screen.dart';
import 'package:ddnangcao_project/providers/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';
import '../../../widgets/loading_widget.dart';

class AllFoodScreen extends StatefulWidget {
  const AllFoodScreen({super.key});

  @override
  State<AllFoodScreen> createState() => _AllFoodScreenState();
}

class _AllFoodScreenState extends State<AllFoodScreen> {
  String storeId = "";

  getStoreId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      storeId = sharedPreferences.getString("resId") ?? "";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getStoreId().then((_) {
      Provider.of<MenuProvider>(context, listen: false)
          .getAllFoodByStoreId(storeId);
    });
    // getStoreId();
    // Provider.of<MenuProvider>(context, listen: false)
    //     .getAllFoodByStoreId(storeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("123 ..$storeId");
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Food"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddFoodScreen(
                        storeId: storeId,
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.add)),
          )
        ],
      ),
      body: storeId != ""
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<MenuProvider>(builder: (context, value, child) {
                    if (value.listFood.isEmpty) {
                      return const Center(
                        child: Center(
                          child: Text("No Have Item"),
                        ),
                      );
                    } else {
                      if (value.isLoading) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: GetSize.symmetricPadding * 2,
                              vertical: 10),
                          color: Colors.black12.withOpacity(0.05),
                          height: GetSize.getHeight(context) * 0.85,
                          width: GetSize.getWidth(context),
                          child: ListView.separated(
                            itemCount: value.listFood.length,
                            itemBuilder: (context, index) =>
                                const NewsCardSkelton(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                          ),
                        );
                      } else {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: GetSize.symmetricPadding * 2,
                              vertical: 10),
                          color: Colors.black12.withOpacity(0.05),
                          height: GetSize.getHeight(context) * .9,
                          width: GetSize.getWidth(context),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 2 / 3),
                            itemCount: value.listFood.length,
                            itemBuilder: (context, index) {
                              return Food(
                                image: value.listFood[index].image,
                                cateId: value.listFood[index].category.id,
                                left: value.listFood[index].left,
                                foodId: value.listFood[index].id,
                                sold: value.listFood[index].sold,
                                name: value.listFood[index].name,
                                price: value.listFood[index].price,
                                rating: value.listFood[index].rating,
                              );
                            },
                          ),
                        );
                      }
                    }
                  })
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class Food extends StatelessWidget {
  final String name;
  final String? rating;
  final int? price;
  final int? left;
  final int? sold;
  final String? image;
  final String foodId;
  final String cateId;

  const Food(
      {super.key,
      required this.name,
      required this.cateId,
      this.rating,
      required this.price,
      this.image,
      this.left,
      required this.foodId,
      this.sold});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            width: 155,
            height: 120,
            child: CachedNetworkImage(
              imageUrl: image ?? "",
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      onSelected: (value) {
                        print(value);
                        if (value == "1") {
                          print(price);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditFoodScreen(
                                cateId: cateId,
                                foodName: name,
                                foodId: foodId,
                                price: price.toString(),
                                left: left.toString(),
                                image: image ?? "",
                              ),
                            ),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem(
                            value: "1",
                            child: Text("Edit"),
                          ),
                          const PopupMenuItem(
                            value: "2",
                            child: Text("Delete"),
                          ),
                        ];
                      },
                    )
                  ],
                ),
                Text(
                  "Price: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(price)}",
                  maxLines: 1,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorLib.blackColor),
                ),
                Row(
                  children: [
                    Text(
                      "Sold: $sold",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Left: $left",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
