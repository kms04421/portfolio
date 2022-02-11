package kr.icia.domain;


import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class MemberVO {
	
	
private String userId;
private String userPass;
private String userName;
private Date regDate;
private String userPhon;
private int useridCheck;
public List<AuthVO> authList;
private boolean enabled; // 계정 정지 유무
private Date updateDate;
private String userMail;
private String pdId;
private String auth; 
private int admin; 




}
