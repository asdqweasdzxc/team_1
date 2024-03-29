package team1.project.bookshop.shop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import team1.project.bookshop.domain.Book;
import team1.project.bookshop.model.book.BookService;
import team1.project.bookshop.util.Message;
import team1.project.bookshop.util.PageManager2;

@RestController
@RequestMapping("/rest")
public class RestBookController {
	
	@Autowired
	private BookService bookService;
	
	public ResponseEntity<Message> search(Book book, HttpServletRequest request){
		
		return null;
	}
	
	@GetMapping("/book/list")
	public List getList(HttpServletRequest request) {
		return bookService.selectAll();
	}
	
	@GetMapping("/search/word")
	public List searchList(String book_name,HttpServletRequest request) {
		return bookService.selectByWord(book_name);
	}
		
	@GetMapping("/book/search/subcategory")
	public List searchBySCategory(int bookSubCategory_idx,HttpServletRequest request) {
		return bookService.selectBySubCategory(bookSubCategory_idx);
	}
		
	}

