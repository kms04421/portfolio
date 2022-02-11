package kr.icia.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderVO {

	private String orderId;
	private String userId;
	private String orderRec;
	private String userAddr1;
	private String userAddr2;
	private String userAddr3;
	private String orderPhon;
	private String gdsName;
	private String pdId;
	private int sumbue;
	private Date orderDate;
	private Long gdsNum;
	private int amount;
	private int gdsStock;
	
	public List<AttachVO> ImgList;
}
