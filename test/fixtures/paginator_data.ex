defmodule PaginatorData do
  def page_list() do
    [
      {"First", 1, "/products?category=25&page=1", false},
      {"<", 6, "/products?category=25&page=6", false},
      {2, 2, "/products?category=25&page=2", false},
      {3, 3, "/products?category=25&page=3", false},
      {4, 4, "/products?category=25&page=4", false},
      {5, 5, "/products?category=25&page=5", false},
      {6, 6, "/products?category=25&page=6", false},
      {7, 7, "/products?category=25&page=7", true},
      {8, 8, "/products?category=25&page=8", false},
      {9, 9, "/products?category=25&page=9", false},
      {10, 10, "/products?category=25&page=10", false},
      {11, 11, "/products?category=25&page=11", false},
      {12, 12, "/products?category=25&page=12", false},
      {">", 8, "/products?category=25&page=8", false},
      {"Last", 16, "/products?category=25&page=16", false}
    ]
  end
end
