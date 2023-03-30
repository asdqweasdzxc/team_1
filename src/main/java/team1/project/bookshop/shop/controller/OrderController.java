package team1.project.bookshop.shop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import team1.project.bookshop.model.orders.OrdersService;
import team1.project.bookshop.model.ship_condition.Ship_conditionService;

@Controller
public class OrderController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private OrdersService ordersService;
	
	@Autowired
	private Ship_conditionService ship_conditionService;
	
	@GetMapping("/order/list")
	public ModelAndView getOrderList(HttpServletRequest request) {
		List orderList = ordersService.selectAll();
		
		ModelAndView mav = new ModelAndView("admin/order/orderList");
		mav.addObject("orderList", orderList);
		return mav;
	}
	
	@GetMapping("/order_detail")
	public ModelAndView getDetail() {
		List ship_conditionList = ship_conditionService.selectAll();
		
		ModelAndView mav = new ModelAndView("admin/order/orderDetail");
		mav.addObject("ship_conditionList", ship_conditionList);
		return mav;
	}
	
	/**Detail로 가는 GetMapping*/
	
	@GetMapping("/ordercomp")
	public ModelAndView getOrderComp(HttpServletRequest request) {
		return new ModelAndView("bookshop/shop");
	}
}
