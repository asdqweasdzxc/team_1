package team1.project.bookshop.model.topcategory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team1.project.bookshop.domain.BookTopCategory;

@Service
public class BookTopCategoryServiceImpl implements BookTopcategoryService{
	
	@Autowired
	private BookTopCategoryDAO bookTopCategoryDAO;
	
	@Override
	public void regist(BookTopCategory bookTopCategory) {
		
		bookTopCategoryDAO.insert(bookTopCategory);
		
	}

	@Override
	public List selectAll() {
		
		return bookTopCategoryDAO.selectAll();
	}

	@Override
	public void delete(int bookTopCategory_idx) {
		bookTopCategoryDAO.delete(bookTopCategory_idx);
		
	}

	@Override
	public List selectByName(BookTopCategory bookTopCategory) {
		// TODO Auto-generated method stub
		return bookTopCategoryDAO.selectByName(bookTopCategory);
	}
	
}
