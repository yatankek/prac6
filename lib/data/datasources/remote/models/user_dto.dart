class UserDto {
  final NameDto name;
  final String email;
  final PictureDto picture;

  UserDto({
    required this.name,
    required this.email,
    required this.picture,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      name: NameDto.fromJson(json['name']),
      email: json['email'],
      picture: PictureDto.fromJson(json['picture']),
    );
  }
}

class NameDto {
  final String first;
  final String last;

  NameDto({required this.first, required this.last});

  factory NameDto.fromJson(Map<String, dynamic> json) {
    return NameDto(
      first: json['first'],
      last: json['last'],
    );
  }
}

class PictureDto {
  final String large;
  final String medium;
  final String thumbnail;

  PictureDto({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  factory PictureDto.fromJson(Map<String, dynamic> json) {
    return PictureDto(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}
