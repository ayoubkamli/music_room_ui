import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/events/events/create_event_event.dart';
import 'package:myapp/events/repositories/create_event_state.dart';
import 'package:myapp/events/blocs/event_cubit.dart';
import 'package:myapp/events/repositories/event_repository.dart';
import 'package:myapp/formStatus/form_submission_status.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final EventRepository repository;
  final EventCubit eventCubit;

  CreateEventBloc(this.repository, this.eventCubit) : super(CreateEventState());

  @override
  Stream<CreateEventState> mapEventToState(CreateEventEvent event) async* {
    if (event is CreateEventNameChanged) {
      yield state.copyWith(name: event.name);
    } else if (event is CreateEventDescriptionChanged) {
      yield state.copyWith(description: event.description);
    } else if (event is CreateEventStatusChanged) {
      yield state.copyWith(eventStatus: event.status);
    } else if (event is CreateEventPrefChanged) {
      yield state.copyWith(selectedPrefList: event.prefs);
    } else if (event is CreateEventSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        final response = await repository.createEvent(
          state.name,
          state.description,
          state.selectedPrefList,
          state.eventStatus,
        );
        if (response.statusCode == 200) {
          print(response);
          state.copyWith(
            name: '',
            description: '',
            selectedPrefList: [],
            eventStatus: '',
          );
          yield state.copyWith(formStatus: SubmissionSuccess());
          yield state.copyWith(formStatus: InitialFormStatus());
        } else {
          throw Exception();
        }

        print('respnose 00000000 ==== ${response.statusCode}');
      } catch (e) {
        yield state.copyWith(
            formStatus: SubmissionFailed('Some things went wrong'));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
