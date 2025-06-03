class UserDto {
  final String id;
  final String userName;
  final String email;

  UserDto({
    required this.id,
    required this.userName,
    required this.email
});
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
        id: json['id'],
        userName: json['userName'],
        email: json['email']
    );
      }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email
    };
  }
  @override
  String toString() {
    return 'UserDto{id: $id, userName: $userName, email: $email}';
  }
}