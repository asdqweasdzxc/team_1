package team1.project.bookshop.model.topcategory;

import java.util.List;

import team1.project.bookshop.domain.BookTopCategory;

public interface BookTopcategoryService {
	public void regist(BookTopCategory bookTopCategory);
	public List selectAll();
	public void delete(int bookTopCategory_idx);
	public List selectByName(BookTopCategory bookTopCategory);
}
