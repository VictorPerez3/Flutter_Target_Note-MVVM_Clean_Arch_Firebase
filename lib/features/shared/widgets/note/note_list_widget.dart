import 'package:flutter/material.dart';
import '../../../../core/base/mixins/l18n_mixin.dart';
import '../../../../core/base/utils/date_time_util.dart';
import '../../../../core/resources/note/domain/constants/note_types_and_hide_constants.dart';
import '../../../../core/resources/note/domain/entities/note_entity.dart';

class NoteList extends StatelessWidget with l18nMixin {
  final List<Note> notes;

  final String noteTypeMode;

  final Function({Note? note, required BuildContext context}) goNoteDetails;
  final void Function(Note note, Offset globalPosition, Size size) onShowMenu;
  final List<List<Note>> Function(List<Note> notes, int numColumns)
      getNotesInColumns;
  final String Function(Note note) getDisplayTextByNoteType;
  final Offset Function({
    required Offset itemOffset,
    required Size itemSize,
    required double screenHeight,
  }) calculateMenuPosition;

  const NoteList({
    super.key,
    required this.notes,
    required this.goNoteDetails,
    required this.onShowMenu,
    required this.getNotesInColumns,
    required this.getDisplayTextByNoteType,
    required this.calculateMenuPosition,
    required this.noteTypeMode,
  });

  String convertNoteTypeLabel({required String noteType}) {
    switch (noteType) {
      case NoteTypesAndHideConstants.generalNotes:
        return l18n.strings.notePage.generalNotesDetailsLabel;
      case NoteTypesAndHideConstants.personalAccounts:
        return l18n.strings.notePage.personalAccountsDetailsLabel;
      case NoteTypesAndHideConstants.bankNotes:
        return l18n.strings.notePage.bankNotesDetailsLabel;
      default:
        return l18n.strings.notePage.generalNotesDetailsLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    const int numColumns = 2;

    final columns = getNotesInColumns(notes, numColumns);

    List<Widget> columnWidgets = [];

    for (int colIndex = 0; colIndex < numColumns; colIndex++) {
      if (colIndex > 0) {
        columnWidgets.add(const SizedBox(width: 12));
      }

      columnWidgets.add(
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columns[colIndex].map((note) {
              final formattedDate =
                  DateTimeUtil.formatDateNoteMenu(note.updatedAt);

              return LayoutBuilder(
                builder: (context, constraints) {
                  return GestureDetector(
                    onTap: () {
                      goNoteDetails(note: note, context: context);
                    },
                    onLongPress: () {
                      final renderBox = context.findRenderObject() as RenderBox;
                      final itemOffset = renderBox.localToGlobal(Offset.zero);
                      final renderBoxSize = renderBox.size;

                      final screenHeight = MediaQuery.of(context).size.height;

                      final menuPosition = calculateMenuPosition(
                        itemOffset: itemOffset,
                        itemSize: renderBoxSize,
                        screenHeight: screenHeight,
                      );

                      onShowMenu(note, menuPosition, renderBoxSize);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: note.backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            note.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Color(0xFF292322),
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            getDisplayTextByNoteType(note),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Color(0xFF292322),
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              formattedDate,
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                color: Color(0xFF79747E),
                                fontFamily: 'Roboto',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          if (noteTypeMode ==
                              NoteTypesAndHideConstants.hiddenNotes) ...[
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                convertNoteTypeLabel(noteType: note.noteType),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  color: Color(0xFF79747E),
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnWidgets,
      ),
    );
  }
}
