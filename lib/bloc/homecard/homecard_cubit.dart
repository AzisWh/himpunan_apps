import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/home_card_model.dart';

class HomecardCubit extends Cubit<List<HomeCardModel>> {
  HomecardCubit() : super([]);

  void loadServices() {
    emit([
      HomeCardModel(
        id: 1,
        title: "Epilog",
        description: "Berita Acara Epilog",
        detail:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse non urna eget nisl consequat aliquet. Fusce ut ex quis sapien pharetra lacinia. Duis quis odio ut velit blandit aliquam. ",
        image: "image/berita.png",
        url: "",
      ),
      HomeCardModel(
        id: 2,
        title: "HUT RI 80",
        description: "Dirgahayu Republik",
        detail:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                "Suspendisse non urna eget nisl consequat aliquet. "
                "Fusce ut ex quis sapien pharetra lacinia. "
                "Duis quis odio ut velit blandit aliquam. " *
            3,
        image: "image/berita-2.png",
        url: "",
      ),
      HomeCardModel(
        id: 3,
        title: "Hi-Technology 2025",
        description: "Berita Acara Hi-Tech 2025",
        detail:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
            "Suspendisse non urna eget nisl consequat aliquet. "
            "Fusce ut ex quis sapien pharetra lacinia. "
            "Duis quis odio ut velit blandit aliquam. ",
        image: "image/berita-3.png",
        url: "",
      ),
      HomeCardModel(
        id: 4,
        title: "PAA",
        description: "Open Recrutment AA",
        detail:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                "Suspendisse non urna eget nisl consequat aliquet. "
                "Fusce ut ex quis sapien pharetra lacinia. "
                "Duis quis odio ut velit blandit aliquam. " *
            5,
        image: "image/berita-4.png",
        url: "",
      ),
    ]);
  }
}
