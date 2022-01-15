// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/models/dialog_type.dart';
import 'package:unuber_mobile/ui/widgets/organisms/dialogs/single_message_dialog.dart';

void setupDialogUI() {
  final _dialogService = locator<DialogService>();

  final builders = {
    DialogType.SingleMessage: (context, sheetRequest, completer) => Dialog(
        child: _customDialogUI(request: sheetRequest, completer: completer))
  };

  _dialogService.registerCustomDialogBuilders(builders);
}

Widget _customDialogUI(
    {required DialogRequest request,
    required Function(DialogResponse) completer}) {
  var dialogType = request.variant as DialogType;

  switch (dialogType) {
    case DialogType.SingleMessage:
      return SingleMessageDialog(request: request, completer: completer);
    default:
      return SingleMessageDialog(request: request, completer: completer);
  }
}
