class Data_Android {
  String? id;
  String? versiAndroid;
  String? packagename;
  String? keterangan;
  String? selesai;

  Data_Android(
      {this.id,
      this.versiAndroid,
      this.packagename,
      this.keterangan,
      this.selesai});

  Data_Android.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    versiAndroid = json['versi_android'];
    packagename = json['packagename'];
    keterangan = json['keterangan'];
    selesai = json['selesai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['versi_android'] = this.versiAndroid;
    data['packagename'] = this.packagename;
    data['keterangan'] = this.keterangan;
    data['selesai'] = this.selesai;
    return data;
  }
}
