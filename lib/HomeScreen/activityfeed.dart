// lib/HomeScreen/activityfeed.dart
import 'package:flutter/material.dart';
import 'activity.dart';
import 'activity_detail.dart'; // Import the ActivityDetailScreen

enum BottomNavItem { profile,  notifications,feed, settings, chat } // Add chat to the enum

class ActivityFeedScreen extends StatefulWidget {
  const ActivityFeedScreen({super.key});

  @override
  _ActivityFeedScreenState createState() => _ActivityFeedScreenState();
}

class _ActivityFeedScreenState extends State<ActivityFeedScreen> {
  List<Activity> activities = generateMockActivities(10);
  BottomNavItem currentIndex = BottomNavItem.feed;
  int unreadMessagesCount = 0; // Add this to keep track of unread messages

  static List<Activity> generateMockActivities(int count) {
    List<Activity> activities = [];
    for (int i = 0; i < count; i++) {
      activities.add(
        Activity(
          id: 'MockID$i',
          title: 'Mock Activity $i',
          description: 'This is mock activity $i',
          dateTime: DateTime.now(),
          location: 'Mock Location $i',
          latitude: 0.0, // Add this
          longitude: 0.0, // Add this
        ),
      );
    }
    return activities;
  }

  bool isNewActivity(Activity activity) {
    // Implement this function to check if the activity is new
    // For now, let's assume that an activity is new if it was created in the last 24 hours
    return DateTime.now().difference(activity.dateTime).inHours < 24;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      activities[index].title,
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (isNewActivity(activities[index]))
                    const Chip(
                      label: Text('New', style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.red,
                    ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  activities[index].description,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityDetailScreen(activity: activities[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigation logic goes here
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex.index,
        onTap: (index) {
          setState(() {
            currentIndex = BottomNavItem.values[index]; // Directly assign the index to currentIndex
          });
          // Update the navigation logic to include chat
        },
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_rounded),
            label: 'Feed',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                const Icon(Icons.chat),
                if (unreadMessagesCount > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '$unreadMessagesCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}