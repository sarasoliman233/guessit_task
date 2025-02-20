import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../api_service.dart';
import '../model/product_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _futureProducts;
  late Future<List<String>> _futureCategories;
  int _selectedCategoryIndex = 0;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _futureCategories = ApiService.fetchCategories();
    _futureProducts = _loadProducts();

  }
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<List<Product>> _loadProducts() async {
    final categories = await _futureCategories;
    return ApiService.fetchProducts(categories[_selectedCategoryIndex]);
  }

  void _changeCategory(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _futureProducts = _loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset("assets/images/logo.png", height: 40),
        centerTitle: true,
        leading: IconButton(
          icon: ImageIcon(AssetImage("assets/images/Notifications.png")),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: ImageIcon(AssetImage("assets/images/Shopping cart.png")),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صندوق البحث
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ابحث',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'alexandria',
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF878787),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: ImageIcon(AssetImage("assets/images/Search.png")),
                    ),
                  ),
                ),
              ),
            ),

            // بانر الإعلان
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/images/2 ad.png",
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 192,
                ),
              ),
            ),
            SizedBox(height: 20),

            // عنوان القسم
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "عرض الكل",
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'alexandria',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF878787),
                      ),
                    ),
                  ),
                  Text(
                    "أفضل العروض",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'alexandria',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333333),
                    ),
                  ),
                ],
              ),
            ),

            // الفئات والمنتجات
            FutureBuilder<List<String>>(
              future: _futureCategories,
              builder: (context, categoriesSnapshot) {
                if (categoriesSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (categoriesSnapshot.hasError) {
                  return Center(child: Text('خطأ في تحميل الفئات'));
                } else if (!categoriesSnapshot.hasData || categoriesSnapshot.data!.isEmpty) {
                  return Center(child: Text('لا توجد فئات متاحة'));
                } else {
                  return Column(
                    children: [
                      // شريط الفئات
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoriesSnapshot.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _changeCategory(index),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Chip(
                                  label: Text(
                                    categoriesSnapshot.data![index],
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'alexandria',
                                      fontWeight: FontWeight.w400,
                                      color: _selectedCategoryIndex == index
                                          ? Color(0xFFF2F2F2)
                                          : Color(0xFF333333),
                                    ),
                                  ),
                                  backgroundColor: _selectedCategoryIndex == index
                                      ? Color(0XFF333333)
                                      : Colors.grey.shade50,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // المنتجات
                      FutureBuilder<List<Product>>(
                        future: _futureProducts,
                        builder: (context, productsSnapshot) {
                          if (productsSnapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (productsSnapshot.hasError) {
                            return Center(child: Text('خطأ في تحميل المنتجات'));
                          } else if (!productsSnapshot.hasData || productsSnapshot.data!.isEmpty) {
                            return Center(child: Text('لا توجد منتجات'));
                          } else {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(16),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: productsSnapshot.data!.length,
                              itemBuilder: (context, index) {
                                final product = productsSnapshot.data![index];
                                return ProductCard(product: product);
                              },
                            );
                          }
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFF25D27),
        unselectedItemColor: Color(0xFF878787),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon:
          Image.asset('assets/images/set.png',width: 24,height: 24,),
              activeIcon:Image.asset('assets/images/set.png',width: 24,height: 24,),label: '' ),
          BottomNavigationBarItem(icon:
          Image.asset('assets/images/Vector.png',width: 24,height: 24,),
              activeIcon:Image.asset('assets/images/Vector.png',width: 24,height: 24,),label: '' ),
          BottomNavigationBarItem(icon:
          Image.asset('assets/images/home.png',width: 20,height: 20,),
              activeIcon:Image.asset('assets/images/home.png',width: 24,height: 24,),label: '' ),


          BottomNavigationBarItem(icon:
          Image.asset('assets/images/home2.png',width: 24,height: 24,),
              activeIcon:Image.asset('assets/images/home2.png',width: 24,height: 24,),label: '' ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ImageIcon(AssetImage("assets/images/Vector.png")),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "%خصم 15",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'alexandria',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                product.image,
                width: double.infinity,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: ImageIcon(AssetImage("assets/images/cart.png")),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF333333),
                          fontFamily: 'alexandria',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 3),
                      Text(
                        '${product.price.toStringAsFixed(2)} جنيه',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF333333),
                          fontFamily: 'alexandria',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
