import 'package:flutter/material.dart';

import '../../../core/base/mixins/viewmodel.mixin.dart';
import 'loading.viewmodel.dart';

class CircularLoadingWidget extends StatelessWidget
    with ViewModelMixin<LoadingViewModel> {
  const CircularLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: viewModel.isLoadingStream,
      builder: (_, loadingSnap) {
        if (loadingSnap.hasData && loadingSnap.data!) {
          return PopScope(
            canPop: false,
            child: Stack(
              children: <Widget>[
                ModalBarrier(
                  dismissible: false,
                  color: Colors.grey.withOpacity(.3),
                ),
                const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.grey),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
