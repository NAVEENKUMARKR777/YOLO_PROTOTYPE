import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../providers/app_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  
  late TabController _tabController;
  bool _obscurePassword = true;
  bool _rememberMe = false;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  
  Future<void> _signInWithEmail() async {
    if (!_formKey.currentState!.validate()) return;
    
    final success = await ref.read(authStateProvider.notifier).signInWithEmailPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    
    if (success && mounted) {
      context.go('/home');
    }
  }
  
  Future<void> _signInWithPhone() async {
    if (_phoneController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter your phone number');
      return;
    }
    
    final success = await ref.read(authStateProvider.notifier).signInWithPhoneNumber(
      phoneNumber: _phoneController.text.trim(),
    );
    
    if (success && mounted) {
      context.go('/home');
    }
  }
  
  Future<void> _signInWithMicrosoft() async {
    final success = await ref.read(authStateProvider.notifier).signInWithMicrosoft();
    
    if (success && mounted) {
      context.go('/home');
    }
  }
  
  void _forgotPassword() {
    if (_emailController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter your email address first');
      return;
    }
    
    ref.read(authStateProvider.notifier).resetPassword(
      email: _emailController.text.trim(),
    );
    
    _showSuccessSnackBar('Password reset link sent to your email');
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
  
  void _showSuccessSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                
                // Logo and welcome text
                _buildHeader(theme, isDarkMode),
                
                const SizedBox(height: 48),
                
                // Login form
                _buildLoginForm(theme, isDarkMode, authState),
                
                const SizedBox(height: 32),
                
                // Social login options
                _buildSocialLogin(theme, isDarkMode, authState),
                
                const SizedBox(height: 32),
                
                // Sign up option
                _buildSignUpOption(theme, isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader(ThemeData theme, bool isDarkMode) {
    return Column(
      children: [
        // Logo
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.7)],
            ),
            boxShadow: [
              BoxShadow(
                color: theme.primaryColor.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Y',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Welcome text
        Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.grey[800],
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          'Sign in to continue your journey',
          style: TextStyle(
            fontSize: 16,
            color: isDarkMode ? Colors.white70 : Colors.grey[600],
          ),
        ),
      ],
    );
  }
  
  Widget _buildLoginForm(ThemeData theme, bool isDarkMode, AuthState authState) {
    return Container(
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
        children: [
          // Tab selector
          Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: isDarkMode ? Colors.white70 : Colors.grey[600],
              tabs: const [
                Tab(text: 'Email'),
                Tab(text: 'Phone'),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Tab content
          SizedBox(
            height: 280,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEmailLogin(theme, isDarkMode, authState),
                _buildPhoneLogin(theme, isDarkMode, authState),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmailLogin(ThemeData theme, bool isDarkMode, AuthState authState) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Email',
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
          
          // Password field
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
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
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            onFieldSubmitted: (_) => _signInWithEmail(),
          ),
          
          const SizedBox(height: 16),
          
          // Remember me and forgot password
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (value) => setState(() => _rememberMe = value ?? false),
              ),
              const Text('Remember me'),
              const Spacer(),
              TextButton(
                onPressed: _forgotPassword,
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Sign in button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: authState.isLoading ? null : _signInWithEmail,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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
                  : const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPhoneLogin(ThemeData theme, bool isDarkMode, AuthState authState) {
    return Column(
      children: [
        // Phone field
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            prefixIcon: const Icon(Icons.phone_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: '+1 (555) 123-4567',
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\(\)\s]')),
          ],
          onFieldSubmitted: (_) => _signInWithPhone(),
        ),
        
        const SizedBox(height: 24),
        
        // Phone sign in button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: authState.isLoading ? null : _signInWithPhone,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
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
                : const Text(
                    'Sign In with Phone',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Phone verification note
        Text(
          'We\'ll send you a verification code',
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Colors.white60 : Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  
  Widget _buildSocialLogin(ThemeData theme, bool isDarkMode, AuthState authState) {
    return Column(
      children: [
        // Divider
        Row(
          children: [
            Expanded(
              child: Divider(
                color: isDarkMode ? Colors.white30 : Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or continue with',
                style: TextStyle(
                  color: isDarkMode ? Colors.white60 : Colors.grey[600],
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: isDarkMode ? Colors.white30 : Colors.grey[300],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Microsoft sign in button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: authState.isLoading ? null : _signInWithMicrosoft,
            icon: Image.asset(
              'assets/images/microsoft_logo.png',
              width: 20,
              height: 20,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.business,
                size: 20,
                color: Colors.blue,
              ),
            ),
            label: const Text('Continue with Microsoft'),
            style: OutlinedButton.styleFrom(
              foregroundColor: isDarkMode ? Colors.white : Colors.grey[800],
              side: BorderSide(
                color: isDarkMode ? Colors.white30 : Colors.grey[300]!,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildSignUpOption(ThemeData theme, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: TextStyle(
            color: isDarkMode ? Colors.white70 : Colors.grey[600],
          ),
        ),
        TextButton(
          onPressed: () => context.go('/register'),
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
} 