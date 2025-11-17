// pages/common pages/contentPage.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final List<Post> posts = [
    Post(
      username: "John Fitness",
      userAvatar: "https://via.placeholder.com/150",
      role: "Certified Trainer",
      contentType: ContentType.video,
      mediaUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      caption:
          "Full Chest Destruction Workout — 4 exercises that changed my clients forever!",
      likes: 2847,
      comments: 89,
      isLiked: false,
      timestamp: "2h ago",
    ),
    Post(
      username: "PowerHouse Gym",
      userAvatar: "https://via.placeholder.com/150",
      role: "Gym Owner • NYC",
      contentType: ContentType.image,
      mediaUrl:
          "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=800",
      caption:
          "New equipment just dropped! Come try our brand new Hammer Strength machines",
      likes: 1203,
      comments: 45,
      isLiked: true,
      timestamp: "5h ago",
    ),
    Post(
      username: "Sarah Strong",
      userAvatar: "https://via.placeholder.com/150",
      role: "Olympic Coach",
      contentType: ContentType.image,
      mediaUrl:
          "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800",
      caption:
          "Before → After: 12-week transformation with one of my online clients! Consistency is key",
      likes: 5672,
      comments: 312,
      isLiked: false,
      timestamp: "1d ago",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Content Feed",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: posts.length,
        itemBuilder: (context, index) => PostCard(
          post: posts[index],
          onLikePressed: () {
            setState(() => posts[index].isLiked = !posts[index].isLiked);
            if (posts[index].isLiked) {
              posts[index].likes++;
            } else {
              posts[index].likes--;
            }
          },
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLikePressed;

  const PostCard({Key? key, required this.post, required this.onLikePressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(post.userAvatar),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      post.role,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  post.timestamp,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
              ],
            ),
          ),

          // Media (Image/Video)
          if (post.contentType == ContentType.image)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: post.mediaUrl,
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: Colors.grey.shade200,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            )
          else
            Container(
              height: 400,
              color: Colors.black,
              child: const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 80,
                  color: Colors.white70,
                ),
              ),
            ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    post.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: post.isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: onLikePressed,
                ),
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.send_outlined),
                  onPressed: () {},
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Likes & Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${post.likes} likes",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: post.username + " ",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: post.caption),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "View all ${post.comments} comments",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Models
enum ContentType { image, video }

class Post {
  final String username;
  final String userAvatar;
  final String role;
  final ContentType contentType;
  final String mediaUrl;
  final String caption;
  int likes;
  final int comments;
  bool isLiked;
  final String timestamp;

  Post({
    required this.username,
    required this.userAvatar,
    required this.role,
    required this.contentType,
    required this.mediaUrl,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.isLiked,
    required this.timestamp,
  });
}
