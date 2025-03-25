import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/components/back_button.dart';
import 'package:post_krakren_dashboard/components/label_text.dart';
import 'package:post_krakren_dashboard/components/noti_tile.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';
import 'package:post_krakren_dashboard/constants/app_images.dart';
import 'package:post_krakren_dashboard/controllers/notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              SizedBox(height: 41,),
              Row(
                children: [
                  CustomBackButton(),
                  SizedBox(width: 20),
                  LabelText(
                    text: "Notification",
                    fontSize:31.46,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Expanded(child: CustomTabs()),
          SizedBox(height: 62,),
      const Text(
              "Notification Settings",
              style: TextStyle(
                fontSize: 23.24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildNotificationTile(
              title: "Submissions",
              value: controller.isSubmissionsEnabled,
              onChanged: (val) => controller.updateSubmissions(val),
            ),
            _buildNotificationTile(
              title: "Approvals",
              value: controller.isApprovalsEnabled,
              onChanged: (val) => controller.updateApprovals(val),
            ),
            _buildNotificationTile(
              title: "Feedback Needed",
              value: controller.isFeedbackNeededEnabled,
              onChanged: (val) => controller.updateFeedback(val),
            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationTile({
    required String title,
    required RxBool value,
    required Function(bool) onChanged,
  }) {
    return Obx(() => ListTile(
      title: LabelText(text:  title, fontSize:  20.34, weight: FontWeight.w500,),
      trailing: Switch(
        activeColor: AppColors.blue,
        value: value.value,
        onChanged: onChanged,
      ),
    ));
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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'New Post Submitted',
        'message': 'Cindy has submitted a new post',
        'time': '30m'
      },
      {
        'title': 'New Feedback Needed',
        'message': 'Your team member needs your feedback',
        'time': '4h'
      },
      {
        'title': 'Post Approved',
        'message': 'Your post has been approved and is live',
        'time': '2d'
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.03),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.blue.withOpacity(0.2)),
              ),
              child: TabBar(
                controller: _tabController,
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
                      child: LabelText(text:  "All", textColor: Colors.black, ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: LabelText(text:  "Read", textColor: Colors.black, ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: notifications.isEmpty
                          ? const Center(child: Text("No notifications"))
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                final notification = notifications[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: NotificationTile(
                                    title: notification['title'] ?? '',
                                    message: notification['message'] ?? '',
                                    time: notification['time'] ?? '',
                                  ),
                                );
                              },
                            ),
                      ),
                 
                    ],
                  ),
                  const Center(child: Text("No Notifications")),
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