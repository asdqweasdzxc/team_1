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

import oracle.jdbc.proxy.annotation.Post;
import team1.project.bookshop.domain.BookTopCategory;
import team1.project.bookshop.model.topcategory.BookTopcategoryService;
import team1.project.bookshop.util.Message;

@RestController
@RequestMapping("/rest")
public class RestTopCategoryController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private BookTopcategoryService bookTopcategoryService;
	
	@PostMapping("/topcategory")
	public ResponseEntity<Message> registCategory(BookTopCategory bookTopCategory_name){
		
		logger.info(""+bookTopCategory_name);
		 
		bookTopcategoryService.regist(bookTopCategory_name);
		Message msg = new Message();
		msg.setMsg("등록성공");
		
		ResponseEntity<Message> entity = new ResponseEntity<Message>(msg, HttpStatus.OK);
		
		return entity;
		
	}
	
	@GetMapping("/topcategory/list")
	public List getTopCategoryList(){
		
		
		return bookTopcategoryService.selectAll();
	}
	
	@GetMapping("/topcategory/del")
	public ResponseEntity<Message> del(int bookTopCategory_idx){
		
		bookTopcategoryService.delete(bookTopCategory_idx);
		return null;
	}
}
