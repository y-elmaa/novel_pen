import 'package:flutter/material.dart';



class homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostListPage(),
    );
  }
}

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  List<Post> _posts = [
    Post('John Doe', 'Hello, World!'),
    Post('Jane Smith', 'Flutter is awesome!'),
    Post('Alice', 'Learning Flutter today.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post List'),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (BuildContext context, int index) {
          return PostItem(
            key: Key(index.toString()), // Using index as the key
            post: _posts[index],
            onLike: () {
              setState(() {
                _posts[index].like();
              });
            },
            onComment: () {
              // Implement comment functionality here
              print('Commented on post ${_posts[index].content}');
            },
          );
        },
      ),
    );
  }
}

class Post {
  final String author;
  final String content;
  int likes;

  Post(this.author, this.content, {this.likes = 0});

  void like() {
    likes++;
  }
}

class PostItem extends StatelessWidget {
  final Key? key; // Key can be null
  final Post post;
  final VoidCallback onLike;
  final VoidCallback onComment;

  const PostItem({
    this.key, // Key can be null
    required this.post,
    required this.onLike,
    required this.onComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.author,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text(post.content),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: onLike,
                ),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: onComment,
                ),
                Text('${post.likes} likes'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
