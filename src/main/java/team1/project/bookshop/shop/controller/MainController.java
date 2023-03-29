package team1.project.bookshop.shop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import team1.project.bookshop.model.book.BookService;
import team1.project.bookshop.model.inquiry_category.Inquiry_categoryService;
import team1.project.bookshop.util.PageManager2;

//쇼핑몰의 메인을 처리하는 하위 컨트롤러

@Controller
public class MainController {
	
	@Autowired
	private Inquiry_categoryService inquiry_categoryService;
	
	@Autowired
	private BookService bookService;
	
	@GetMapping("/")
	public ModelAndView getMain(HttpServletRequest request) {
		//3단계
		List inquiry_categoryList = inquiry_categoryService.selectAll();
		
		//4단계 : 저장할 것이 있다(왜? jsp로 가져가야 하니깐..)
		ModelAndView mav = new ModelAndView();
		mav.addObject("inquiry_categoryList", inquiry_categoryList);
		mav.setViewName("shop/index");
		
		return mav;
	}
	
	@GetMapping("/book/search")
	public ModelAndView search() {
		
		List bookList = bookService.selectAll();
		PageManager2 pageManager = new PageManager2();
		pageManager.init(bookList);
		
		
		ModelAndView mav = new ModelAndView("client/booksearch2");
		mav.addObject("bookList", bookList);
		mav.addObject("pageManager", pageManager);
		
		return mav;
	}
}
