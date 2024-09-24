import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/base/mixins/analytics_mixin.dart';
import '../../../../core/resources/note/domain/constants/note_screen_constants.dart';
import '../../../note/details/presentation/note_details_viewmodel.dart';
import '../../../note/details/presentation/tag/note_details_tag.dart';

class BottomSheetWidget extends StatelessWidget
    with AnalyticsMixin<NoteDetailsTag> {
  final NoteDetailsViewModel viewModel;
  final bool isKeyboardVisible;

  const BottomSheetWidget({
    super.key,
    required this.viewModel,
    required this.isKeyboardVisible,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.isBottomSheetMinimized,
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
                    viewModel.toggleBottomSheet();
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
                        _buildColorCircle(const Color(0xFFE4E4E4)),
                        _buildColorCircle(const Color(0xFF1C1B1F)),
                        _buildColorCircle(const Color(0xFFD0BCFF)),
                        _buildColorCircle(const Color(0xFF5EB763)),
                        _buildColorCircle(const Color(0xFFD75550)),
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
                        _buildAlignmentIcon(
                            'assets/icons/format-align-left-icon.svg',
                            TextAlign.left),
                        _buildAlignmentIcon(
                            'assets/icons/format-align-justify-icon.svg',
                            TextAlign.center),
                        _buildAlignmentIcon(
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

  Widget _buildColorCircle(Color color) {
    return ValueListenableBuilder<Color>(
      valueListenable: viewModel.selectedColor,
      builder: (context, selectedColor, child) {
        return InkWell(
          onTap: () {
            tag.onChangeBackgroundColorNoteEvent(
                'Change Background Color Note');
            viewModel.changeBackgroundColor(color);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: selectedColor == color ? Colors.blue : Colors.grey,
                width: selectedColor == color ? 2.0 : 1.0,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAlignmentIcon(String assetPath, TextAlign align) {
    return ValueListenableBuilder<TextAlign>(
      valueListenable: viewModel.selectedTextAlign,
      builder: (context, selectedAlign, child) {
        return InkWell(
          onTap: () {
            tag.onChangeTextAlignNoteTextEvent('Change Note Text Align');
            viewModel.changeTextAlign(align);
          },
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    selectedAlign == align ? Colors.blue : Colors.transparent,
                width: selectedAlign == align ? 2.0 : 0,
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
