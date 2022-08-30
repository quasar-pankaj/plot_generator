enum GeneratorEvents { load, generate, lead_in, carry_on }

abstract class GeneratorEvent {}

class AppLoaded extends GeneratorEvent {}

class GenerateSkeletonRequested extends GeneratorEvent {}

class GenerateLeadInRequested extends GeneratorEvent {}

class GenerateCarryOnRequested extends GeneratorEvent {}
