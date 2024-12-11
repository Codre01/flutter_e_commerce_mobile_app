import 'dart:convert';

JwtTokenModel jwtTokenModelFromJson(String str) => JwtTokenModel.fromJson(json.decode(str));

String jwtTokenModelToJson(JwtTokenModel data) => json.encode(data.toJson());

class JwtTokenModel {
    final String refresh;
    final String access;

    JwtTokenModel({
        required this.refresh,
        required this.access,
    });

    factory JwtTokenModel.fromJson(Map<String, dynamic> json) => JwtTokenModel(
        refresh: json["refresh"],
        access: json["access"],
    );

    Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
    };
}
