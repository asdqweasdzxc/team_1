package team1.project.bookshop.model.topcategory;

import java.util.List;

import team1.project.bookshop.domain.BookTopCategory;

public interface BookTopCategoryDAO {
	public void insert(BookTopCategory bookTopCategory);
	public List selectAll();
	public void delete(int bookTopCategory_idx);
	public List selectByName(BookTopCategory bookTopCategory);
}
