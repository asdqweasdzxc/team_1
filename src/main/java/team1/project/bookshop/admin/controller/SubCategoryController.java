package team1.project.bookshop.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import team1.project.bookshop.model.subcategory.BookSubCategoryService;

@Controller
public class SubCategoryController {
	
	@Autowired
	private BookSubCategoryService subcategoryService;
	
	
	
	@GetMapping("/category/sub")
	public ModelAndView getSubcategoryList() {
		List subcategory_list = subcategoryService.selectAll();
		
		ModelAndView mav = new ModelAndView("admin/subcategorys");
		mav.addObject("subcategoryList", subcategory_list);
		return mav;
	}
	
	@GetMapping("/deletesubcategory")
	public ModelAndView delete(int bookSubCategory_idx) {
		
		subcategoryService.delete(bookSubCategory_idx);
		
		return new ModelAndView("redirect:/admin/product/subcategoryList");
	}
	
	
}
