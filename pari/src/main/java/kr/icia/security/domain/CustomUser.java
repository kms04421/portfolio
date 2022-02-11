package kr.icia.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.icia.domain.MemberVO;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUser extends User {
	private static final long serialVersionUID = 1L;
	private MemberVO member;

	public CustomUser(String username, String password
			, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
		log.info("CustomUser 까지 왔다");
	}
	
	public CustomUser(MemberVO vo) {	
		super(vo.getUserId(), vo.getUserPass()
		, vo.getAuthList().stream()
		.map(auth -> new SimpleGrantedAuthority(
		auth.getAuth())).collect(Collectors.toList()));
		this.member = vo;
		log.info("CustomUser 까지 왔다");
		// 사용자 아이디, 패스워드, 권한 목록으로 초기화.
		}
}
