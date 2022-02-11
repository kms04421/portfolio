package kr.icia.conrtoller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.Criteria;
import kr.icia.domain.GoodsVO;
import kr.icia.domain.MemberVO;
import kr.icia.domain.PageDTO;
import kr.icia.service.GoodsService;
import kr.icia.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin/*")
@AllArgsConstructor
public class adminContoller {
	
	private MemberService memberservice;

	private GoodsService goodsservice;
	
	
	@RequestMapping(value ="/admin", method = RequestMethod.GET)
	public void list(Model model, Criteria cri ) throws Exception {
		log.info("관리자 메인 페이지 진입");
		List<GoodsVO> list = goodsservice.goodslist(cri);
		log.info("관리자 메인 페이지 진입"+cri);
		int total = goodsservice.getTotal(cri);

		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String GoodsDelete(@RequestParam("gdsNum") int gdsNum,Criteria cri,
			RedirectAttributes rttr) throws Exception {
		
		log.info("Delete" + gdsNum);
		goodsservice.goodsDelete(gdsNum);
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/";
	}
	@RequestMapping(value = "/member", method = RequestMethod.GET)
	public void getmember(Model model,Criteria cri) throws Exception {
		List<MemberVO> list = memberservice.readall(cri);
		log.info("member");
		int total = goodsservice.getTotal(cri);

		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	@RequestMapping(value = "/mbrremove", method = RequestMethod.POST)
	public String memberDelete(@RequestParam("userId") String userId,Criteria cri,
			RedirectAttributes rttr) throws Exception {
		
		log.info("Delete" + userId);
		memberservice.mbrDelete(userId);
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/";
	}
}
