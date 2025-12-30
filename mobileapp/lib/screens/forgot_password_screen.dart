import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int _step = 0;
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _nextStep() async {
    if (_step == 0 && _emailController.text.isNotEmpty) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _isLoading = false;
        _step = 1;
      });
    } else if (_step == 1 && _otpController.text.isNotEmpty) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _isLoading = false;
        _step = 2;
      });
    } else if (_step == 2) {
      if (_newPasswordController.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Password must be at least 6 characters'),
          backgroundColor: Color(0xFFFF4444),
        ));
        return;
      }
      if (_newPasswordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Color(0xFFFF4444),
        ));
        return;
      }
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 1));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password changed successfully!'),
        backgroundColor: Color(0xFF4CAF50),
      ));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D2D2D)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _step == 0
              ? 'Forgot Password'
              : _step == 1
                  ? 'Verify OTP'
                  : 'Reset Password',
          style: const TextStyle(
            color: Color(0xFF2D2D2D),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Step Indicator
                Row(
                  children: [
                    _buildStepIndicator(0, 'Email'),
                    _buildStepLine(0),
                    _buildStepIndicator(1, 'OTP'),
                    _buildStepLine(1),
                    _buildStepIndicator(2, 'Reset'),
                  ],
                ),

                const SizedBox(height: 48),

                // Content based on step
                if (_step == 0) ..._buildEmailStep(),
                if (_step == 1) ..._buildOTPStep(),
                if (_step == 2) ..._buildResetPasswordStep(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label) {
    bool isActive = _step >= step;
    bool isCurrent = _step == step;

    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFFFF4444) : const Color(0xFFE0E0E0),
          ),
          child: Center(
            child: isActive && step < _step
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : Text(
                    '${step + 1}',
                    style: TextStyle(
                      color: isActive ? Colors.white : const Color(0xFF999999),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
            color:
                isCurrent ? const Color(0xFF2D2D2D) : const Color(0xFF999999),
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(int step) {
    bool isActive = _step > step;
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 30, left: 4, right: 4),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFF4444) : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }

  List<Widget> _buildEmailStep() {
    return [
      const Text(
        'Enter Your Email',
        style: TextStyle(
          color: Color(0xFF2D2D2D),
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'We will send you an OTP to reset your password',
        style: TextStyle(
          color: Color(0xFF666666),
          fontSize: 14,
          letterSpacing: 0.2,
        ),
      ),
      const SizedBox(height: 32),
      const Text(
        'Email',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Color(0xFF2D2D2D),
          letterSpacing: 0.2,
        ),
      ),
      const SizedBox(height: 8),
      _buildInputField(
        controller: _emailController,
        hint: 'Enter your email',
        icon: Icons.email_outlined,
      ),
      const SizedBox(height: 32),
      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _isLoading ? null : _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF4444),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : const Text(
                  'Send OTP',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
        ),
      ),
    ];
  }

  List<Widget> _buildOTPStep() {
    return [
      const Text(
        'Enter OTP Code',
        style: TextStyle(
          color: Color(0xFF2D2D2D),
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'Please enter the 6-digit code sent to your email',
        style: TextStyle(
          color: Color(0xFF666666),
          fontSize: 14,
          letterSpacing: 0.2,
        ),
      ),
      const SizedBox(height: 32),
      const Text(
        'OTP Code',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Color(0xFF2D2D2D),
          letterSpacing: 0.2,
        ),
      ),
      const SizedBox(height: 8),
      _buildInputField(
        controller: _otpController,
        hint: 'Enter 6-digit OTP',
        icon: Icons.lock_clock_outlined,
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 16),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            // Resend OTP logic
          },
          child: const Text(
            'Resend OTP',
            style: TextStyle(
              color: Color(0xFFFF4444),
              fontWeight: FontWeight.w600,
              fontSize: 13,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _isLoading ? null : _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF4444),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : const Text(
                  'Verify OTP',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
        ),
      ),
    ];
  }

  List<Widget> _buildResetPasswordStep() {
    return [
      const Text(
        'Create New Password',
        style: TextStyle(
          color: Color(0xFF2D2D2D),
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'Your new password must be different from previous passwords',
        style: TextStyle(
          color: Color(0xFF666666),
          fontSize: 14,
          letterSpacing: 0.2,
        ),
      ),
      const SizedBox(height: 32),
      const Text(
        'New Password',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Color(0xFF2D2D2D),
          letterSpacing: 0.2,
        ),
      ),
      const SizedBox(height: 8),
      _buildInputField(
        controller: _newPasswordController,
        hint: 'Enter new password',
        icon: Icons.lock_outline,
        isPassword: true,
        obscureText: _obscureNewPassword,
        onToggleVisibility: () {
          setState(() => _obscureNewPassword = !_obscureNewPassword);
        },
      ),
      const SizedBox(height: 20),
      const Text(
        'Confirm Password',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Color(0xFF2D2D2D),
          letterSpacing: 0.2,
        ),
      ),
      const SizedBox(height: 8),
      _buildInputField(
        controller: _confirmPasswordController,
        hint: 'Confirm new password',
        icon: Icons.lock_outline,
        isPassword: true,
        obscureText: _obscureConfirmPassword,
        onToggleVisibility: () {
          setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
        },
      ),
      const SizedBox(height: 32),
      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _isLoading ? null : _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF4444),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
        ),
      ),
    ];
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    TextInputType? keyboardType,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF999999), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2D2D2D),
                letterSpacing: 0.2,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 14,
                  letterSpacing: 0.2,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          if (isPassword)
            IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFF999999),
                size: 20,
              ),
              onPressed: onToggleVisibility,
            ),
        ],
      ),
    );
  }
}
