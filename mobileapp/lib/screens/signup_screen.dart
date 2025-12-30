import 'package:flutter/material.dart';
import 'package:mobileapp/screens/login_screen.dart';
import 'package:mobileapp/screens/JobExploreScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _experienceController = TextEditingController();

  String? _selectedGender;
  String? _selectedField;

  int _currentStep = 0;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final List<String> _fieldOptions = [
    'Plumbing',
    'Electrical',
    'Carpentry',
    'Construction',
    'Automotive',
    'Welding',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _currentStep == 0 ? 'Create Account' : 'Professional Details',
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
                const SizedBox(height: 20),

                // Progress Indicator
                Row(
                  children: [
                    _buildStepIndicator(0, 'Personal'),
                    _buildStepLine(0),
                    _buildStepIndicator(1, 'Professional'),
                  ],
                ),

                const SizedBox(height: 40),

                // Content based on step
                _currentStep == 0 ? _buildStep1() : _buildStep2(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label) {
    bool isActive = _currentStep >= step;
    bool isCurrent = _currentStep == step;

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
            child: isActive && step < _currentStep
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
    bool isActive = _currentStep > step;
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

  /// STEP 1 - Personal Information
  Widget _buildStep1() {
    return Form(
      key: _formKeyStep1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Information',
            style: TextStyle(
              color: Color(0xFF2D2D2D),
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please fill in your basic details',
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 14,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 32),

          // First Name
          const Text(
            'First Name',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Color(0xFF2D2D2D),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),
          _buildInputField(
            controller: _firstNameController,
            hint: 'Enter your first name',
            icon: Icons.person_outline,
            validator: (v) => v!.isEmpty ? 'First name is required' : null,
          ),
          const SizedBox(height: 20),

          // Last Name
          const Text(
            'Last Name',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Color(0xFF2D2D2D),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),
          _buildInputField(
            controller: _lastNameController,
            hint: 'Enter your last name',
            icon: Icons.person_outline,
            validator: (v) => v!.isEmpty ? 'Last name is required' : null,
          ),
          const SizedBox(height: 20),

          // Email
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
            validator: (v) => v!.contains('@') ? null : 'Enter a valid email',
          ),
          const SizedBox(height: 20),

          // Password
          const Text(
            'Password',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Color(0xFF2D2D2D),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),
          _buildInputField(
            controller: _passwordController,
            hint: 'Enter your password',
            icon: Icons.lock_outline,
            isPassword: true,
            obscureText: _obscurePassword,
            onToggleVisibility: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
          ),
          const SizedBox(height: 20),

          // Confirm Password
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
            hint: 'Confirm your password',
            icon: Icons.lock_outline,
            isPassword: true,
            obscureText: _obscureConfirmPassword,
            onToggleVisibility: () {
              setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword);
            },
          ),

          const SizedBox(height: 32),

          // Continue Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      if (_formKeyStep1.currentState!.validate()) {
                        setState(() => _currentStep = 1);
                      }
                    },
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
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 24),

          // Sign In Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account?',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 15,
                  letterSpacing: 0.2,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Color(0xFFFF4444),
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// STEP 2 - Professional Details
  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Professional Details',
          style: TextStyle(
            color: Color(0xFF2D2D2D),
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Tell us about your work experience',
          style: TextStyle(
            color: Color(0xFF666666),
            fontSize: 14,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 32),

        // Gender
        const Text(
          'Gender',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Color(0xFF2D2D2D),
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        _buildDropdownField(
          hint: 'Select your gender',
          icon: Icons.person_outline,
          value: _selectedGender,
          items: _genderOptions,
          onChanged: (v) => setState(() => _selectedGender = v),
        ),
        const SizedBox(height: 20),

        // Years of Experience
        const Text(
          'Years of Experience',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Color(0xFF2D2D2D),
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        _buildInputField(
          controller: _experienceController,
          hint: 'Enter years of experience',
          icon: Icons.work_outline,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),

        // Field of Work
        const Text(
          'Field of Work',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Color(0xFF2D2D2D),
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        _buildDropdownField(
          hint: 'Select your field',
          icon: Icons.business_center_outlined,
          value: _selectedField,
          items: _fieldOptions,
          onChanged: (v) => setState(() => _selectedField = v),
        ),

        const SizedBox(height: 32),

        // Action Buttons
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: OutlinedButton(
                  onPressed: () => setState(() => _currentStep = 0),
                  style: OutlinedButton.styleFrom(
                    side:
                        const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      color: Color(0xFF2D2D2D),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() => _isLoading = true);
                          await Future.delayed(const Duration(seconds: 2));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const JobExploreScreen()),
                          );
                        },
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
                          'Finish',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    String? Function(String?)? validator,
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
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              validator: validator,
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

  Widget _buildDropdownField({
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
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
            child: DropdownButtonFormField<String>(
              value: value,
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
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2D2D2D),
                letterSpacing: 0.2,
              ),
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF999999), size: 20),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _experienceController.dispose();
    super.dispose();
  }
}
