import 'enums.dart';

class StatusEvent {
  String labId;
  RefreshType type;
  int status;
  int cid;

  StatusEvent(this.labId,this.type, this.status, {this.cid});
}
