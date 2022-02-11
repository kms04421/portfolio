package kr.icia.conrtoller;

import java.util.List;
import java.util.UUID;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;

import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.icia.domain.AuthVO;
import kr.icia.domain.CartListVO;
import kr.icia.domain.MemberVO;
import kr.icia.domain.OrderVO;
import kr.icia.service.MemberService;
import kr.icia.service.ShopService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

//	private MemberVO member;
	private MemberService memberservice;

	@Autowired
	private JavaMailSender mailsender;

	@Setter(onMethod_ = @Autowired)
	BCryptPasswordEncoder passEncoder;
	
	private ShopService service;
	

	// 아이디 중복 체크
	@RequestMapping(value = "/useridCk", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String useridCk(String userid) throws Exception {
		logger.info("아이디 체크useridck:" + userid);
		int result = memberservice.useridCheck(userid);
		logger.info("받은값result:" + result);

		if (result != 0) {
			return "find";

		} else {
			return "avaliable";

		}
	}

	@GetMapping("/findAccount")
	public void selectAccount() {

	}

	// 비밀번호 찾기
	// /member/findAccount/pw
	@RequestMapping(value = "/findAccount/pw", method = RequestMethod.GET)
	@ResponseBody
	public String selectPw(String userid, String userMailPw) throws Exception {
		log.info("find pw" + userid + userMailPw);
		
		int result = memberservice.searchPw(userid, userMailPw);

		if (result == 1) {
			return "found";
		} else {
			return "not found";
		}

	}

	// 임시 비밀번호 발급
	@RequestMapping(value = "/findAccount/pwMail", method = RequestMethod.GET)
	@ResponseBody
	public String pwMailSend(String userid, String userMailPw) throws Exception {
		log.info("pwMailSend" + userid + userMailPw);
		// 임시 비밀번호 생성
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		uuid = uuid.substring(0, 10);
		log.info(uuid);

		// 이메일 보낼 준비
		log.info("send Mail");
		String setFrom = "kms04421@naver.com";
		String toMail = userMailPw;
		String title = "[PARI]" + userid + "님 PARI 임시 비밀번호 입니다.";
		String content = "안녕하세요 , PARI 회원님 " + "<br><br>" + "회원님의 임시 비밀번호는 " + "<b>" + uuid + "</b>" + "입니다" + "<br>"
				+ "사용후 꼭 비밀번호를 변경해 주시길 바랍니다";

		MemberVO member = new MemberVO();
		member.setUserId(userid);
		member.setUserMail(userMailPw);
		member.setUserPass(uuid);
		member.setUserPass(passEncoder.encode(member.getUserPass()));
		int result = memberservice.pwMailSend(member);
		if (result == 1) {
			try {
				 MimeMessage message = mailsender.createMimeMessage();
				 MimeMessageHelper helper =new MimeMessageHelper(message,true,"UTF-8");
				 helper.setFrom(setFrom);
				 helper.setTo(toMail);
				 helper.setSubject(title);
				 helper.setText(content,true);
				 mailsender.send(message);

				return "success";
			} catch (Exception e) {
				e.printStackTrace();
				return "fail";
			}
		} else {
			return "not found";
		}

	}

	@RequestMapping(value = "/loginhome", method = RequestMethod.GET)
	public void getloginhome() {
		log.info("loginhome");
	}
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public void getmypage(String userId,Model model) {
		
		log.info("mypage userId:"+userId);
		
		 
		 List<OrderVO> orderlist = service.orderList(userId);
		 
		 MemberVO vo = memberservice.read(userId);
		
		 log.info("orderlist :"+orderlist);
		 log.info("vo :"+vo);
	
		
		 model.addAttribute("vo", vo);
		 model.addAttribute("olist", orderlist);
	}
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void getSignup() {
		logger.info("get signup");
	}

	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String postSignup(MemberVO vo,AuthVO ao) throws Exception {
		logger.info("post signupdl" + vo);
		String auth="ROLE_USER";
		ao.setAuth(auth);
		vo.setUserPass(passEncoder.encode(vo.getUserPass()));
		ao.setUserId(vo.getUserId());
		
		memberservice.signup(vo,ao);
		logger.info("post signup" + vo + ao);

		return "redirect:/";
	}
	@RequestMapping(value = "/idAccount", method = RequestMethod.GET)
	public void getidAccount() {
		log.info("idAccount");
}
	@RequestMapping(value = "/userMailcheck", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String userMailcheck(String userName,String userPhon) throws Exception {
		log.info("Post idAccount:"+userName+userPhon);

		String result = memberservice.userMailcheck(userName,userPhon);
		logger.info("받은값result:" + result);

		if (result != null) {
			return  result;

		} else {
			
			return "fail";

		}

		

		}
		
	
}