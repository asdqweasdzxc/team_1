package team1.project.bookshop.shop.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import team1.project.bookshop.domain.Current_ship_condition;
import team1.project.bookshop.domain.Order_detail;
import team1.project.bookshop.domain.Orders;
import team1.project.bookshop.domain.Ship_condition;
import team1.project.bookshop.model.current_ship_condition.Current_ship_conditionService;
import team1.project.bookshop.model.order_detail.Order_detailService;
import team1.project.bookshop.model.orders.OrdersService;
import team1.project.bookshop.model.ship_condition.Ship_conditionService;
import team1.project.bookshop.util.Message;

@RestController
@RequestMapping("/rest")
public class RestOrderController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private Order_detailService order_detailService;
	
	@Autowired
	private OrdersService ordersService;
	
	@Autowired
	private Current_ship_conditionService current_ship_conditionService;
	
	@Autowired
	private Ship_conditionService ship_conditionService;
	
	@GetMapping("/order_detail")
	public List getOrder_detail(int orders_idx) {
		Order_detail order_detail = new Order_detail();
		Orders orders = new Orders();
		
		orders.setOrders_idx(orders_idx);
		order_detail.setOrders(orders);
		
		return order_detailService.selectAll(order_detail);
	}
	
	@GetMapping("/orders")
	public Orders getOrders(int orders_idx) {
		Orders orders = new Orders();
		orders.setOrders_idx(orders_idx);
		
		return ordersService.select(orders);
	}
	
	@GetMapping("/current_ship_condition")
	public Current_ship_condition getCurrent_ship_condition(int current_ship_condition_idx) {
		Current_ship_condition current_ship_condition = new Current_ship_condition();

		current_ship_condition.setCurrent_ship_condition_idx(current_ship_condition_idx);
		
		return current_ship_conditionService.select(current_ship_condition);
	}
	
	@GetMapping("/ship_condition")
	public List getship_conditionList() {
		List ship_conditionList = ship_conditionService.selectAll();
		
		return ship_conditionList;
	}
	
	@PutMapping("/ship_condition")
	public ResponseEntity<Message> getShip_condition(int ship_condition_idx) {
		System.out.println("넘어온 idx : "+ship_condition_idx);
		
		Current_ship_condition current_ship_condition = new Current_ship_condition();
		Ship_condition ship_condition = new Ship_condition();
		
		ship_condition.setShip_condition_idx(ship_condition_idx);
		current_ship_condition.setShip_condition(ship_condition);
		
		current_ship_conditionService.update(current_ship_condition);
		
		Message message = new Message();
		message.setMsg("select 수정");
		
		ResponseEntity<Message> entity = null;
		entity = new ResponseEntity<Message>(message, HttpStatus.OK);
		return entity;
	}
}
