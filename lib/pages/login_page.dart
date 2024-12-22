import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/authprovider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController(); // Controller for name
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StepPulse'),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // App Name
              const Text(
                'StepPulse',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 8),
              // Welcome Message
              Text(
                authProvider.isLogin
                    ? 'Welcome Back! Please log in to continue.'
                    : 'Join StepPulse and track your health effortlessly!',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              if (authProvider.errorMessage != null)
                Text(
                  authProvider.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              if (authProvider.errorMessage != null) const SizedBox(height: 8),
              if (!authProvider.isLogin)
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: theme.colorScheme.primary),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                    ),
                  ),
                ),
              if (!authProvider.isLogin) const SizedBox(height: 16),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (!authProvider.isLogin && nameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter your name')),
                    );
                    return;
                  }

                  await authProvider.submit(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );

                  if (authProvider.errorMessage == null) {
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                child: Text(authProvider.isLogin ? 'Login' : 'Create Account'),
              ),
              TextButton(
                onPressed: authProvider.toggleFormType,
                child: Text(
                  authProvider.isLogin
                      ? 'Don’t have an account? Create one'
                      : 'Already have an account? Login',
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
