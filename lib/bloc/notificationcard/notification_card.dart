
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:himpunan_app/core/models/notification_card_model.dart';

class NotificationCubit extends Cubit<List<NotificationModel>> {
  NotificationCubit() : super([]);

  void loadNotifications() {
    emit([
      NotificationModel(
        id: 1,
        title: "New Comment",
        description: "Divya commented on your post: 'Good work! Keep it going and stay motivated.'",
        sender: "Divya",
        date: "2 mins ago",
      ),
      NotificationModel(
        id: 2,
        title: "Post Liked",
        description: "Guillaume liked your post: 'Tips to grow as a product designer'",
        sender: "Guillaume",
        date: "15 mins ago",
      ),
      NotificationModel(
        id: 3,
        title: "Followed You",
        description: "Afisa has followed you. Check out her profile now!",
        sender: "Afisa",
        date: "1 hour ago",
      ),
      NotificationModel(
        id: 4,
        title: "Liked Your Post",
        description: "Anupam liked your post about 'Overthinking and its dangerous effects'",
        sender: "Anupam",
        date: "3 hours ago",
      ),
    ]);
  }
}
