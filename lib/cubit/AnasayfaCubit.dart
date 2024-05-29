import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kisiler_bloc_firebase/entity/Kisiler.dart';
import 'package:flutter_kisiler_bloc_firebase/repo/KisilerDao_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class AnasayfaCubit extends Cubit<List<Kisiler>> {
  AnasayfaCubit():super(<Kisiler>[]);

  var kRepo = KisilerDaoRepository();
  var ref = FirebaseDatabase.instance.ref().child("kisiler");

  Future<void> kisileriYukle() async{
    ref.onValue.listen((event) {
      var gelenDeger = event.snapshot.value as dynamic;
      if(gelenDeger != null){
        var liste = <Kisiler>[];
        gelenDeger.forEach((key, nesne){
          var kisi = Kisiler.fromJson(key, nesne);
          liste.add(kisi);
        });
        emit(liste);
      }
    });
  }

  Future<void> kisiAra(String arama) async{
    ref.onValue.listen((event) {
      var gelenDeger = event.snapshot.value as dynamic;
      if(gelenDeger != null){
        var liste = <Kisiler>[];
        gelenDeger.forEach((key, nesne){
          var kisi = Kisiler.fromJson(key, nesne);
          if(kisi.kisi_ad.contains(arama)) {
            liste.add(kisi);
          }
        });
        emit(liste);
      }
    });
  }

  Future<void> sil(String kid) async{
    await kRepo.sil(kid);
  }
}