package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.AuthVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.MemberVO;
import kr.icia.mapper.memberMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@AllArgsConstructor
@Service("memberService")
@Log4j
public class MemberServiceImp implements MemberService {
	@Setter(onMethod_ = @Autowired)
	private memberMapper membermapper;

	@Override
	public int useridCheck(String userid) throws Exception {
		log.info("값이 가는지 확인 " + userid);
		return membermapper.useridCheck(userid);
	}

	@Override
	public void signup(MemberVO vo, AuthVO ao) throws Exception {
		membermapper.signup(vo);
		membermapper.memberAuth(ao);
	}



	@Override
	public int searchPw(String userid, String userMail) {
		log.info(" 메일 pw...." + userid);

		return membermapper.findPw(userid, userMail);
	}

	@Override
	public int pwMailSend(MemberVO member) {
		log.info("change pw....." + member);

		return membermapper.pwMailSend(member);
	}

	@Override
	public String userMailcheck(String userName, String userPhon) {
		String result = "";
		try {
			result = membermapper.userMailcheck(userName,userPhon);
		


		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public MemberVO read(String userId) {
		
		return membermapper.read(userId);
	}

	@Override
	public List<MemberVO> readall(Criteria cri) {
		
		return membermapper.readall(cri);
	}
	
	@Override
	public void mbrDelete(String userId) throws Exception {
		membermapper.mbrDelete(userId);
		
	}

}
