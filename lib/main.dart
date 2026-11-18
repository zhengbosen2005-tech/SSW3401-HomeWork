import 'package:flutter/material.dart';

// 程序入口
void main() {
  runApp(const MyApp());
}

// 页面配色
const Color primaryGreen = Color(0xFF235C45);
const Color pageBackground = Color(0xFFFFFEF8);

// 应用入口组件
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pageBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: pageBackground,
          foregroundColor: primaryGreen,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: const ProfilePage(),
    );
  }
}

// 学生个人主页
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 当前是首页，没有上一页时显示提示
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              showNotice(context, 'You are already on the home page.');
            }
          },
        ),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          child: Center(
            child: ConstrainedBox(
              // 在宽屏设备上限制内容宽度
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 头像、姓名和身份
                  const ProfileHeader(),

                  const SizedBox(height: 32),

                  // 三张统计卡片
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: Icons.flag_rounded,
                          iconColor: Color(0xFFDA5951),
                          backgroundColor: Color(0xFFFFF0B5),
                          value: '85%',
                          label: 'Goal',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: Icons.thumb_up_alt_rounded,
                          iconColor: Color(0xFF319E9B),
                          backgroundColor: Color(0xFFDFF1E8),
                          value: '32',
                          label: 'Total Class',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: Icons.menu_book_rounded,
                          iconColor: Color(0xFFCC7594),
                          backgroundColor: Color(0xFFF9E3E8),
                          value: '+10',
                          label: 'Total Books',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // 课程区域标题
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Course Details',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          showNotice(
                            context,
                            'All 2 available courses are shown below.',
                          );
                        },
                        child: const Text('View all'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // 第一节课
                  const CourseTile(
                    title: 'Introduction',
                    subtitle: 'Start with the basics of this course.',
                    highlighted: true,
                  ),

                  const Divider(
                    height: 28,
                    color: Color(0xFFE4E8DF),
                  ),

                  // 第二节课
                  const CourseTile(
                    title: 'The Language of Color',
                    subtitle: 'Learn how colors communicate ideas.',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 个人资料区域
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 三层圆形形成头像外圈
        const CircleAvatar(
          radius: 51,
          backgroundColor: primaryGreen,
          child: CircleAvatar(
            radius: 48,
            backgroundColor: Colors.white,
            child: CircleAvatar(
             radius: 44,
  backgroundColor: Color(0xFFFFD96A),
  backgroundImage: AssetImage(
    'assets/images/avatar.jpg',
  ),
),
          ),
        ),

        const SizedBox(height: 26),

        const Text(
          '佐藤ヤニコ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Color(0xFF202820),
          ),
        ),

        const SizedBox(height: 8),

        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_rounded,
              size: 18,
              color: primaryGreen,
            ),
            SizedBox(width: 6),
            Text(
              'Student',
              style: TextStyle(
                fontSize: 14,
                color: primaryGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// 可重复使用的统计卡片
class StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String value;
  final String label;

  const StatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 36,
            color: iconColor,
          ),

          const SizedBox(height: 16),

          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0xFF202820),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF384238),
            ),
          ),
        ],
      ),
    );
  }
}

// 可重复使用的课程条目
class CourseTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool highlighted;

  const CourseTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: highlighted
              ? primaryGreen
              : const Color(0xFFDDEBE0),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          Icons.play_arrow_rounded,
          size: 30,
          color: highlighted ? Colors.white : primaryGreen,
        ),
      ),

      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),

      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ),

      onTap: () {
        showDialog<void>(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              title: Text(title),
              content: const Text(
                'This is a UI demonstration. '
                'Course videos have not been added yet.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// 设置页面
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Profile Information',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.person_outline,
                  color: primaryGreen,
                ),
                title: Text('Name'),
                subtitle: Text(''),
              ),

              Divider(),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.school_outlined,
                  color: primaryGreen,
                ),
                title: Text('Role'),
                subtitle: Text('Student'),
              ),

              SizedBox(height: 20),

              Text(
                'These are sample profile details.',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 通用提示消息
void showNotice(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
}