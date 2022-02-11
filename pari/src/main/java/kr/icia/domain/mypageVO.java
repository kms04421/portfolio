package kr.icia.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class mypageVO {
	private String userName;
	private String userPhon;
	private String userMail;
		
	private int cartNum;
	private String userId;
	private int gdsNum;
	private int cartStock;
	private Date addDate;
	
	private int num;
	private String gdsName;
	private int gdsPrice;
	private String pdId;
	
	public List<AttachVO> ImgList;
}
