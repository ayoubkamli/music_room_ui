import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/auth/utils/MyValidator.dart';

class EditEventState {
  final String name;

  String? id;

  String? data;

  bool get isEventNameValid => MyInputValidator().isEventNameValid(name);

  final String description;
  bool get isEventDescriptionValid =>
      MyInputValidator().isEventdescriptionValid(description);

  final String eventStatus;

  final List<String> selectedPrefList;
  bool get isPrefListValid =>
      MyInputValidator().isPrefListValid(selectedPrefList);

  final FormSubmissionStatus formStatus;

  EditEventState(
      {this.name = '',
      this.description = '',
      this.selectedPrefList = const [],
      this.eventStatus = 'public',
      this.formStatus = const InitialFormStatus(),
      this.data,
      this.id});

  EditEventState copyWith({
    String? name,
    String? description,
    String? eventStatus,
    List<String>? selectedPrefList,
    FormSubmissionStatus? formStatus,
    String? data,
    String? id,
  }) {
    return EditEventState(
      name: name ?? this.name,
      description: description ?? this.description,
      selectedPrefList: selectedPrefList ?? this.selectedPrefList,
      eventStatus: eventStatus ?? this.eventStatus,
      formStatus: formStatus ?? this.formStatus,
      data: data ?? this.data,
      id: id ?? this.id,
    );
  }
}
