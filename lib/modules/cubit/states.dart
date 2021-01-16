abstract class CounterStates{}
class CounterIntial extends CounterStates{}
class CounterLoading extends CounterStates{}
class CounterSuccess extends CounterStates{}
class CounterError extends CounterStates{
  final error;
  CounterError(this.error);
}