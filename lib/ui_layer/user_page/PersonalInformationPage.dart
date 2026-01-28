import 'package:flutter/material.dart';
import 'package:ice_shield/ui_layer/home_page/MainButton.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';
// For ImageFilter
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/AuthBlock.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/PersonBlock.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/ObjectDatabaseBlock.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  static Widget icon(BuildContext context, {double? size}) {
    return MainButton(
      type: "profile",
      destination: "/profile",
      size: size,
      icon: Icons.person,
      mainFunction: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Edit Profile feature coming soon!'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _countryController;
  late final TextEditingController _postalCodeController;
  late final TextEditingController _bioController;
  late final TextEditingController _occupationController;
  late final TextEditingController _companyController;
  late final TextEditingController _websiteController;
  late final TextEditingController _usernameController;
  late final TextEditingController _genderController;
  late final TextEditingController _githubController;
  late final TextEditingController _linkedinController;
  late final TextEditingController _universityController;
  late final TextEditingController _educationController;
  DateTime? _selectedBirthday;
  bool _isEditing = false;
  bool _isSaving = false;
  final bool _isCreate = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  // late PersonManagementDAO personManagementDAO; // Unused
  final _formKey = GlobalKey<FormState>();
  late final AuthBlock _authBlock;

  // Store loaded data
  // PersonData? _loadedPerson; // Unused
  // EmailAddressData? _loadedEmail; // Unused
  // UserAccountData? _loadedAccount; // Unused
  // ProfileData? _loadedProfile; // Unused
  // bool _isLoading = true; // Unused

  @override
  void initState() {
    super.initState();
    _authBlock = context.read<AuthBlock>();

    // Initialize empty controllers
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _countryController = TextEditingController();
    _postalCodeController = TextEditingController();
    _bioController = TextEditingController();
    _occupationController = TextEditingController();
    _companyController = TextEditingController();
    _websiteController = TextEditingController();
    _usernameController = TextEditingController();
    _genderController = TextEditingController();
    _githubController = TextEditingController();
    _linkedinController = TextEditingController();
    _universityController = TextEditingController();
    _educationController = TextEditingController();

    // Setup animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  // Helper to sync controllers with current state (call in build or listener)
  void _syncControllersWithState(UserInformation info) {
    // Sync if not editing to ensure latest data is shown
    // We check for changes to avoid unnecessary rebuilds/cursor resets if called frequently,
    // though here it is guarded by !_isEditing in build()
    _nameController.text =
        "${info.profiles.firstName} ${info.profiles.lastName}";
    _emailController.text = info
        .profiles
        .profileImageUrl; // Using as placeholder if needed? or empty
    _bioController.text = info.details.bio;
    _occupationController.text = info.details.occupation;
    _websiteController.text = info.details.websiteUrl;
    _cityController.text = info.details.location;
    _companyController.text = info.details.company;
    _countryController.text = info.details.country;
    _githubController.text = info.details.githubUrl;
    _linkedinController.text = info.details.linkedinUrl;
    _universityController.text = info.details.university;
    _educationController.text = info.details.educationLevel;
    _usernameController.text = info.profiles.firstName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _postalCodeController.dispose();
    _bioController.dispose();
    _occupationController.dispose();
    _companyController.dispose();
    _websiteController.dispose();
    _githubController.dispose();
    _linkedinController.dispose();
    _universityController.dispose();
    _educationController.dispose();
    _animationController.dispose();
    _genderController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _selectBirthday() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthday ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        final colorScheme = Theme.of(context).colorScheme;
        return Theme(
          data: Theme.of(context).copyWith(colorScheme: colorScheme),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedBirthday) {
      setState(() {
        _selectedBirthday = picked;
      });
    }
  }

  Future<void> _saveChanges(bool isCreate) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final personBlock = context.read<PersonBlock>();
      final token = _authBlock.jwt.value;

      if (token == null || token.isEmpty) {
        // Handle missing token case
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: No authentication token found')),
        );
        setState(() {
          _isSaving = false;
        });
        return;
      }

      // Better: Get token from AuthBlock if possible.
      // I'll assume for this refactor we call updateProfileDatabase.
      // Wait, PersonBlock.updateProfileDatabase takes 'token'.

      // Optimistic update
      personBlock.editProfile(
        university: _universityController.text,
        location: _cityController.text,
        bio: _bioController.text,
        occupation: _occupationController.text,
        company: _companyController.text,
        websiteUrl: _websiteController.text,
        country: _countryController.text,
        githubUrl: _githubController.text,
        linkedinUrl: _linkedinController.text,
        educationLevel: _educationController.text,
      );

      // Persist to database
      await personBlock.updateProfileDatabase(token);

      // Simulate save delay
      await Future.delayed(Duration(seconds: 1));

      setState(() {
        _isSaving = false;
        _isEditing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Personal information saved (Local Optimistic)',
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isSaving = false;
      });
      // ... error handling
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch PersonBlock signal
    final personBlock = context.watch<PersonBlock>();
    // Access the value of the signal (this triggers rebuilds when signal changes)
    final info = personBlock.information.watch(context);

    final objectBlock = context.watch<ObjectDatabaseBlock>();
    final objectResource = objectBlock.userObjectResource.watch(context);

    // Sync controllers with state if not editing (or initial load)
    // We only sync if we are not editing to avoid overwriting user input while typing
    if (!_isEditing) {
      _syncControllersWithState(info);
    }

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Show loading indicator is no longer needed as much if we have default state,
    // but if we want to show global loading we can check async state.
    // For now we assume signal has initial data.

    // ... rest of build method

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text(
          'Personal Information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 1,
        actions: [
          if (_isCreate)
            IconButton(
              icon: const Icon(Icons.ac_unit_outlined),
              onPressed: _isSaving ? null : () => _saveChanges(true),
              tooltip: 'Create',
            )
          else if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
              tooltip: 'Edit',
            )
          else
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _isSaving ? null : () => _saveChanges(false),
              tooltip: 'Save',
            ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profile Header Card
                _buildProfileHeader(
                  colorScheme,
                  textTheme,
                  _usernameController,
                  objectResource,
                  info,
                ),

                const SizedBox(height: 24),

                // Skills Section
                _buildSectionCard(
                  title: 'Skills',
                  icon: Icons.bolt,
                  children: [
                    Watch((context) {
                      final skillList = personBlock.skills.value;
                      if (skillList.isEmpty) {
                        return Center(
                          child: Text(
                            'No skills added yet',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      }
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: skillList.map((skill) {
                          return Chip(
                            label: Text(
                              skill.name,
                              style: const TextStyle(fontSize: 12),
                            ),
                            backgroundColor: colorScheme.secondaryContainer,
                            side: BorderSide.none,
                            avatar: Icon(
                              Icons.star,
                              size: 14,
                              color: colorScheme.primary,
                            ),
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),

                const SizedBox(height: 24),

                // Basic Information Section
                _buildSectionCard(
                  title: 'Basic Information',
                  icon: Icons.person,
                  children: [
                    _buildTextField(
                      databaseText: '',
                      controller: _nameController,
                      label: 'Full Name',
                      icon: Icons.person_outline,
                      enabled: _isEditing,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      databaseText: '',
                      controller: _emailController,
                      label: 'Email',
                      icon: Icons.email_outlined,
                      enabled: _isEditing,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      databaseText: '',
                      controller: _phoneController,
                      label: 'Phone Number',
                      icon: Icons.phone_outlined,
                      enabled: _isEditing,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    _buildDateField(
                      colorScheme: colorScheme,
                      isEditing: _isEditing,
                      selectedBirthday: _selectedBirthday,
                      onTap: _isEditing ? _selectBirthday : null,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Professional Information Section
                _buildSectionCard(
                  title: 'Details',
                  icon: Icons.work,
                  children: [
                    _buildTextField(
                      databaseText: '',
                      controller: _occupationController,
                      label: 'Occupation',
                      icon: Icons.work_outline,
                      enabled: _isEditing,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      databaseText: '',
                      controller: _companyController,
                      label: 'Company',
                      icon: Icons.business_outlined,
                      enabled: _isEditing,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Education Information Section
                _buildSectionCard(
                  title: 'Education',
                  icon: Icons.school,
                  children: [
                    _buildTextField(
                      databaseText: '',
                      controller: _universityController,
                      label: 'University',
                      icon: Icons.account_balance_outlined,
                      enabled: _isEditing,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      databaseText: '',
                      controller: _educationController,
                      label: 'Education Level',
                      icon: Icons.history_edu_outlined,
                      enabled: _isEditing,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Social Connect Section
                _buildSectionCard(
                  title: 'Social Connect',
                  icon: Icons.share,
                  children: [
                    _buildTextField(
                      databaseText: '',
                      controller: _githubController,
                      label: 'GitHub URL',
                      icon: Icons.code_outlined,
                      enabled: _isEditing,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      databaseText: '',
                      controller: _linkedinController,
                      label: 'LinkedIn URL',
                      icon: Icons.link_outlined,
                      enabled: _isEditing,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      databaseText: '',
                      controller: _websiteController,
                      label: 'Website',
                      icon: Icons.language_outlined,
                      enabled: _isEditing,
                      keyboardType: TextInputType.url,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Address Information Section
                _buildSectionCard(
                  title: 'Address Information',
                  icon: Icons.location_on,
                  children: [
                    _buildTextField(
                      databaseText: '',
                      controller: _addressController,
                      label: 'Street Address',
                      icon: Icons.home_outlined,
                      enabled: _isEditing,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            databaseText: '',
                            controller: _cityController,
                            label: 'City',
                            icon: Icons.location_city_outlined,
                            enabled: _isEditing,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            databaseText: '',
                            controller: _postalCodeController,
                            label: 'Postal Code',
                            icon: Icons.markunread_mailbox_outlined,
                            enabled: _isEditing,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      databaseText: '',
                      controller: _countryController,
                      label: 'Country',
                      icon: Icons.public_outlined,
                      enabled: _isEditing,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Bio Section
                _buildSectionCard(
                  title: 'About',
                  icon: Icons.info,
                  children: [
                    _buildTextField(
                      databaseText: '',
                      controller: _bioController,
                      label: 'Bio',
                      icon: Icons.description_outlined,
                      enabled: _isEditing,
                      maxLines: 4,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      iconSize: 24,
                      icon: Icon(
                        Icons.logout,
                        color: colorScheme.onErrorContainer,
                      ),
                      onPressed: () {
                        _authBlock.logout();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    ColorScheme colorScheme,
    TextTheme textTheme,
    TextEditingController controller,
    UserObjectResource objectResource,
    UserInformation info,
  ) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: colorScheme.primaryContainer,
                  backgroundImage: objectResource.avatarImage.isNotEmpty
                      ? NetworkImage(objectResource.avatarImage)
                      : null,
                  child: (objectResource.avatarImage.isEmpty)
                      ? Icon(
                          Icons.person,
                          size: 50,
                          color: colorScheme.onPrimaryContainer,
                        )
                      : null,
                ),
                if (_isEditing)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: colorScheme.primary,
                      child: const Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (!_isEditing)
              Text(
                controller.text.isNotEmpty ? controller.text : 'Username',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              TextField(
                controller: controller,
                textAlign: TextAlign.center,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Username',
                  border: UnderlineInputBorder(),
                ),
              ),
            const SizedBox(height: 4),
            Text(
              "@${info.profiles.alias.split('-').first}",
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (info.details.bio.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                info.details.bio,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String databaseText,
    required String label,
    required IconData icon,
    required bool enabled,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return enabled
        ? TextFormField(
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: validator,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(icon),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Icon(icon, color: colorScheme.onSurfaceVariant, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        controller.text.isNotEmpty
                            ? controller.text
                            : 'Not set',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildDateField({
    required ColorScheme colorScheme,
    required bool isEditing,
    required DateTime? selectedBirthday,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Birthday',
          prefixIcon: const Icon(Icons.cake_outlined),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        child: Text(
          selectedBirthday != null
              ? DateFormat('MMMM dd, yyyy').format(selectedBirthday)
              : 'Not set',
          style: TextStyle(
            fontSize: 16,
            color: selectedBirthday != null
                ? colorScheme.onSurface
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
