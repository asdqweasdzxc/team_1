package team1.project.bookshop.model.book;

import java.util.List;

import team1.project.bookshop.domain.Book;

public interface BookService {
	public List selectAll();
	public void regist(Book book, String dir);
	public List selectByName(Book book);
	public List selectByWord(String book_name);
	public void delete(int book_idx);
	public Book select(int book_idx);
	public List chagePage(int book_idx);
	public List selectBySubCategory(int bookSubCategory_idx);
}
