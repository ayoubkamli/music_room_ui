import 'package:myapp/auth/utils/MyValidator.dart';
import 'package:myapp/formStatus/form_submission_status.dart';

class EditPlaylistState {
  final String name;

  String? id;

  String? data;

  EditPlaylistState({
    this.name = '',
    this.description = '',
    this.visibilityStatus = 'public',
    this.selectedPrefList = const [],
    this.formStatus = const InitialFormStatus(),
    this.data,
    this.id,
  });

  bool get isNameValide => MyInputValidator().isEventNameValid(name);

  final String description;

  bool get isDescriptionValid =>
      MyInputValidator().isEventdescriptionValid(description);

  final String visibilityStatus;

  final List<String> selectedPrefList;

  bool get isPrefListValid =>
      MyInputValidator().isPrefListValid(selectedPrefList);

  final FormSubmissionStatus formStatus;

  EditPlaylistState copyWith({
    String? name,
    String? description,
    String? visibilityStatus,
    List<String>? selectedPrefList,
    FormSubmissionStatus? formStatus,
    String? data,
    String? id,
  }) {
    return EditPlaylistState(
      name: name ?? this.name,
      description: description ?? this.description,
      visibilityStatus: visibilityStatus ?? this.visibilityStatus,
      selectedPrefList: selectedPrefList ?? this.selectedPrefList,
      formStatus: formStatus ?? this.formStatus,
      data: data ?? this.data,
      id: id ?? this.id,
    );
  }
}
