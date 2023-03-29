package team1.project.bookshop.model.topcategory;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team1.project.bookshop.domain.BookTopCategory;

@Repository
public class MybatisBookTopCategoryDAO implements BookTopCategoryDAO{
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public void insert(BookTopCategory bookTopCategory) {
		sqlSessionTemplate.insert("BookTopCategory.insert", bookTopCategory);
	}

	@Override
	public List selectAll() {
		List list = sqlSessionTemplate.selectList("BookTopCategory.selectAll");
		logger.info(""+list.get(0));
		return sqlSessionTemplate.selectList("BookTopCategory.selectAll");
	}

	@Override
	public void delete(int bookTopCategory_idx) {
		// TODO Auto-generated method stub
		sqlSessionTemplate.delete("BookTopCategory.delete", bookTopCategory_idx);
	}

	@Override
	public List selectByName(BookTopCategory bookTopCategory) {
		
		return sqlSessionTemplate.selectList("BookTopCategory.selectByName", bookTopCategory);
	}
	
	

}
