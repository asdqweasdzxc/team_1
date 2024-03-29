package team1.project.bookshop.admin.controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;


import team1.project.bookshop.domain.Book;
import team1.project.bookshop.model.book.BookService;

@Controller
public class BookController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private BookService bookService;

	@GetMapping("/book/registform")
	public ModelAndView getBookList(HttpServletRequest request) {
		
		List list = bookService.selectAll();
		
		ModelAndView mav = new ModelAndView("admin/book/books");
		mav.addObject("bookList", list);
		
		return mav;
	}
	
	
	@PostMapping("/bookregist")
	public ModelAndView regist(Book book, HttpServletRequest request) {

		if(book.getMyfile()==null) {
			logger.info("파일안들어옴");
			
		}
		
		ServletContext application = request.getSession().getServletContext();
		String dir = application.getRealPath("/resources/data/");
		//서버에 올릴때 String dir= "/img/book" 으로 변경
		logger.info("파일이 저장될 경로는 :"+dir);
		
		bookService.regist(book, dir);
		
		return new ModelAndView("redirect:/admin/book/registform");
	}
	
	@GetMapping("/deletebook")
	public ModelAndView delete(int book_idx) {
		logger.info("넘어온 idx:"+book_idx);
		
		bookService.delete(book_idx);
		return new ModelAndView("redirect:/admin/book/registform");
	}
	
	@GetMapping("/book/detail")
	public ModelAndView getDetail(int book_idx, HttpServletRequest request) {
		
		
		Book book =bookService.select(book_idx);
		
		ModelAndView mav = new ModelAndView("admin/book/bookdetail");
		mav.addObject("book", book);
		
		
		return mav;
	}
	
	@PostMapping("/editbook")
	public ModelAndView update(Book book, HttpServletRequest request) {
		
		ServletContext application = request.getSession().getServletContext();
		String dir = application.getRealPath("/resources/data/");
		//서버에 올릴때 String dir= "/img/book" 으로 변경
		logger.info("파일이 저장될 경로는 :"+dir);
		logger.info("넘어온파일은? :"+book.getMyfile());
		
		
		
		bookService.edit(book, dir);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/admin/book/detail?book_idx="+book.getBook_idx());
		return mav;
	}
}
