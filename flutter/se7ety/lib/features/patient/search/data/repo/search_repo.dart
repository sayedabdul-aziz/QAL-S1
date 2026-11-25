import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';

class SearchRepo {
  Future<List<DoctorModel>> searchDoctors(String query) async {
    final snapshot = await FirestoreProvider.doctors
        .where('specialization', isNull: false)
        .orderBy('name')
        .startAt([query])
        .endAt(['$query\uf8ff'])
        .get();

    return snapshot.docs
        .map((doc) => DoctorModel.fromJson(doc.data()))
        .toList();
  }
}
