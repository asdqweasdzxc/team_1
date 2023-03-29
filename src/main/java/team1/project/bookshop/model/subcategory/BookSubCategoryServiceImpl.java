package team1.project.bookshop.model.subcategory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team1.project.bookshop.domain.BookSubCategory;

@Service
public class BookSubCategoryServiceImpl implements BookSubCategoryService{
	
	@Autowired
	private BookSubCategoryDAO bookSubCategoyDAO;
	
	@Override
	public List selectAll() {
		
		return bookSubCategoyDAO.selectAll();
	}

	@Override
	public BookSubCategory select(int book_sub_category_idx) {
		
		return bookSubCategoyDAO.select(book_sub_category_idx);
	}

	@Override
	public void regist(BookSubCategory bookSubCategory) {
		
		bookSubCategoyDAO.insert(bookSubCategory);
		
	}

	@Override
	public void delete(int bookSubCategory_idx) {
		bookSubCategoyDAO.delete(bookSubCategory_idx);
		
	}

	@Override
	public List selectByTopCategory(int book_top_category_idx) {
		
		return bookSubCategoyDAO.selectByTopCategory(book_top_category_idx);
	}

}
