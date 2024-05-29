import 'package:firebase_database/firebase_database.dart';

class KisilerDaoRepository{
  var ref = FirebaseDatabase.instance.ref().child("kisiler");


  Future<void> kayit(String kad, String kno) async{
    var bilgi = <String,dynamic>{};
    bilgi["kisi_id"] = "";
    bilgi["kisi_ad"] = kad;
    bilgi["kisi_tel"] = kno;
    ref.push().set(bilgi);
  }

  Future<void> guncelle(String kid,String kad, String kno) async{
    var bilgi = <String,dynamic>{};
    bilgi["kisi_ad"] = kad;
    bilgi["kisi_tel"] = kno;
    ref.child(kid).update(bilgi);
  }

  Future<void> sil(String kid) async{
    ref.child(kid).remove();
  }


}