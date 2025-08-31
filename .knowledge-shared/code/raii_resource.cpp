// RAII の基本パターン（ファイルリソース管理）
struct File {
  FILE* f;
  explicit File(const char* path, const char* mode)
      : f(std::fopen(path, mode)) {
    if (!f) throw std::runtime_error("open failed");
  }
  ~File() { if (f) std::fclose(f); }

  File(const File&) = delete;
  File& operator=(const File&) = delete;
};
