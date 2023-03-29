package team1.project.bookshop.model.book;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team1.project.bookshop.domain.Book;

@Repository
public class MyabatisBookDAO implements BookDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("Book.selectAll");
	}

	@Override
	public void insert(Book book) {
		sqlSessionTemplate.insert("Book.insert", book);
		
	}

	@Override
	public List selectByName(Book book) {
		
		return sqlSessionTemplate.selectList("Book.selectByName", book);
	}

	@Override
	public void delete(int book_idx) {
		sqlSessionTemplate.delete("Book.delete",book_idx);
		
	}

	@Override
	public Book select(int book_idx) {
		
		return sqlSessionTemplate.selectOne("Book.select", book_idx);
	}

	@Override
	public List chagePage(int book_idx) {
		
		return sqlSessionTemplate.selectList("Book.selectForPage", book_idx);
	}
	
	@Override
	public List selectByWord(String book_name) {
		
		return sqlSessionTemplate.selectList("Book.selectByWord", book_name);
	}
	
	@Override
	public List selectBySubCategory(int bookSubCategory_idx) {
		
		return sqlSessionTemplate.selectList("Book.selectBySubCategory", bookSubCategory_idx);
	}

}
