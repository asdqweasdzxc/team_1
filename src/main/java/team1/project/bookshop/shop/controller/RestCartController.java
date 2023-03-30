package team1.project.bookshop.shop.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import team1.project.bookshop.domain.Cart;
import team1.project.bookshop.domain.Member;
import team1.project.bookshop.exception.CartException;
import team1.project.bookshop.order.model.CartService;
import team1.project.bookshop.util.Message;

@RestController
@RequestMapping("/rest")
public class RestCartController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CartService cartService;
	
	@PostMapping("/shop_cart")
	public ResponseEntity<Message> getCart(Cart cart) {
		logger.info("Cart에 비동기 등록");
		
		Message message = new Message();
		
		if(cartService.selectDuplicate(cart)<1) {
			cartService.regist(cart);			
			message.setMsg("Cart에 상품 등록 성공");
		}else {
			message.setMsg("Cart에 같은 상품이 존재");	
		}
		
		ResponseEntity<Message> entity = null;
		entity = new ResponseEntity<Message>(message, HttpStatus.OK);
		
		return entity;
	}
	
	@GetMapping("/cart")
	public List getCartList(Member member) {
		Cart cart = new Cart();
		cart.setMember(member);
		cartService.selectAll(cart);
		
		return cartService.selectAll(cart);
	}
	
	@DeleteMapping("/cart/{cart_idx}")
	public ResponseEntity<Message> delCart(@PathVariable int cart_idx){
		logger.info("넘겨받은 cart_idx="+cart_idx);
		Cart cart = new Cart();
		cart.setCart_idx(cart_idx);
		cartService.delete(cart);
		
		Message message = new Message();
		message.setMsg("Cart 1건 삭제 성공");
		ResponseEntity<Message> entity = null;
		entity = new ResponseEntity<Message>(message, HttpStatus.OK);
		
		return entity;
	}
	
	@ExceptionHandler(CartException.class)
	public ResponseEntity<Message> handle(CartException e){
		Message message = new Message();
		message.setMsg(e.getMessage());
		
		ResponseEntity<Message> entity = null;
		entity = new ResponseEntity<Message>(message, HttpStatus.INTERNAL_SERVER_ERROR);
		
		return entity;
	}
}
