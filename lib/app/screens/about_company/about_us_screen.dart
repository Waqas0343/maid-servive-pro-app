import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_assets/app_styles/my_colors.dart';
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final s=MediaQuery.of(context).size;
    return  Scaffold(
        appBar: AppBar(
          title: Text("About US"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: s.width,
                    child: Image.asset(
                      height: 150,
                      "assets/pic2.png",
                      fit: BoxFit.cover,),
                  ),
                  SizedBox(height: s.height*0.02,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Text(
                      "Effortless, Stress-Free Cleaning at the Click of a Button!",
                      style: Get.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: MyColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: s.height*0.02,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:   ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FadeInImage(
                              width: s.width * 0.25,
                              height: s.height * 0.39,
                              fit: BoxFit.cover,
                              image:NetworkImage("https://gomaidz.com/static/media/about-img.ae8d6f02.png"),
                              placeholder: const AssetImage("assets/iphone.png"),
                              imageErrorBuilder:(context, error, stackTrace) {
                                return Image.asset('assets/iphone.png',
                                    fit: BoxFit.fitWidth
                                );
                              },

                            ),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 0,left: 0),
                            child: Text(
                              'Welcome to GoMaids, where pristine cleanliness meets seamless convenience. Our high quality, and easy to use app is designed to simplify your life, ensuring a spotless home with just a few taps. At GoMaids, we pride ourselves on delivering trusted and professional cleaning services tailored to your unique needs.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Our Mission and Vision",
                      style: Get.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: MyColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: s.height*0.02,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                ' Our dedicated team of skilled maids is committed to transforming your living space into a sanctuary of cleanliness. With a user-friendly app interface and a focus on reliability, we strive to make your cleaning experience effortless and stress-free. Experience the joy of coming home to a space – where cleanliness is our commitment to you.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade700,
                                ),
                                textAlign: TextAlign.justify,
                              ),

                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child:   ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: FadeInImage(
                              width: s.width * 0.25,
                              height: s.height * 0.35,
                              fit: BoxFit.cover,
                              image:NetworkImage("https://gomaidz.com/static/media/bd-shape-1.06966f16.jpg"),
                              placeholder: const AssetImage("assets/iphone.png"),
                              imageErrorBuilder:(context, error, stackTrace) {
                                return Image.asset('assets/iphone.png',
                                    fit: BoxFit.fitWidth
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: s.height*0.02,),
                  const Padding(
                    padding: EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle,size: 8,),
                            Text(
                              "Cost Effective",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.circle,size: 8,),
                            Text(
                              "Insured and Bonded",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: s.height*0.02,),
                  const Padding(
                    padding: EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle,size: 8,),
                            Text(
                              "100% Satisfaction",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.circle,size: 8,),
                            Text(
                              "Quality Services",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: s.height*0.02,),
                  const Text(
                    "How 'GoMaidz' Works",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: s.height*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Image.asset('assets/about1.png',

                              fit: BoxFit.cover,
                            ),
                            Image.asset('assets/about2.png',

                              fit: BoxFit.cover,
                            ),
                            Image.asset('assets/about3.png',

                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        SizedBox(height: s.height*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Container(
                              width: s.width*0.2,
                              height: s.height*0.05,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: const Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: s.width*0.2,
                              height: s.height*0.05,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: const Center(
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: s.width*0.2,
                              height: s.height*0.05,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: const Center(
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: s.height*0.02,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Book Online"),
                            Text("We do"),
                            Text("You Relax"),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
