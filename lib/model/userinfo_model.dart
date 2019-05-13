
class UserInfo {
  String userId;
  int spaceUserId;
  int blogId;
  String displayName;
  String face;
  String avatar;
  String seniority;
  String blogApp;

 UserInfo.fromJson(Map data) {
    userId = data['UserId'];
    spaceUserId = data['SpaceUserId'];
    blogId = data['BlogId'];
    displayName = data['DisplayName'];
    face = data['Face'];
    avatar = data['Avatar'];
    seniority = data['Seniority'];
    blogApp = data['BlogApp'];
  }
}
