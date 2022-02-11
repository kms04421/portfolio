package kr.icia.mapper;

import java.util.List;

import kr.icia.domain.CartListVO;
import kr.icia.domain.CartVO;

import kr.icia.domain.OrderVO;

public interface ShopMapper {

	public void orderin(OrderVO vo);
	
	public void addCart(CartVO cart);
	
	public void deleteCart(CartVO cart);
	
	public void deleteOrder(OrderVO vo);
	
	public List<CartListVO> cartList(String userId);
	
	public List<OrderVO> orderList(String userId);
}
