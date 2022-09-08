class ListUtilsService {
  static bool haveDifferentElements<T>(List<T> a, List<T> b) {
    Set<T> setA = a.toSet();
    Set<T> setB = b.toSet();
    return setA.union(setB).difference(setA.intersection(setB)).isNotEmpty;
  }
}
