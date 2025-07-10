import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/user_model.dart';
import '../../models/enums.dart';
import '../../providers/auth_provider.dart';
import '../../providers/app_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  late PageController _pageController;
  int _currentPage = 0;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;
  UserRole _selectedRole = UserRole.seeker;
  
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  
  void _nextPage() {
    if (_currentPage < 2) {
      if (_validateCurrentPage()) {
        setState(() => _currentPage++);
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }
  
  void _previousPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  
  bool _validateCurrentPage() {
    switch (_currentPage) {
      case 0:
        return _validateBasicInfo();
      case 1:
        return _validateRoleSelection();
      case 2:
        return _validateTermsAndConditions();
      default:
        return false;
    }
  }
  
  bool _validateBasicInfo() {
    if (_displayNameController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter your display name');
      return false;
    }
    
    if (_emailController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter your email');
      return false;
    }
    
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text.trim())) {
      _showErrorSnackBar('Please enter a valid email');
      return false;
    }
    
    if (_passwordController.text.length < 8) {
      _showErrorSnackBar('Password must be at least 8 characters long');
      return false;
    }
    
    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorSnackBar('Passwords do not match');
      return false;
    }
    
    return true;
  }
  
  bool _validateRoleSelection() {
    // Role is already selected by default, so always valid
    return true;
  }
  
  bool _validateTermsAndConditions() {
    if (!_acceptTerms) {
      _showErrorSnackBar('Please accept the terms and conditions');
      return false;
    }
    return true;
  }
  
  Future<void> _register() async {
    if (!_formKey.currentState!.validate() || !_validateCurrentPage()) return;
    
    final success = await ref.read(authStateProvider.notifier).signUpWithEmailPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      displayName: _displayNameController.text.trim(),
      role: _selectedRole,
    );
    
    if (success && mounted) {
      context.go('/home');
    }
  }
  
  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = ref.watch(isDarkModeProvider);
    final authState = ref.watch(authStateProvider);
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[50],
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [Colors.grey[900]!, Colors.grey[800]!]
                : [Colors.blue[50]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with progress indicator
              _buildHeader(theme, isDarkMode),
              
              // Form content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildBasicInfoPage(theme, isDarkMode),
                    _buildRoleSelectionPage(theme, isDarkMode),
                    _buildTermsPage(theme, isDarkMode),
                  ],
                ),
              ),
              
              // Navigation buttons
              _buildNavigationButtons(theme, isDarkMode, authState),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader(ThemeData theme, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Back button and title
          Row(
            children: [
              IconButton(
                onPressed: () => context.go('/login'),
                icon: const Icon(Icons.arrow_back),
              ),
              const Spacer(),
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.grey[800],
                ),
              ),
              const Spacer(),
              const SizedBox(width: 48), // Balance the back button
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Progress indicator
          Row(
            children: List.generate(3, (index) {
              final isActive = index <= _currentPage;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                  height: 4,
                  decoration: BoxDecoration(
                    color: isActive ? theme.primaryColor : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          
          const SizedBox(height: 16),
          
          // Step title
          Text(
            _getStepTitle(),
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.white70 : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
  
  String _getStepTitle() {
    switch (_currentPage) {
      case 0:
        return 'Step 1: Basic Information';
      case 1:
        return 'Step 2: Choose Your Role';
      case 2:
        return 'Step 3: Terms & Conditions';
      default:
        return '';
    }
  }
  
  Widget _buildBasicInfoPage(ThemeData theme, bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[850] : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tell us about yourself',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.grey[800],
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'We\'ll use this information to personalize your experience',
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.grey[600],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Display Name
              TextFormField(
                controller: _displayNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Display Name',
                  prefixIcon: const Icon(Icons.person_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'How should others see you?',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your display name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Phone (optional)
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Phone Number (Optional)',
                  prefixIcon: const Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: '+1 (555) 123-4567',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\(\)\s]')),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  if (!RegExp(r'(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
                    return 'Password must contain uppercase, lowercase, and number';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Confirm Password
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildRoleSelectionPage(ThemeData theme, bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Your Role',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.grey[800],
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Select the role that best describes how you plan to use YOLO',
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Role options
            _buildRoleOption(
              role: UserRole.seeker,
              title: 'Seeker',
              description: 'I need help with various tasks and challenges',
              icon: Icons.search,
              theme: theme,
              isDarkMode: isDarkMode,
            ),
            
            const SizedBox(height: 16),
            
            _buildRoleOption(
              role: UserRole.helper,
              title: 'Helper',
              description: 'I want to help others and share my skills',
              icon: Icons.helping_hand,
              theme: theme,
              isDarkMode: isDarkMode,
            ),
            
            const SizedBox(height: 16),
            
            _buildRoleOption(
              role: UserRole.business,
              title: 'Business',
              description: 'I represent a business or organization',
              icon: Icons.business,
              theme: theme,
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRoleOption({
    required UserRole role,
    required String title,
    required String description,
    required IconData icon,
    required ThemeData theme,
    required bool isDarkMode,
  }) {
    final isSelected = _selectedRole == role;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = role),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
              ? theme.primaryColor.withOpacity(0.1)
              : (isDarkMode ? Colors.grey[800] : Colors.grey[50]),
          border: Border.all(
            color: isSelected 
                ? theme.primaryColor 
                : (isDarkMode ? Colors.grey[700]! : Colors.grey[300]!),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected 
                    ? theme.primaryColor 
                    : (isDarkMode ? Colors.grey[700] : Colors.grey[300]),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : (isDarkMode ? Colors.white70 : Colors.grey[600]),
                size: 24,
              ),
            ),
            
            const SizedBox(width: 16),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isSelected 
                          ? theme.primaryColor 
                          : (isDarkMode ? Colors.white : Colors.grey[800]),
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white70 : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.primaryColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTermsPage(ThemeData theme, bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.grey[800],
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Please review and accept our terms to continue',
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Terms content
            Container(
              height: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                ),
              ),
              child: SingleChildScrollView(
                child: Text(
                  _getTermsText(),
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.white70 : Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Accept terms checkbox
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _acceptTerms,
                  onChanged: (value) => setState(() => _acceptTerms = value ?? false),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _acceptTerms = !_acceptTerms),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: theme.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: theme.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  String _getTermsText() {
    return '''YOLO Need App - Terms of Service

Welcome to YOLO Need App. By using our service, you agree to these terms.

1. Acceptance of Terms
By accessing and using this application, you accept and agree to be bound by the terms and provision of this agreement.

2. Use License
Permission is granted to temporarily use YOLO Need App for personal, non-commercial transitory viewing only.

3. User Accounts
You are responsible for safeguarding the password and for maintaining the confidentiality of your account.

4. Privacy Policy
Your privacy is important to us. Please review our Privacy Policy, which also governs your use of the Service.

5. Community Guidelines
- Be respectful to all users
- Provide accurate information
- Do not spam or abuse the platform
- Help create a positive community

6. Content
Users are solely responsible for the content they post. We reserve the right to remove any content that violates these terms.

7. Limitation of Liability
The service is provided on an "as is" basis. We disclaim all warranties and limit our liability to the fullest extent permitted by law.

8. Changes to Terms
We reserve the right to update these terms at any time. Continued use of the service constitutes acceptance of new terms.

9. Contact Information
If you have any questions about these Terms, please contact us at support@yolo-need-app.com.

Last updated: January 2024''';
  }
  
  Widget _buildNavigationButtons(ThemeData theme, bool isDarkMode, AuthState authState) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          // Previous button
          if (_currentPage > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousPage,
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.primaryColor,
                  side: BorderSide(color: theme.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Previous'),
              ),
            ),
          
          if (_currentPage > 0) const SizedBox(width: 16),
          
          // Next/Register button
          Expanded(
            child: ElevatedButton(
              onPressed: authState.isLoading ? null : (_currentPage < 2 ? _nextPage : _register),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: authState.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      _currentPage < 2 ? 'Next' : 'Create Account',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        ],
      ),
    );
  }
} 