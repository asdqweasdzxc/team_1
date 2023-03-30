package team1.project.bookshop.shop.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import team1.project.bookshop.model.order.OrdersService;


@Controller
public class OrderController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private OrdersService ordersService;
	
	@GetMapping("/order/list")
	public ModelAndView getOrderList() {
		List orderList = ordersService.selectAll();
		
		ModelAndView mav = new ModelAndView("admin/order/orderList");
		mav.addObject("orderList", orderList);
		return mav;
	}
	
	@GetMapping("/ordercomp")
	public ModelAndView getOrderComp() {
		return new ModelAndView("shop/shop");
	}
}
