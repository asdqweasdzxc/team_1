package team1.project.bookshop.model.book;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team1.project.bookshop.domain.Book;
import team1.project.bookshop.util.FileManager;

@Service
public class BookServiceImpl  implements BookService{

	@Autowired
	private BookDAO bookDAO;
	private FileManager fileManager = new FileManager();
	
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return bookDAO.selectAll();
	}

	@Override
	public void regist(Book book, String dir) {
		String name =fileManager.save(book, dir);
		book.setFilename(name);
		bookDAO.insert(book);
	}

	@Override
	public List selectByName(Book book) {
		
		return bookDAO.selectByName(book);
	}

	@Override
	public void delete(int book_idx) {
		bookDAO.delete(book_idx);
		
	}

	@Override
	public Book select(int book_idx) {
		// TODO Auto-generated method stub
		return bookDAO.select(book_idx);
	}

	@Override
	public List chagePage(int book_idx) {
		
		return bookDAO.chagePage(book_idx);
	}
	
	@Override
	public List selectByWord(String book_name) {
		// TODO Auto-generated method stub
		return bookDAO.selectByWord(book_name);
	}
	
	@Override
	public List selectBySubCategory(int bookSubCategory_idx) {
		
		return bookDAO.selectBySubCategory(bookSubCategory_idx);
	}
	
}
