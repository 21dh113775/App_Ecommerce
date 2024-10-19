import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  _buildPage(
                    title: 'Welcome to Our App',
                    description:
                        'Discover all the amazing features and start your journey with us.',
                  ),
                  _buildPage(
                    title: 'Shop Easily',
                    description:
                        'Browse and find the best products at the best prices.',
                  ),
                  _buildPage(
                    title: 'Enjoy Your Shopping',
                    description: 'A seamless shopping experience just for you.',
                  ),
                ],
              ),
            ),
            _buildPageIndicator(),
            SizedBox(height: 20),
            _currentIndex == 2
                ? ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed(
                          '/login'); // Navigate to login page after onboarding
                    },
                    child: Text('Get Started'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Function to build a page with just text content
  Widget _buildPage({required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Build page indicators (dots)
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: 10,
          width: _currentIndex == index ? 20 : 10,
          decoration: BoxDecoration(
            color: _currentIndex == index ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }
}
