import 'package:flutter/material.dart';
import 'package:mobileapp/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      // ignore: prefer_const_constructors
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        // ignore: prefer_const_constructors
        curve: Interval(0.0, 0.65, curve: Curves.easeIn),
      ),
    );

    // Scale animation
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        // ignore: prefer_const_constructors
        curve: Interval(0.0, 0.65, curve: Curves.easeOutBack),
      ),
    );

    // Start animation
    _controller.forward();

    // Navigate to onboarding after 3 seconds
    // ignore: prefer_const_constructors
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                // ignore: prefer_const_constructors
                OnboardingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            // ignore: prefer_const_constructors
            transitionDuration: Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      backgroundColor: Color(0xFF1976D2),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1976D2),
              Color(0xFF1565C0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: prefer_const_constructors
                Spacer(flex: 2),
                // Animated logo container
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            // ignore: prefer_const_constructors
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          // ignore: prefer_const_constructors
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            return Transform.rotate(
                              angle: value * 0.5,
                              // ignore: prefer_const_constructors
                              child: Icon(
                                Icons.handyman,
                                size: 70,
                                // ignore: prefer_const_constructors
                                color: Color(0xFF1976D2),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(height: 30),
                // Animated app name
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      // ignore: prefer_const_constructors
                      begin: Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _controller,
                      // ignore: prefer_const_constructors
                      curve: Interval(0.3, 1.0, curve: Curves.easeOut),
                    )),
                    // ignore: prefer_const_constructors
                    child: Text(
                      "MucoConnect",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(height: 12),
                // Animated tagline
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      // ignore: prefer_const_constructors
                      begin: Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _controller,
                      // ignore: prefer_const_constructors
                      curve: Interval(0.5, 1.0, curve: Curves.easeOut),
                    )),
                    child: Text(
                      "Connecting Skills to Opportunities",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                Spacer(flex: 2),
              ],
            );
          },
        ),
      ),
    );
  }
}
