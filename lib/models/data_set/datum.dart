import 'package:equatable/equatable.dart';

import 'device.dart';

class RoomsNeed extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final List<Device>? devices;

  const RoomsNeed({this.id, this.title, this.description, this.devices});

  factory RoomsNeed.fromJson(Map<String, dynamic> json) => RoomsNeed(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        devices: (json['devices'] as List<dynamic>?)
            ?.map((e) => Device.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'devices': devices?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [id, title, description, devices];
}
