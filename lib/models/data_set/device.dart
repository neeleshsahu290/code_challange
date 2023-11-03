import 'package:equatable/equatable.dart';

class Device extends Equatable {
  final String? type;
  final String? device;
  final int? state;
  final String? displayName;

  const Device({this.type, this.device, this.state, this.displayName});

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        type: json['type'] as String?,
        device: json['device'] as String?,
        state: json['state'] as int?,
        displayName: json['display_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'device': device,
        'state': state,
        'display_name': displayName,
      };

  @override
  List<Object?> get props => [type, device, state, displayName];
}
