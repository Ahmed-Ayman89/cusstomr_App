import '../models/space_model.dart';

abstract class SpaceRepository {
  Future<List<SpaceModel>> getSpaces();
  Future<SpaceModel> getSpaceById(String id);
  Future<void> createSpace(SpaceModel space);
  Future<void> updateSpace(SpaceModel space);
  Future<void> deleteSpace(String id);
  Future<void> setGoal(String spaceId, double goalAmount);
}

class SpaceRepositoryImpl implements SpaceRepository {
  // Mock data for demonstration
  final List<SpaceModel> _mockSpaces = [
    SpaceModel(
      id: '1',
      name: 'Goal',
      iconAsset: 'assets/onboarding/rafiki.svg',
      currentAmount: 1500.0,
      goalAmount: null,
      color: '#008751',
      hasGoal: false,
    ),
    SpaceModel(
      id: '2',
      name: 'Plan and Save',
      iconAsset: 'assets/onboarding/pana.svg',
      currentAmount: 2500.0,
      goalAmount: 5000.0,
      color: '#008751',
      hasGoal: true,
    ),
  ];

  @override
  Future<List<SpaceModel>> getSpaces() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockSpaces;
  }

  @override
  Future<SpaceModel> getSpaceById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockSpaces.firstWhere((space) => space.id == id);
  }

  @override
  Future<void> createSpace(SpaceModel space) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockSpaces.add(space);
  }

  @override
  Future<void> updateSpace(SpaceModel space) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockSpaces.indexWhere((s) => s.id == space.id);
    if (index != -1) {
      _mockSpaces[index] = space;
    }
  }

  @override
  Future<void> deleteSpace(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockSpaces.removeWhere((space) => space.id == id);
  }

  @override
  Future<void> setGoal(String spaceId, double goalAmount) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockSpaces.indexWhere((s) => s.id == spaceId);
    if (index != -1) {
      _mockSpaces[index] = _mockSpaces[index].copyWith(
        goalAmount: goalAmount,
        hasGoal: true,
      );
    }
  }
}
