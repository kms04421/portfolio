package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.AttachVO;
import kr.icia.domain.CartListVO;
import kr.icia.domain.CartVO;
import kr.icia.domain.GoodsVO;
import kr.icia.domain.OrderVO;
import kr.icia.mapper.AttachMapper;
import kr.icia.mapper.GoodsMapper;
import kr.icia.mapper.ShopMapper;
import lombok.Setter;

@Service
public class ShopServiceImp implements ShopService {

	@Setter(onMethod_ = @Autowired)
	private AttachMapper attachmapper;

	@Setter(onMethod_ = @Autowired)
	private ShopMapper shopmapper;

	@Override
	public void orderin(OrderVO vo) throws Exception {

		shopmapper.orderin(vo);

	}

	@Override
	public void addCart(CartVO cart) {

		shopmapper.addCart(cart);
	}

	@Override
	public List<CartListVO> cartList(String userId) {

		List<CartListVO> cartList = shopmapper.cartList(userId);

		cartList.forEach(goods ->{
			String pdId = goods.getPdId();
			
			List<AttachVO> ImgList = attachmapper.getImgList(pdId);
			
			goods.setImgList(ImgList);
					
		});

		return cartList;
	}

	@Override
	public void deleteCart(CartVO cart) {
		shopmapper.deleteCart(cart);
		
	}

	@Override
	public List<OrderVO> orderList(String userId) {

		List<OrderVO> orderList = shopmapper.orderList(userId);



		return orderList;
	}

	@Override
	public void deleteOrder(OrderVO vo) {
		
		shopmapper.deleteOrder(vo);
		
	}

}
