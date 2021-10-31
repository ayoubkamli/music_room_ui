import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/events/events/edit_event_event.dart';
import 'package:myapp/events/logic/edite_event_state.dart';
import 'package:myapp/events/models/upload_photo_model.dart';
import 'package:myapp/events/logic/event_cubit.dart';
import 'package:myapp/events/repositories/event_repository.dart';
import 'package:myapp/formStatus/form_submission_status.dart';

class EditEventBloc extends Bloc<EditEventEvent, EditEventState> {
  final EventRepository repository;
  final EventCubit eventCubit;

  EditEventBloc(this.repository, this.eventCubit)
      : super(EditEventState(id: '61758b98cd0ddc001fd5ae37'));

  @override
  Stream<EditEventState> mapEventToState(EditEventEvent event) async* {
    if (event is EditEventIdChanged) {
      yield state.copyWith(id: event.id);
    }
    if (event is EditEventNameChanged) {
      yield state.copyWith(name: event.name);
    } else if (event is EditEventDescriptionChanged) {
      yield state.copyWith(description: event.description);
    } else if (event is EditEventStatusChanged) {
      yield state.copyWith(eventStatus: event.status);
    } else if (event is EditEventPrefChanged) {
      yield state.copyWith(selectedPrefList: event.prefs);
    } else if (event is EditEventSubmitted) {
      print('Edit event submmited from Edit event bloc.');
      yield state.copyWith(formStatus: FormSubmitting());
      print('Edit event formStatus: FormSubmitting()from Edit event bloc.');
      try {
        final response = await repository.editEvent(
          state.name,
          state.description,
          state.selectedPrefList,
          state.eventStatus,
          state.id,
        );
        print('look at this edit event ************ +${response.statusCode}');
        print('look at this edit event ************ +${response.body}');
        if (response.statusCode == 200) {
          // emit(EditEventUploadphoto(eventId));
          // state.copyWith(
          //   name: '',
          //   description: '',
          //   selectedPrefList: [],
          //   eventStatus: '',
          // );
          EditEventUploadphoto(jsonDecode(response.body).toString());
          yield state.copyWith(
              data: UploadPhotoModel.fromJson(jsonDecode(response.body)));
          print('response from state ${state.data}');
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
