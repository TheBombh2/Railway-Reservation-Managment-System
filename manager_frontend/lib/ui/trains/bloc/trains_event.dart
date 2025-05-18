part of 'trains_bloc.dart';

abstract class TrainsEvent {}

class LoadTrains extends TrainsEvent {
  LoadTrains();
}

class LoadTrainTypes extends TrainsEvent {
  LoadTrainTypes();
}

class LoadTrainCreation extends TrainsEvent {
  LoadTrainCreation();
}

class CreateTrain extends TrainsEvent {
  TrainCreate data;
  CreateTrain(this.data);
}

class CreateTrainType extends TrainsEvent {
  TrainType data;
  CreateTrainType(this.data);
}

class StartTrain extends TrainsEvent {
  String trainID;
  StartTrain(this.trainID);
}

class StopTrain extends TrainsEvent {
  String trainID;
  StopTrain(this.trainID);
}

class DeleteTrain extends TrainsEvent {
  String trainID;
  DeleteTrain(this.trainID);
}
