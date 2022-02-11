

package kr.icia.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.AuthVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.MemberVO;

public interface MemberService {

	public int useridCheck(String userid) throws Exception;

	public void signup(MemberVO vo, AuthVO ao) throws Exception;

	public void mbrDelete(String userId) throws Exception;

	public int searchPw(@Param("userid") String userid,
			@Param("userMail")String userMail);

	public int pwMailSend(MemberVO member);

	public String userMailcheck(@Param("userName") String userName,
			@Param("userPhon")String userPhon);

	public MemberVO read(String userId);
	
	public List<MemberVO> readall(Criteria cri);

	
}
