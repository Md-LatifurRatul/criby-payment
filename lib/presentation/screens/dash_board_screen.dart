import 'package:criby_payment/data/controller/auth_controller.dart';
import 'package:criby_payment/data/models/network_response.dart';
import 'package:criby_payment/data/models/user_data.dart';
import 'package:criby_payment/data/models/user_info.dart';
import 'package:criby_payment/data/services/network_caller.dart';
import 'package:criby_payment/data/utils/api_urls.dart';
import 'package:criby_payment/presentation/screens/login_screen.dart';
import 'package:criby_payment/presentation/utils/app_assets.dart';
import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:criby_payment/presentation/widgets/custom_elevated_button.dart';
import 'package:criby_payment/presentation/widgets/snack_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashBoardScreen> {
  bool _isLogOutInProgress = false;

  int _selectedIndex = 0;

  UserData? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  void _onItemTapped(int index) {
    if (index != 2) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<void> _getUserInfo() async {
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: ApiUrls.getUserUrl,
    );
    if (response.isSucess && response.responseData != null) {
      final parsedData = UserInfo.fromJson(response.responseData);
      _userData = parsedData.data as UserData?;
      _isLoading = false;
      setState(() {});
    } else {
      _isLoading = false;
      setState(() {});
      if (mounted) {
        SnackMessage.showSnackBarMessage(
          context,
          "Failed to load user data",
          true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSubscriptionCard(),
                  const SizedBox(height: 200),

                  Visibility(
                    visible: _isLogOutInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: CustomElevatedButton(
                      buttonTextName: "Logout",

                      onPressed: () {
                        _logOutUser();
                      },

                      buttonBGColor: Color(0xFFF56565),
                    ),
                  ),
                ],
              ),
            ),

      bottomNavigationBar: _buildBottomNavBar(),

      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 90,
      titleSpacing: 20,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(AppAssets.userImage),
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _userData?.username ?? "",
                    style: AppThemeTextStyles.bodyHeaderBold.copyWith(
                      fontSize: 17,
                      height: 1,
                    ),
                  ),
                  Text(
                    _userData?.email ?? "",
                    style: AppThemeTextStyles.bodySectionMedium,
                  ),
                ],
              ),
            ],
          ),

          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                  size: 28,
                ),
                onPressed: () {},
              ),

              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(67, 163, 242, 1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard() {
    final subscription = _userData?.activeSubscription;
    return Card(
      elevation: 0,

      color: const Color.fromRGBO(250, 198, 0, 0.06),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.appCrownImage, height: 70, width: 67),
            const SizedBox(height: 15),
            Text(
              subscription == null
                  ? "No Active Subscription"
                  : 'Subscription: Active (${subscription['plan_name']})',
              textAlign: TextAlign.center,
              style: AppThemeTextStyles.bodyHeaderBold.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              subscription == null
                  ? 'Upgrade your plan to get premium access'
                  : 'Next Billing:  ${subscription['next_billing_date']}',
              textAlign: TextAlign.center,
              style: AppThemeTextStyles.bodySectionMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
      child: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, CupertinoIcons.home),
            _buildNavItem(1, Icons.inbox_outlined),
            const SizedBox(width: 40),
            _buildNavItem(3, CupertinoIcons.bell),
            _buildNavItem(4, Icons.person_outline),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    final bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Icon(
          icon,
          color: isSelected ? const Color(0xFF43A3F2) : Colors.grey.shade600,
          size: 26,
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return ClipRRect(
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF43A3F2),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,

        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Future<void> _logOutUser() async {
    _isLogOutInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: ApiUrls.logOutUserUrl,
    );

    _isLogOutInProgress = false;
    setState(() {});

    if (response.isSucess) {
      final data = response.responseData;
      final loginToken = data["data"]?["api_token"];
      if (loginToken != null) {
        AuthController.clearToken();
      }
      if (mounted) {
        SnackMessage.showSnackBarMessage(context, "Successfully logout");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } else {
      if (mounted) {
        SnackMessage.showSnackBarMessage(context, "Logout failed", true);
      }
    }
  }
}
