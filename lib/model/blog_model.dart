class BlogModel {
  int? id;
  String? title;
  String? subtitle;
  String? image;
  String? description;
  int? isFavorite;
  String? createdAt;
  String? updatedAt;

  BlogModel(
      {this.id,
        this.title,
        this.subtitle,
        this.image,
        this.description,
        this.isFavorite,
        this.createdAt,
        this.updatedAt});

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    image = json['image'];
    description = json['description'];
    isFavorite = json['is_favorite'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['image'] = this.image;
    data['description'] = this.description;
    data['is_favorite'] = this.isFavorite;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
