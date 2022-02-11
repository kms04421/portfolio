package kr.icia.conrtoller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.naming.spi.DirStateFactory.Result;
import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.icia.domain.CartListVO;
import kr.icia.domain.CartVO;
import kr.icia.domain.GoodsVO;
import kr.icia.domain.MemberVO;
import kr.icia.domain.OrderVO;
import kr.icia.service.GoodsService;
import kr.icia.service.ShopService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/shop/*")
@AllArgsConstructor
public class ShopController {

	private ShopService service;
	private GoodsService goodsservice;
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value="/bues",method = RequestMethod.POST)
	public String bue(OrderVO vo) throws Exception {
	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		Date date = new Date();
		String str = sdf.format(date);
		String s_code = "s" + str;
		vo.setOrderId(s_code);
		
		log.info("bue:"+vo);
		service.orderin(vo);
		return "redirect:/";
	}
	
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/cartlist", method = RequestMethod.GET)
	public void getcartList(String userId,Model model) throws Exception {
				
		
			 log.info("get cart userId:"+userId);
			 		 
			 List<CartListVO> list = service.cartList(userId);
			 
			 log.info("list :"+list);
			
		model.addAttribute("list", list);
			 
			
			 
			}
		

	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value="/shoping",method = {RequestMethod.POST,RequestMethod.GET})
	public void shoping(CartVO cart) throws Exception {
		
		log.info("shoping:"+cart);
		service.addCart(cart);
		
	}
	@ResponseBody
	@RequestMapping(value = "/deleteCart", method = RequestMethod.POST)
	public int deleteCart(CartVO cart) throws Exception {
	 log.info("delete cart"+cart);
	  
	int result=1;
	
		
	
	   service.deleteCart(cart);
	
	return result;
	 
}
	@ResponseBody
	@RequestMapping(value = "/deleteorder", method = RequestMethod.POST)
	public int deleteOrder(OrderVO vo) throws Exception {
	 log.info("delete Order"+vo);
	  
	int result=1;
	
		
	
	   service.deleteOrder(vo);
	
	return result;
	 
}
}