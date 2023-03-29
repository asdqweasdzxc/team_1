package team1.project.bookshop.model.subcategory;

import java.util.List;

import team1.project.bookshop.domain.BookSubCategory;

public interface BookSubCategoryDAO {
	public List selectAll();
	public BookSubCategory select(int book_sub_category_idx);
	public void insert(BookSubCategory bookSubCategory);
	public void delete(int bookSubCategory_idx);
	public List selectByTopCategory(int bookTopCategory_idx);
}
