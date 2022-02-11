package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.AuthVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.MemberVO;

public interface memberMapper {
	
	public List<MemberVO> getList();
	
	public void insert(MemberVO vo);
	
	public void mbrDelete(String userId);
	
	public int update(MemberVO voard);

	public void signup(MemberVO vo);

	public void memberAuth(AuthVO ao);

	public int useridCheck(String userid);
	
	public void memberJoin(MemberVO member);
	
	public MemberVO read(String userId);
	
	public List<MemberVO> readall(Criteria cri);

	public int findPw(@Param("userid") String userid,
			@Param("userMail")String userMail);

	public int pwMailSend(MemberVO member);
	
	public String userMailcheck(@Param("userName") String userName,
			@Param("userPhon")String userPhon);

}
