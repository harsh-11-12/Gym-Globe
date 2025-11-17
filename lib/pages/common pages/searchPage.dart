import 'package:flutter/material.dart';
import 'package:gym_globe/pages/common%20pages/workoutPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<UserProfile> _searchResults = [];
  bool _isSearching = false;
  String _selectedFilter = 'All';

  // Sample database of users, trainers, and gyms
  final List<UserProfile> _allProfiles = [
    // Trainers
    UserProfile(
      name: 'John Fitness',
      accountType: AccountType.trainer,
      profileImage: 'https://via.placeholder.com/150',
      bio: 'Certified personal trainer with 10+ years experience',
      followers: 2500,
      rating: 4.8,
      specialization: 'Strength Training',
      verified: true,
    ),
    UserProfile(
      name: 'Sarah Strong',
      accountType: AccountType.trainer,
      profileImage: 'https://via.placeholder.com/150',
      bio: 'Olympic weightlifting coach & nutritionist',
      followers: 3200,
      rating: 4.9,
      specialization: 'Weightlifting',
      verified: true,
    ),
    UserProfile(
      name: 'Mike Muscles',
      accountType: AccountType.trainer,
      profileImage: 'https://via.placeholder.com/150',
      bio: 'Bodybuilding expert and fitness model',
      followers: 5100,
      rating: 4.7,
      specialization: 'Bodybuilding',
      verified: true,
    ),
    UserProfile(
      name: 'Emma Elite',
      accountType: AccountType.trainer,
      profileImage: 'https://via.placeholder.com/150',
      bio: 'Yoga and flexibility specialist',
      followers: 1800,
      rating: 4.9,
      specialization: 'Yoga & Flexibility',
      verified: false,
    ),

    // Gyms
    UserProfile(
      name: 'PowerHouse Gym',
      accountType: AccountType.gym,
      profileImage: 'https://via.placeholder.com/150',
      bio: 'Premium gym with state-of-the-art equipment',
      followers: 4500,
      rating: 4.6,
      location: 'New York, NY',
      facilities: ['Cardio Area', 'Weight Training', 'Swimming Pool', 'Sauna'],
      verified: true,
    ),
    UserProfile(
      name: 'Fitness First Center',
      accountType: AccountType.gym,
      profileImage: 'https://via.placeholder.com/150',
      bio: '24/7 access gym for all fitness levels',
      followers: 3800,
      rating: 4.5,
      location: 'Los Angeles, CA',
      facilities: ['24/7 Access', 'Personal Training', 'Group Classes'],
      verified: true,
    ),
    UserProfile(
      name: 'Iron Paradise',
      accountType: AccountType.gym,
      profileImage: 'https://via.placeholder.com/150',
      bio: 'Hardcore bodybuilding gym',
      followers: 2200,
      rating: 4.8,
      location: 'Miami, FL',
      facilities: ['Heavy Weights', 'Powerlifting Platform', 'Supplements'],
      verified: false,
    ),

    // Normal Users
    UserProfile(
      name: 'Alex Johnson',
      accountType: AccountType.user,
      profileImage: 'https://via.placeholder.com/150',
      bio: 'Fitness enthusiast | Marathon runner',
      followers: 450,
      verified: false,
    ),
    UserProfile(
      name: 'Lisa Chen',
      accountType: AccountType.user,
      profileImage: 'https://via.placeholder.com/150',
      bio: 'Yoga lover | Plant-based athlete',
      followers: 680,
      verified: false,
    ),
    UserProfile(
      name: 'David Brown',
      accountType: AccountType.user,
      profileImage: 'https://via.placeholder.com/150',
      bio: 'Weightlifting journey | Progress tracker',
      followers: 320,
      verified: false,
    ),
  ];

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _searchResults = _allProfiles.where((profile) {
        final matchesQuery =
            profile.name.toLowerCase().contains(query.toLowerCase()) ||
            profile.bio.toLowerCase().contains(query.toLowerCase());

        final matchesFilter =
            _selectedFilter == 'All' ||
            (_selectedFilter == 'Trainers' &&
                profile.accountType == AccountType.trainer) ||
            (_selectedFilter == 'Gyms' &&
                profile.accountType == AccountType.gym) ||
            (_selectedFilter == 'Users' &&
                profile.accountType == AccountType.user);

        return matchesQuery && matchesFilter;
      }).toList();
    });
  }

  void _viewProfile(UserProfile profile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileDetailPage(profile: profile),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.deepPurple,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search trainers, gyms, or users...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
              onChanged: _performSearch,
            ),
          ),

          // Filter Chips
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip('All'),
                _buildFilterChip('Trainers'),
                _buildFilterChip('Gyms'),
                _buildFilterChip('Users'),
              ],
            ),
          ),

          // Search Results
          Expanded(
            child: _searchController.text.isEmpty
                ? _buildEmptyState()
                : _searchResults.isEmpty
                ? _buildNoResults()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      return _buildProfileCard(_searchResults[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = label;
            _performSearch(_searchController.text);
          });
        },
        backgroundColor: Colors.white,
        selectedColor: Colors.deepPurple,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
        checkmarkColor: Colors.white,
      ),
    );
  }

  Widget _buildProfileCard(UserProfile profile) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => _viewProfile(profile),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Profile Image
              Stack(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(profile.profileImage),
                  ),
                  if (profile.verified)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 15),

              // Profile Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            profile.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildAccountTypeBadge(profile.accountType),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile.bio,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (profile.accountType == AccountType.trainer ||
                            profile.accountType == AccountType.gym) ...[
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            '${profile.rating}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 15),
                        ],
                        const Icon(Icons.people, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${profile.followers}',
                          style: const TextStyle(fontSize: 13),
                        ),
                        if (profile.specialization != null) ...[
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              profile.specialization!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                        if (profile.location != null) ...[
                          const SizedBox(width: 15),
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.red.shade400,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountTypeBadge(AccountType type) {
    String label;
    Color color;
    IconData icon;

    switch (type) {
      case AccountType.trainer:
        label = 'Trainer';
        color = Colors.orange;
        icon = Icons.fitness_center;
        break;
      case AccountType.gym:
        label = 'Gym';
        color = Colors.green;
        icon = Icons.location_city;
        break;
      case AccountType.user:
        label = 'User';
        color = Colors.blue;
        icon = Icons.person;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 20),
          Text(
            'Search for trainers, gyms, or users',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 10),
          Text(
            'Start typing to see results',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 20),
          Text(
            'No results found',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 10),
          Text(
            'Try a different search term',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}

// Profile Detail Page
class ProfileDetailPage extends StatelessWidget {
  final UserProfile profile;

  const ProfileDetailPage({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Profile Image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.deepPurple,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(profile.profileImage),
                        ),
                        if (profile.verified)
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      profile.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    _buildAccountTypeBadge(profile.accountType),
                  ],
                ),
              ),
            ),
          ),

          // Profile Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn('Followers', '${profile.followers}'),
                      if (profile.rating != null)
                        _buildStatColumn('Rating', '${profile.rating} ⭐'),
                      if (profile.accountType == AccountType.trainer)
                        _buildStatColumn('Clients', '120'),
                      if (profile.accountType == AccountType.gym)
                        _buildStatColumn('Members', '850'),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Follow'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.deepPurple),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Message'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Bio
                  const Text(
                    'About',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    profile.bio,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Specialization (for Trainers)
                  if (profile.specialization != null) ...[
                    const Text(
                      'Specialization',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Chip(
                      label: Text(profile.specialization!),
                      backgroundColor: Colors.deepPurple.withOpacity(0.1),
                      labelStyle: const TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],

                  // Location (for Gyms)
                  if (profile.location != null) ...[
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red.shade400),
                        const SizedBox(width: 8),
                        Text(
                          profile.location!,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                  ],

                  // Facilities (for Gyms)
                  if (profile.facilities != null) ...[
                    const Text(
                      'Facilities',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: profile.facilities!
                          .map(
                            (facility) => Chip(
                              label: Text(facility),
                              backgroundColor: Colors.green.withOpacity(0.1),
                              labelStyle: const TextStyle(
                                color: Colors.green,
                                fontSize: 13,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 25),
                  ],

                  // Recent Posts Section
                  const Text(
                    'Recent Posts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://via.placeholder.com/150',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildAccountTypeBadge(AccountType type) {
    String label;
    Color color;

    switch (type) {
      case AccountType.trainer:
        label = 'Certified Trainer';
        color = Colors.orange;
        break;
      case AccountType.gym:
        label = 'Gym Owner';
        color = Colors.green;
        break;
      case AccountType.user:
        label = 'Fitness Enthusiast';
        color = Colors.blue;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Models
enum AccountType { user, trainer, gym }

class UserProfile {
  final String name;
  final AccountType accountType;
  final String profileImage;
  final String bio;
  final int followers;
  final double? rating;
  final String? specialization;
  final String? location;
  final List<String>? facilities;
  final bool verified;

  UserProfile({
    required this.name,
    required this.accountType,
    required this.profileImage,
    required this.bio,
    required this.followers,
    this.rating,
    this.specialization,
    this.location,
    this.facilities,
    this.verified = false,
  });
}
