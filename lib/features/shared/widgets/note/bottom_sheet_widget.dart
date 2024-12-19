import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/base/mixins/analytics_mixin.dart';
import '../../../../core/resources/note/domain/constants/note_screen_constants.dart';
import '../../../note/details/presentation/tag/note_details_tag.dart';

class BottomSheetWidget extends StatelessWidget
    with AnalyticsMixin<NoteDetailsTag> {
  final bool isKeyboardVisible;

  final ValueListenable<bool> isBottomSheetMinimized;
  final VoidCallback onToggleBottomSheet;

  final ValueListenable<Color> selectedColor;
  final Function(Color) onChangeBackgroundColor;

  final ValueListenable<TextAlign> selectedTextAlign;
  final Function(TextAlign) onChangeTextAlign;

  const BottomSheetWidget({
    super.key,
    required this.isKeyboardVisible,
    required this.isBottomSheetMinimized,
    required this.onToggleBottomSheet,
    required this.selectedColor,
    required this.onChangeBackgroundColor,
    required this.selectedTextAlign,
    required this.onChangeTextAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isBottomSheetMinimized,
      builder: (context, isMinimized, child) {
        return Container(
          decoration: const ShapeDecoration(
            color: Color(0xFF25232A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GestureDetector(
                  onTap: () {
                    tag.onToggleBottomSheetEvent('Toggle Bottom Sheet');
                    onToggleBottomSheet();
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: double.infinity,
                    height: 20.0,
                    alignment: Alignment.center,
                    child: Container(
                      width: 40,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: isMinimized ? 0.0 : 12.0),
              if (!isMinimized)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: ShapeDecoration(
                      color: const Color(0x14D0BCFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          NoteScreenConstants.backgroundLabel,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        _buttonColorCircle(const Color(0xFFFEA289)),
                        _buttonColorCircle(const Color(0xFFFFC57B)),
                        _buttonColorCircle(const Color(0xFFE2EB97)),
                        _buttonColorCircle(const Color(0xFF76D9E5)),
                        _buttonColorCircle(const Color(0xFFC888CF)),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 8.0),
              if (!isMinimized)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: ShapeDecoration(
                      color: const Color(0x14D0BCFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buttonAlignmentIcon(
                            'assets/icons/format-align-left-icon.svg',
                            TextAlign.left),
                        _buttonAlignmentIcon(
                            'assets/icons/format-align-justify-icon.svg',
                            TextAlign.center),
                        _buttonAlignmentIcon(
                            'assets/icons/format-align-right-icon.svg',
                            TextAlign.right),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: isMinimized ? 0.0 : 16.0),
            ],
          ),
        );
      },
    );
  }

  Widget _buttonColorCircle(Color color) {
    return ValueListenableBuilder<Color>(
      valueListenable: selectedColor,
      builder: (context, currentSelectedColor, child) {
        return Material(
          elevation: 4.0,
          shape: const CircleBorder(),
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              tag.onChangeBackgroundColorNoteEvent(
                  'Change Background Color Note');
              onChangeBackgroundColor(color);
            },
            customBorder: const CircleBorder(),
            splashColor: Colors.white12,
            highlightColor: Colors.white10,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      currentSelectedColor == color ? Colors.blue : Colors.grey,
                  width: currentSelectedColor == color ? 2.0 : 1.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buttonAlignmentIcon(String assetPath, TextAlign align) {
    return ValueListenableBuilder<TextAlign>(
      valueListenable: selectedTextAlign,
      builder: (context, currentSelectedAlign, child) {
        return InkWell(
          onTap: () {
            tag.onChangeTextAlignNoteTextEvent('Change Note Text Align');
            onChangeTextAlign(align);
          },
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: currentSelectedAlign == align
                    ? Colors.blue
                    : Colors.transparent,
                width: currentSelectedAlign == align ? 2.0 : 0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: SvgPicture.asset(
              assetPath,
              width: 24,
              height: 24,
            ),
          ),
        );
      },
    );
  }
}
