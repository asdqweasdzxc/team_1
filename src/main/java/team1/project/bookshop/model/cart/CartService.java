package team1.project.bookshop.model.cart;

import java.util.List;

import team1.project.bookshop.domain.Cart;
import team1.project.bookshop.domain.Member;

public interface CartService {
	public List selectAll(Cart cart);
	public Cart select(Cart cart);
	public int selectDuplicate(Cart cart);
	public void regist(Cart cart);	// book, member select
	public void delete(Cart cart);
}
