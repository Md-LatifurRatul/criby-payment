import 'package:criby_payment/presentation/utils/app_assets.dart';
import 'package:criby_payment/presentation/utils/app_theme_text_styles.dart';
import 'package:criby_payment/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashBoardScreen> {
  final String userName = "Siam Ahmed";
  final String userEmail = "criby123******@gmail.com";

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != 2) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSubscriptionCard(),
            const SizedBox(height: 200),

            CustomElevatedButton(
              buttonTextName: "Logout",

              onPressed: () {},

              buttonBGColor: Color(0xFFF56565),
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
                    userName,
                    style: AppThemeTextStyles.bodyHeaderBold.copyWith(
                      fontSize: 17,
                      height: 1,
                    ),
                  ),
                  Text(userEmail, style: AppThemeTextStyles.bodySectionMedium),
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
              'Subscription: Active (Pro Plan)',
              textAlign: TextAlign.center,
              style: AppThemeTextStyles.bodyHeaderBold.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              'Next Billing: 08 Oct 2026',
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
}
