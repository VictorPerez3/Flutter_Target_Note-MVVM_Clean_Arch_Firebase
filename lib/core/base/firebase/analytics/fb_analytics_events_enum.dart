enum AnalyticsEventsEnum {
  //AUTH
  click('click'),
  login('login'),
  createUser('create_user'),

  //NOTE
  logout('logout'),
  listToDetail('detail_to_note'),
  detailToList('detail_to_list'),
  saveNote('save_note'),
  editNote('edit_note'),
  deleteNote('delete_note'),
  toggleBottomSheet('toggle_bottom_sheet'),
  changeTextAlignNoteText('change_text_align_note_text'),
  changeBackgroundColorNote('change_background_color_note');

  final String value;

  const AnalyticsEventsEnum(this.value);
}
