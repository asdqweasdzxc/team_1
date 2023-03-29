package team1.project.bookshop.admin.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import team1.project.bookshop.domain.BookTopCategory;
import team1.project.bookshop.model.topcategory.BookTopcategoryService;

@Controller
public class TopCategoryController {
	
	@Autowired
	private BookTopcategoryService bookTopcategoryService;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@GetMapping("/category/top")
	public ModelAndView getTopCategoryList() {
		
		
		ModelAndView mav = new ModelAndView("admin/topcategorys");
		
		
		
		return mav;
	}
	
	@GetMapping("/deletetopcategory")
	public ModelAndView delete(int bookTopCategory_idx) {
		
		
		bookTopcategoryService.delete(bookTopCategory_idx);
		
		return new ModelAndView("redirect:/admin/topcategoryList");
	}
	
	@PostMapping("/searchtopcategory")
	public ModelAndView search(BookTopCategory bookTopCategory) {
		
		logger.info(""+bookTopCategory);
		List topcategoryList = bookTopcategoryService.selectByName(bookTopCategory);
		
		ModelAndView mav = new ModelAndView("admin/topcategorys");
		mav.addObject("topcategoryList", topcategoryList);
		
		return mav;
	}

}
