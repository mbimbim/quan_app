class Model_DetailSurah {
  int? id;
  int? surah;
  int? nomor;
  String? ar;
  String? tr;
  String? idn;

  Model_DetailSurah(
      {this.id, this.surah, this.nomor, this.ar, this.tr, this.idn});

  Model_DetailSurah.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surah = json['surah'];
    nomor = json['nomor'];
    ar = json['ar'];
    tr = json['tr'];
    idn = json['idn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['surah'] = this.surah;
    data['nomor'] = this.nomor;
    data['ar'] = this.ar;
    data['tr'] = this.tr;
    data['idn'] = this.idn;
    return data;
  }
}
