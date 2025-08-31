// PImpl イディオム（実装非公開）
class Widget {
public:
  Widget();
  ~Widget();
  void doWork();

private:
  struct Impl;
  std::unique_ptr<Impl> pImpl;
};

// widget.cpp
struct Widget::Impl {
  void doWorkImpl() {
    std::cout << "Working..." << std::endl;
  }
};
Widget::Widget() : pImpl(std::make_unique<Impl>()) {}
Widget::~Widget() = default;
void Widget::doWork() { pImpl->doWorkImpl(); }
