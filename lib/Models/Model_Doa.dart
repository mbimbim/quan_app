class Model_Doa {
  int? id;
  String? grup;
  String? nama;
  String? ar;
  String? tr;
  String? idn;
  String? tentang;
  String? mood;
  String? tag;

  Model_Doa(
      {this.id,
      this.grup,
      this.nama,
      this.ar,
      this.tr,
      this.idn,
      this.tentang,
      this.mood,
      this.tag});

  Model_Doa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grup = json['grup'];
    nama = json['nama'];
    ar = json['ar'];
    tr = json['tr'];
    idn = json['idn'];
    tentang = json['tentang'];
    mood = json['mood'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['grup'] = this.grup;
    data['nama'] = this.nama;
    data['ar'] = this.ar;
    data['tr'] = this.tr;
    data['idn'] = this.idn;
    data['tentang'] = this.tentang;
    data['mood'] = this.mood;
    data['tag'] = this.tag;
    return data;
  }
}
