enum AnalyticsEventsEnum {

  //AUTH
  click('click'),
  login('login'),
  createUser('create_user'),

  //NOTE
  logout('logout'),
  saveNote('save_note'),
  editNote('edit_note'),
  deleteNote('delete_note');

  final String value;

  const AnalyticsEventsEnum(this.value);
}