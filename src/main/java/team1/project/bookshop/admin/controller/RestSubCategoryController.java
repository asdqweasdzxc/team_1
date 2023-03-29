package team1.project.bookshop.admin.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import team1.project.bookshop.domain.BookSubCategory;
import team1.project.bookshop.model.subcategory.BookSubCategoryService;
import team1.project.bookshop.util.Message;

@RestController
@RequestMapping("/rest")
public class RestSubCategoryController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private BookSubCategoryService bookSubCategoryService;
	
	@PostMapping("/subcategory")
	public ResponseEntity<Message> regist(BookSubCategory bookSubCategory){
		logger.info(""+bookSubCategory);
		bookSubCategoryService.regist(bookSubCategory);
		
		Message msg = new Message();
		msg.setMsg("등록성공");
		
		ResponseEntity<Message> entity = new ResponseEntity<Message>(msg, HttpStatus.OK);
		
		return entity;
	}
	
	@GetMapping("/subcategory/get")
	public List<BookSubCategory> getSubCategoryListInTopCategoryIdx(int book_top_category_idx){
		
		List<BookSubCategory> list = bookSubCategoryService.selectByTopCategory(book_top_category_idx);
		logger.info(""+list);
		return list;
	}
}
