package team1.project.bookshop.model.subcategory;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team1.project.bookshop.domain.BookSubCategory;

@Repository
public class MybatisBookSubCategoryDAO implements BookSubCategoryDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	
	@Override
	public List selectAll() {
		
		return sqlSessionTemplate.selectList("BookSubCategory.selectAll");
	}

	@Override
	public BookSubCategory select(int book_sub_category_idx) {
		
		return sqlSessionTemplate.selectOne("BookSubCategory.select",book_sub_category_idx);
	}

	@Override
	public void insert(BookSubCategory bookSubCategory) {
		sqlSessionTemplate.insert("BookSubCategory.insert", bookSubCategory);
		
	}

	@Override
	public void delete(int bookSubCategory_idx) {
		sqlSessionTemplate.delete("BookSubCategory.delete", bookSubCategory_idx);
		
	}

	@Override
	public List selectByTopCategory(int bookTopCategory_idx) {
		List list = sqlSessionTemplate.selectList("BookSubCategory.selectByTopCategory",bookTopCategory_idx);
		return list;
	}

}
