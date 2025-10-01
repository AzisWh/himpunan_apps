import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/departemen_model.dart';

class DepartemenState {
  final List<Departemen> departemens;
  final bool loading;

  DepartemenState({required this.departemens, this.loading = false});

  DepartemenState copyWith({List<Departemen>? departemens, bool? loading}) {
    return DepartemenState(
      departemens: departemens ?? this.departemens,
      loading: loading ?? this.loading,
    );
  }
}

class DepartemenCubit extends Cubit<DepartemenState> {
  DepartemenCubit() : super(DepartemenState(departemens: []));

  void loadDepartemen() {
    emit(state.copyWith(loading: true));

    final dummyData = [
      Departemen(
        nama: "Departemen IPTEK",
        prokers: [
          Proker(
            nama: "Workshop Flutter",
            ketua: "Andi",
            tanggal: "12/10/2025",
            status: "next",
            progress: [
              "Koordinasi dengan pemateri",
              "Booking ruangan",
              "Persiapan modul",
            ],
          ),
          Proker(
            nama: "Pelatihan AI",
            ketua: "Budi",
            tanggal: "20/10/2025",
            status: "ongoing",
          ),
          Proker(
            nama: "Lomba Hackathon",
            ketua: "Citra",
            tanggal: "01/09/2025",
            status: "done",
          ),
        ],
      ),
      Departemen(
        nama: "Departemen Dana Usaha",
        prokers: [
          Proker(
            nama: "Bazar Makanan",
            ketua: "Dewi",
            tanggal: "15/11/2025",
            status: "next",
            progress: [
              "Koordinasi dengan pemateri",
              "Booking ruangan",
              "Persiapan modul",
            ],
          ),
          Proker(
            nama: "Jualan Merchandise",
            ketua: "Eko",
            tanggal: "25/09/2025",
            status: "done",
          ),
        ],
      ),
      Departemen(
        nama: "Departemen Medinco",
        prokers: [
          Proker(
            nama: "Publikasi Event",
            ketua: "Fajar",
            tanggal: "30/09/2025",
            status: "ongoing",
          ),
        ],
      ),
      Departemen(
        nama: "Departemen Internal",
        prokers: [
          Proker(
            nama: "Makrab",
            ketua: "Gilang",
            tanggal: "05/12/2025",
            status: "next",
            progress: [
              "Koordinasi dengan pemateri",
              "Booking ruangan",
              "Persiapan modul",
            ],
          ),
        ],
      ),
      Departemen(
        nama: "Departemen Eksternal",
        prokers: [
          Proker(
            nama: "Kerjasama Kampus",
            ketua: "Hana",
            tanggal: "18/10/2025",
            status: "ongoing",
          ),
          Proker(
            nama: "Lomba Antar Himpunan",
            ketua: "Iqbal",
            tanggal: "01/08/2025",
            status: "done",
          ),
        ],
      ),
      Departemen(nama: "Departemen Medinco", prokers: []),
      Departemen(nama: "Departemen Internal", prokers: []),
      Departemen(nama: "Departemen Eksternal", prokers: []),
    ];

    emit(DepartemenState(departemens: dummyData, loading: false));
  }
}
