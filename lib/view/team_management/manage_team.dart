import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/components/home_post_card.dart';
import 'package:post_krakren_dashboard/components/label_text.dart';
import 'package:post_krakren_dashboard/components/noti_icon.dart';
import 'package:post_krakren_dashboard/components/posting_details.dart';
import 'package:post_krakren_dashboard/components/posting_details_card_two.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';
import 'package:post_krakren_dashboard/constants/app_images.dart';
import 'package:post_krakren_dashboard/view/notification_screen/notification_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ManageTeam extends StatefulWidget {
  const ManageTeam({super.key});

  @override
  State<ManageTeam> createState() => _ManageTeamState();
}

class _ManageTeamState extends State<ManageTeam> {
  final PageController controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Row(
                          children: [
                          Image.asset(AppImages.profile, height: 67, width: 67,),
                          SizedBox(width: 19,),
                                LabelText(
                              text: "Hi, Ethan",
                              fontSize: 36.5,
                              weight: FontWeight.w600,
                            ),
                          ],
                        ),
                            LabelText(
                              text: "December 25, 2024",
                              fontSize:16,
                              weight: FontWeight.w600,
                              textColor: AppColors.grey,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(NotificationScreen());
                          },
                          child: const NotificationIcon(),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        LabelText(
                          text: "Fresh Press Mesa",
                          fontSize: 24,
                          weight: FontWeight.w600,
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.keyboard_arrow_down, size: 36.5,),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        const PostingDetails(),
                        SizedBox(width: 21,),
                        PostingDetailsCardTwo(),
                      ],
                    ),
                    // SizedBox(height: screenHeight * 0.02),
                    // PageIndicator(controller: controller),
                    SizedBox(height: screenHeight * 0.02),
                    Expanded(child: CustomTabs()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmoothPageIndicator(
        controller: controller,
        count: 2,
        effect: WormEffect(
          dotHeight: 8,
          dotWidth: 8,
          dotColor: Colors.grey,
          activeDotColor: AppColors.blue,
        ),
        onDotClicked: (index) {
          controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}

class CustomTabs extends StatefulWidget {
  const CustomTabs({super.key});

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.blue.withOpacity(0.2)),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                indicator: BoxDecoration(
                  gradient:  AppColors.appGradientColors,
                  borderRadius: BorderRadius.circular(20),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicatorPadding: EdgeInsets.zero,
                padding: EdgeInsets.all(3),
                labelPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: LabelText(text: "Published", textColor: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: LabelText(text: "Pending", textColor: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: LabelText(text: "Rejected", textColor: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      HomePostCard(),
                      HomePostCard(),
                      
                      HomePostCard(),
                      
                      HomePostCard(),
                    ],
                  ),
                  const Center(child: Text("No Pending Posts")),
                  const Center(child: Text("No Rejected Posts")),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
