// モダンC++ループ構文
std::vector<int> v = {1,2,3,4,5};
for (int x : v) {
  std::cout << x << "\n";
}
// 範囲ベース + auto
for (auto& x : v) {
  x *= 2;
}
