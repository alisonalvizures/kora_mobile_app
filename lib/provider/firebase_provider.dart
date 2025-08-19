import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../model/blog_model.dart';
import '../model/message_model.dart';
import '../model/tracking_model.dart';
import '../model/user_model.dart';
import '../service/firebase_firestone_service.dart';


class FirebaseProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();

  List<UserModel> users = [];
  List<UserModel> volunteers = [];
  List<UserModel> volunteersList = [];
  List<UserModel> usersList = [];
  UserModel? user;
  UserModel? userCurrent;
  List<Message> messages = [];
  List<UserModel> search = [];
  List<BlogModel> blogs = [];
  BlogModel? blog;
  List<TrackingModel> trackings = [];
  var db = FirebaseFirestore.instance;

  List<UserModel> getAllUsers() {
    FirebaseFirestore.instance
        .collection('users')
        .orderBy('lastActive', descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      this.users = users.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
      notifyListeners();
    });
    return users;
  }

  Future<void> getUserChatUIDs(String currentUserUid) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('users').get();
      final Set<String> uniqueUserUids = Set<String>();

      for (var docSnapshot in querySnapshot.docs) {
        final messagesCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserUid)
            .collection('chat')
            .doc(docSnapshot.id)
            .collection('messages');

        final querySnapshot2 = await messagesCollection.get();

        for (var messageDoc in querySnapshot2.docs) {
          if (messageDoc.data() != null) {
            final users = await FirebaseFirestore.instance
                .collection('users')
                .where('uid', isEqualTo: docSnapshot.id)
                .get();

            if (users.docs.isNotEmpty) {
              final userModel = UserModel.fromJson(users.docs.first.data());
              uniqueUserUids.add(userModel.uid);
            }
          }
        }
      }

      // Convierte los UIDs únicos en UserModel y notifica a los escuchadores.
      final uniqueUsers = await Future.wait(uniqueUserUids.map((uid) async {
        final userSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        final userData = userSnapshot.data();
        final userModel = UserModel.fromJson(userData ?? {});
        return userModel;
      }));

      this.usersList = uniqueUsers.toList();
      notifyListeners();
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<UserModel>> getAllVolunteers() async {
    try {
      final querySnapshot = await db.collection("users").where("role", isEqualTo: "Voluntario").get();

      this.volunteers = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();

      notifyListeners();
    } catch (e) {
      print("Error: $e");
    }

    return volunteers;
  }

  UserModel? getUserById(String userId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.user = UserModel.fromJson(user.data()!);
      notifyListeners();
    });
    return user;
  }

  UserModel? getCurrentUserById(String userId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.userCurrent = UserModel.fromJson(user.data()!);
      notifyListeners();
    });
    return userCurrent;
  }

  List<Message> getMessages(String receiverId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .orderBy('sentTime', descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((messages) {
      this.messages = messages.docs
          .map((doc) => Message.fromJson(doc.data()))
          .toList();
      notifyListeners();

      scrollDown();
    });
    return messages;
  }

  void scrollDown() =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(
              scrollController.position.maxScrollExtent);
        }
      });

  Future<void> searchUser(String name) async {
    search =
    await FirebaseFirestoreService.searchUser(name);
    notifyListeners();
  }

  List<BlogModel> getAllBlogs() {
    FirebaseFirestore.instance
        .collection('blogs')
        .snapshots(includeMetadataChanges: true)
        .listen((blogs) {
      this.blogs = blogs.docs
          .map((doc) => BlogModel.fromJson(doc.data()))
          .toList();
      notifyListeners();
    });
    return blogs;
  }

  BlogModel? getBlogById(String blogId) {
    FirebaseFirestore.instance
        .collection('blogs')
        .doc(blogId)
        .snapshots(includeMetadataChanges: true)
        .listen((blog) {
      this.blog = BlogModel.fromJson(blog.data()!);
      notifyListeners();
    });
    return blog;
  }

  List<TrackingModel> getAllTracking(String userId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tracking')
        .orderBy('dateTime', descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((tracking) {
      this.trackings = tracking.docs
          .map((doc) => TrackingModel.fromJson(doc.data()))
          .toList();
      notifyListeners();
    });
    return trackings;
  }

}
