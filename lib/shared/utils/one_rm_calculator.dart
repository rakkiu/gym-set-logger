class OneRMCalculator {
  static double calculateEpley(double weight, int reps) {
    if (reps == 1) return weight;
    return weight * (1 + reps / 30);
  }

  static double calculateBrzycki(double weight, int reps) {
    if (reps == 1) return weight;
    return weight * (36 / (37 - reps));
  }

  static double estimate1RM(double weight, int reps) {
    return calculateEpley(weight, reps);
  }

  static double intensity(double weight, double estimated1RM) {
    if (estimated1RM <= 0) return 0;
    return (weight / estimated1RM).clamp(0.0, 1.0);
  }

  static int suggestRestTime({
    required String exerciseType,
    required int setNumber,
    required double weight,
    required int reps,
  }) {
    final estimated1RM = calculateEpley(weight, reps);
    final intensityValue = intensity(weight, estimated1RM);

    int base = exerciseType == 'compound' ? 120 : 60;

    if (intensityValue > 0.85) {
      base += 60;
    } else if (intensityValue > 0.70) {
      base += 30;
    }

    base += (setNumber - 1) * 10;

    return base.clamp(30, 300);
  }
}
