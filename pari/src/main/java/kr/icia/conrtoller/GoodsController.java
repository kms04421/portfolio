package kr.icia.conrtoller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.AttachVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.GoodsVO;
import kr.icia.domain.OrderVO;
import kr.icia.domain.PageDTO;
import kr.icia.service.GoodsService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/goods/*")
@AllArgsConstructor
public class GoodsController {

	private GoodsService goodsservice;

	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/goodsregister", method = RequestMethod.GET)
	public void getgoodsregister() {
		log.info("goodsregister");
	}
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/bue", method = RequestMethod.GET)
	public void getbue(@RequestParam("gdsNum") int gdsNum,@RequestParam("gdsStock") int gdsStock,@ModelAttribute("cri") Criteria cri,Model model) throws Exception {
		
		List<GoodsVO> list = goodsservice.goodsbue(gdsNum);
		log.info("get goods bue:"+cri);
		log.info("get goods bue:"+gdsStock);
	
		
		log.info("get goods bue:" + list);
		
		model.addAttribute("list",list);
		model.addAttribute("pageMaker", new PageDTO(cri,5));
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/bues", method = {RequestMethod.POST,RequestMethod.GET})
	public void postbue(GoodsVO vo) throws Exception {	
		log.info("post goods bue:"+vo);
	goodsservice.bue(vo);
		
		
		
		
	}

	@RequestMapping(value ="/list", method = RequestMethod.GET)
	public void list(Model model, Criteria cri ) throws Exception {
		log.info("쇼핑몰 메인 페이지 진입");
		List<GoodsVO> list = goodsservice.goodslist(cri);
		log.info("쇼핑몰 메인 페이지 진입"+cri);
		int total = goodsservice.getTotal(cri);

		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@RequestMapping(value ="/mandress", method = RequestMethod.GET)
	public void mandress(Model model,GoodsVO vo) throws Exception {
		String tpid="남자";
		vo.setCateCode(tpid);
		log.info("남성복 진입"+vo);
		List<GoodsVO> list = goodsservice.mandresslist(vo);
		log.info("남성복 진입"+list);


		model.addAttribute("list", list);
	
	}
	@RequestMapping(value ="/femaledress", method = RequestMethod.GET)
	public void femaledress(Model model,GoodsVO vo) throws Exception {
		String tpid="여자";
		vo.setCateCode(tpid);
		log.info("여성복 진입"+vo);
		List<GoodsVO> list = goodsservice.mandresslist(vo);
		log.info("여성복 진입"+list);


		model.addAttribute("list", list);
	
	}
	@RequestMapping(value ="/summer", method = RequestMethod.GET)
	public void summer(Model model,GoodsVO vo) throws Exception {
		String tpid="여름";
		vo.setCateCode2(tpid);
		
		List<GoodsVO> list = goodsservice.seasonlist(vo);
		


		model.addAttribute("list", list);
	
	}
	@RequestMapping(value ="/spring", method = RequestMethod.GET)
	public void spring(Model model,GoodsVO vo) throws Exception {
		String tpid="봄";
		vo.setCateCode2(tpid);
		
		List<GoodsVO> list = goodsservice.seasonlist(vo);
	
		model.addAttribute("list", list);
	
	}
@RequestMapping(value ="/winter", method = RequestMethod.GET)
public void winter(Model model,GoodsVO vo) throws Exception {
	String tpid="겨울";
	vo.setCateCode2(tpid);
	
	List<GoodsVO> list = goodsservice.seasonlist(vo);



	model.addAttribute("list", list);

}
@RequestMapping(value ="/autumn", method = RequestMethod.GET)
public void autumn(Model model,GoodsVO vo) throws Exception {
	String tpid="가을";
	vo.setCateCode2(tpid);
	
	List<GoodsVO> list = goodsservice.seasonlist(vo);



	model.addAttribute("list", list);

}
@RequestMapping(value ="/topgarments", method = RequestMethod.GET)
public void topgarments(Model model,GoodsVO vo) throws Exception {
	String tpid="상의";
	vo.setCateCode1(tpid);
	
	List<GoodsVO> list = goodsservice.garmentslist(vo);

	model.addAttribute("list", list);

}
@RequestMapping(value ="/downgarments", method = RequestMethod.GET)
public void downgarments(Model model,GoodsVO vo) throws Exception {
	String tpid="하의";
	vo.setCateCode1(tpid);
	
	List<GoodsVO> list = goodsservice.garmentslist(vo);

	model.addAttribute("list", list);

}
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String postGoodsRegiser(GoodsVO vo, RedirectAttributes rttr) throws Exception {
		if (vo.getImgList() != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			Date date = new Date();
			String str = sdf.format(date);
			String s_code = "s" + str;
			vo.setPdId(s_code);
			vo.ImgList.remove(0);
			vo.getImgList().forEach(attach -> log.info(attach));

		}

		log.info("register1:" + vo);
		goodsservice.register(vo);
		rttr.addFlashAttribute("result", "upload");
		return "redirect:/";
	}

	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void Goodsmodify(@RequestParam("gdsNum") int gdsNum,@ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		log.info("get goods modify");
		
		GoodsVO goods = goodsservice.goodsView(gdsNum);
		log.info("modify:" + cri);
		model.addAttribute("goods", goods);
	}

	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void mainPageGET(Model model, Criteria cri) throws Exception {
		log.info("쇼핑몰 메인 페이지 진입");
		List<GoodsVO> list = goodsservice.goodslist(cri);
		log.info("쇼핑몰 메인 페이지 진입"+cri);
		log.info("쇼핑몰 메인 페이지 진입"+list);
		int total = goodsservice.getTotal(cri);

		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/view")	
	public void getGoodsview(@RequestParam("gdsNum") int gdsNum, @ModelAttribute("cri") Criteria cri,Model model) throws Exception {
		log.info("get goods view");
	
		GoodsVO goods = goodsservice.goodsView(gdsNum);
		log.info("get goods view:"+cri);
		
	
		log.info("get goods view" + goods);
		model.addAttribute("goods", goods);
	}
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postGoodsmodify(GoodsVO vo,Criteria cri,RedirectAttributes rttr) throws Exception {
		vo.ImgList.remove(0);
	
		vo.getImgList().forEach(attach -> log.info(attach));
		
		log.info("modify:" + vo);
		goodsservice.goodsModify(vo);
		log.info("modify:" + cri);
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/";
	}

	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String GoodsDelete(@RequestParam("gdsNum") int gdsNum,Criteria cri,
			RedirectAttributes rttr) throws Exception {
		
		log.info("get goodsDelete" + gdsNum);
		goodsservice.goodsDelete(gdsNum);
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/";
	}

	// /goods/getImgList?pdId=s20220106171422239
	@GetMapping(value = "/getImgList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getAttachList(@RequestParam("pdId") String pdId) throws Exception {
		log.info("pdid: " + pdId);

		return new ResponseEntity<>(goodsservice.getImgList(pdId), HttpStatus.OK);
		
	}
	@GetMapping("/detaill")
	@ResponseBody
	public ResponseEntity<byte[]> getImage(String fileName) {
		log.info("get image........" + fileName);
		File file = new File("c:\\upload\\" + fileName);
		log.info("file:" + file);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();

			header.add("Content-type", Files.probeContentType(file.toPath()));

			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
}
