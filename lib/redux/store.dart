import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:seers_assignment2/redux/models/app_state.dart';
import 'package:seers_assignment2/redux/reducers/app_reducer.dart';

Store<AppState> createStore() {
  return Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: [thunkMiddleware],
  );
}
