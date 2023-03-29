package team1.project.bookshop.model.subcategory;

import java.util.List;

import team1.project.bookshop.domain.BookSubCategory;

public interface BookSubCategoryService {

	public List selectAll();
	public BookSubCategory select(int book_sub_category_idx);
	public void regist(BookSubCategory bookSubCategory);
	public void delete(int bookSubCategory_idx);
	public List selectByTopCategory(int book_top_category_idx);
}
