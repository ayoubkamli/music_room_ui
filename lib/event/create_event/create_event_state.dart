import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/validation/MyValidator.dart';

class CreateEventState {
  final String name;
  bool get isEventNameValid => MyInputValidator().isEventNameValid(name);

  final String description;
  bool get isEventDescriptionValid =>
      MyInputValidator().isEventdescriptionValid(description);
  final String eventStatus;

  final List<String> selectedPrefList;
  bool get isPrefListValid =>
      MyInputValidator().isPrefListValid(selectedPrefList);

  final FormSubmissionStatus formStatus;

  CreateEventState({
    this.name = '',
    this.description = '',
    this.selectedPrefList = const [],
    this.eventStatus = '',
    this.formStatus = const InitialFormStatus(),
  });

  CreateEventState copyWith({
    String? name,
    String? description,
    String? eventStatus,
    List<String>? selectedPrefList,
    FormSubmissionStatus? formStatus,
  }) {
    return CreateEventState(
        name: name ?? this.name,
        description: description ?? this.description,
        selectedPrefList: selectedPrefList ?? this.selectedPrefList,
        eventStatus: eventStatus ?? this.eventStatus,
        formStatus: formStatus ?? this.formStatus);
  }
}
