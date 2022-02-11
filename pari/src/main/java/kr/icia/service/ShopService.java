package kr.icia.service;

import java.util.List;

import kr.icia.domain.CartListVO;
import kr.icia.domain.CartVO;
import kr.icia.domain.OrderVO;

public interface ShopService {
	public void orderin(OrderVO vo) throws Exception;
	
	public List<OrderVO> orderList(String userId);
	
	public void addCart(CartVO cart);
	
	public void deleteCart(CartVO cart);
	
	public void deleteOrder(OrderVO vo);
	
	public List<CartListVO> cartList(String userId);
}
