import 'package:flutter/material.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({Key? key}) : super(key: key);

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardPageState();
}

class _OwnerDashboardPageState extends State<OwnerDashboard> {
  // Gym Information
  String gymName = "PowerHouse Fitness Center";
  double monthlyFees = 1500.0;
  double annualFees = 15000.0;
  String gymLocation = "123 Fitness Street, New York, NY 10001";

  // Stats
  int totalMembers = 245;
  int activeMembersPaying = 220;
  int newMembersThisMonth = 18;
  double totalFeeDue = 45000.0;
  int feeDueMembers = 25;
  int trainersCount = 8;
  double totalTrainerSalaryDue = 12000.0;
  int trainersWithSalaryDue = 3;
  double monthlyRevenue = 367500.0;
  double monthlyExpenses = 85000.0;
  int gymEquipment = 156;
  double todayAttendance = 78.5;

  // Fee Due Members
  List<FeeDueMember> feeDueMembersList = [
    FeeDueMember(
      name: 'John Smith',
      amount: 3000,
      monthsDue: 2,
      phone: '+1234567890',
      joinDate: DateTime(2023, 5, 15),
    ),
    FeeDueMember(
      name: 'Sarah Johnson',
      amount: 1500,
      monthsDue: 1,
      phone: '+1234567891',
      joinDate: DateTime(2023, 8, 20),
    ),
    FeeDueMember(
      name: 'Mike Davis',
      amount: 4500,
      monthsDue: 3,
      phone: '+1234567892',
      joinDate: DateTime(2023, 3, 10),
    ),
    FeeDueMember(
      name: 'Emma Wilson',
      amount: 1500,
      monthsDue: 1,
      phone: '+1234567893',
      joinDate: DateTime(2023, 9, 5),
    ),
    FeeDueMember(
      name: 'Alex Brown',
      amount: 3000,
      monthsDue: 2,
      phone: '+1234567894',
      joinDate: DateTime(2023, 6, 12),
    ),
  ];

  // Trainers
  List<Trainer> trainersList = [
    Trainer(
      name: 'Coach Mike',
      salary: 4000,
      salaryDue: 4000,
      specialization: 'Strength Training',
      attendance: 95.5,
      phone: '+1234567895',
    ),
    Trainer(
      name: 'Sarah Fitness',
      salary: 3500,
      salaryDue: 0,
      specialization: 'Yoga',
      attendance: 98.2,
      phone: '+1234567896',
    ),
    Trainer(
      name: 'John Strong',
      salary: 4500,
      salaryDue: 4500,
      specialization: 'Bodybuilding',
      attendance: 92.0,
      phone: '+1234567897',
    ),
    Trainer(
      name: 'Emma Cardio',
      salary: 3000,
      salaryDue: 0,
      specialization: 'Cardio',
      attendance: 96.8,
      phone: '+1234567898',
    ),
    Trainer(
      name: 'David Power',
      salary: 4000,
      salaryDue: 0,
      specialization: 'CrossFit',
      attendance: 94.3,
      phone: '+1234567899',
    ),
    Trainer(
      name: 'Lisa Flex',
      salary: 3500,
      salaryDue: 3500,
      specialization: 'Flexibility',
      attendance: 97.5,
      phone: '+1234567800',
    ),
  ];

  // Gym Media
  List<GymMedia> gymMediaList = [
    GymMedia(
      url: 'https://via.placeholder.com/300',
      type: MediaType.image,
      uploadDate: DateTime.now(),
    ),
    GymMedia(
      url: 'https://via.placeholder.com/300',
      type: MediaType.video,
      uploadDate: DateTime.now().subtract(Duration(days: 1)),
    ),
    GymMedia(
      url: 'https://via.placeholder.com/300',
      type: MediaType.image,
      uploadDate: DateTime.now().subtract(Duration(days: 2)),
    ),
    GymMedia(
      url: 'https://via.placeholder.com/300',
      type: MediaType.image,
      uploadDate: DateTime.now().subtract(Duration(days: 3)),
    ),
    GymMedia(
      url: 'https://via.placeholder.com/300',
      type: MediaType.video,
      uploadDate: DateTime.now().subtract(Duration(days: 4)),
    ),
    GymMedia(
      url: 'https://via.placeholder.com/300',
      type: MediaType.image,
      uploadDate: DateTime.now().subtract(Duration(days: 5)),
    ),
  ];

  void _viewFeeDueMembers() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Fee Due Members',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '₹${totalFeeDue.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: feeDueMembersList.length,
                    itemBuilder: (context, index) {
                      final member = feeDueMembersList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.red.shade100,
                            child: Text(
                              member.name[0],
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            member.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${member.monthsDue} month(s) overdue\n${member.phone}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '₹${member.amount}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 25),
                                ),
                                child: const Text(
                                  'Remind',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _viewTrainers() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Trainers Management',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: trainersList.length,
                    itemBuilder: (context, index) {
                      final trainer = trainersList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            backgroundColor: trainer.salaryDue > 0
                                ? Colors.red.shade100
                                : Colors.green.shade100,
                            child: Text(
                              trainer.name[0],
                              style: TextStyle(
                                color: trainer.salaryDue > 0
                                    ? Colors.red
                                    : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            trainer.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            trainer.specialization,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  _buildTrainerDetailRow(
                                    'Salary',
                                    '₹${trainer.salary}',
                                  ),
                                  _buildTrainerDetailRow(
                                    'Salary Due',
                                    '₹${trainer.salaryDue}',
                                    valueColor: trainer.salaryDue > 0
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                  _buildTrainerDetailRow(
                                    'Attendance',
                                    '${trainer.attendance}%',
                                    valueColor: trainer.attendance > 95
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                                  _buildTrainerDetailRow(
                                    'Phone',
                                    trainer.phone,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.phone,
                                            size: 16,
                                          ),
                                          label: const Text('Call'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.payment,
                                            size: 16,
                                          ),
                                          label: const Text('Pay'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.deepPurple,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _manageMedia() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GymMediaManagementPage(
          mediaList: gymMediaList,
          onDelete: (index) {
            setState(() {
              gymMediaList.removeAt(index);
            });
          },
        ),
      ),
    );
  }

  void _promoteGym() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Promote Your Gym'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Choose promotion package:'),
              const SizedBox(height: 20),
              _buildPromotionOption('Basic', '₹999/month', 'Reach 10K+ users'),
              _buildPromotionOption(
                'Premium',
                '₹2499/month',
                'Reach 50K+ users',
              ),
              _buildPromotionOption(
                'Elite',
                '₹4999/month',
                'Reach 100K+ users',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPromotionOption(String title, String price, String reach) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(reach),
        trailing: Text(
          price,
          style: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('$title package selected!')));
        },
      ),
    );
  }

  Widget _buildTrainerDetailRow(
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, color: valueColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final netProfit = monthlyRevenue - monthlyExpenses;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Gym Name
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Owner Dashboard',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                gymName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            gymLocation,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Fees Information
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Membership Fees',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Monthly',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '₹$monthlyFees',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey.shade300,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Annual',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '₹$annualFees',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Key Stats Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.3,
                  children: [
                    _buildStatCard(
                      'Total Members',
                      '$totalMembers',
                      Icons.people,
                      Colors.blue,
                      onTap: () {},
                    ),
                    _buildStatCard(
                      'Fee Due',
                      '₹${(totalFeeDue / 1000).toStringAsFixed(0)}K',
                      Icons.money_off,
                      Colors.red,
                      subtitle: '$feeDueMembers members',
                      onTap: _viewFeeDueMembers,
                    ),
                    _buildStatCard(
                      'Trainers',
                      '$trainersCount',
                      Icons.fitness_center,
                      Colors.orange,
                      onTap: _viewTrainers,
                    ),
                    _buildStatCard(
                      'Salary Due',
                      '₹${(totalTrainerSalaryDue / 1000).toStringAsFixed(0)}K',
                      Icons.payment,
                      Colors.purple,
                      subtitle: '$trainersWithSalaryDue trainers',
                      onTap: _viewTrainers,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Revenue Overview
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade400, Colors.teal.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Monthly Financial Overview',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildFinancialRow(
                        'Revenue',
                        monthlyRevenue,
                        Colors.white,
                      ),
                      const SizedBox(height: 10),
                      _buildFinancialRow(
                        'Expenses',
                        monthlyExpenses,
                        Colors.white70,
                      ),
                      const Divider(color: Colors.white30, height: 30),
                      _buildFinancialRow(
                        'Net Profit',
                        netProfit,
                        Colors.white,
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Gym Media Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Gym Gallery',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _manageMedia,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Manage'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: gymMediaList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildAddMediaCard();
                    }
                    return _buildMediaPreview(
                      gymMediaList[index - 1],
                      index - 1,
                    );
                  },
                ),
              ),

              const SizedBox(height: 25),

              // Additional Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today\'s Snapshot',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildSnapshotRow(
                            'Attendance Rate',
                            '$todayAttendance%',
                            Icons.check_circle,
                            Colors.green,
                          ),
                          const Divider(),
                          _buildSnapshotRow(
                            'Equipment Count',
                            '$gymEquipment',
                            Icons.fitness_center,
                            Colors.blue,
                          ),
                          const Divider(),
                          _buildSnapshotRow(
                            'New Members',
                            '+$newMembersThisMonth',
                            Icons.person_add,
                            Colors.orange,
                          ),
                          const Divider(),
                          _buildSnapshotRow(
                            'Active Members',
                            '$activeMembersPaying',
                            Icons.verified,
                            Colors.purple,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _promoteGym,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.rocket_launch, color: Colors.white70),
                          SizedBox(width: 10),
                          Text(
                            'Promote Your Gym',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.person_add),
                            label: const Text('Add Member'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              side: const BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add_business),
                            label: const Text('Add Trainer'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              side: const BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color, {
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 30),
                if (onTap != null)
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialRow(
    String label,
    double amount,
    Color color, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          '₹${amount.toStringAsFixed(0)}',
          style: TextStyle(
            color: color,
            fontSize: isBold ? 20 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSnapshotRow(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddMediaCard() {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.deepPurple,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Upload photo/video')));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add_a_photo, size: 40, color: Colors.deepPurple),
            SizedBox(height: 8),
            Text(
              'Add Media',
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaPreview(GymMedia media, int index) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(media.url),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          if (media.type == MediaType.video)
            Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow, color: Colors.white),
              ),
            ),
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.white, size: 18),
                onPressed: () {
                  setState(() {
                    gymMediaList.removeAt(index);
                  });
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Media Management Page
class GymMediaManagementPage extends StatelessWidget {
  final List<GymMedia> mediaList;
  final Function(int) onDelete;

  const GymMediaManagementPage({
    Key? key,
    required this.mediaList,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Gallery'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Upload new media')));
            },
            icon: const Icon(Icons.add_a_photo),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: mediaList.length,
        itemBuilder: (context, index) {
          final media = mediaList[index];
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(media.url),
                    fit: BoxFit.cover,
                  ),
                ),
                child: media.type == MediaType.video
                    ? Center(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                    : null,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      onDelete(index);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Models
class FeeDueMember {
  final String name;
  final double amount;
  final int monthsDue;
  final String phone;
  final DateTime joinDate;

  FeeDueMember({
    required this.name,
    required this.amount,
    required this.monthsDue,
    required this.phone,
    required this.joinDate,
  });
}

class Trainer {
  final String name;
  final double salary;
  final double salaryDue;
  final String specialization;
  final double attendance;
  final String phone;

  Trainer({
    required this.name,
    required this.salary,
    required this.salaryDue,
    required this.specialization,
    required this.attendance,
    required this.phone,
  });
}

class GymMedia {
  final String url;
  final MediaType type;
  final DateTime uploadDate;

  GymMedia({required this.url, required this.type, required this.uploadDate});
}

enum MediaType { image, video }
