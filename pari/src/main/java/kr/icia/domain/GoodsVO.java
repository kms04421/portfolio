package kr.icia.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class GoodsVO {

private Long gdsNum;
private String gdsName;
private String cateCode;
private String cateCode1;
private String cateCode2;
private int gdsPrice;
private int gdsStock;
private String gdsDes;
private String pdId;
private Date gdsDate;
public List<AttachVO> ImgList;
private int replyCnt;
private String userId;

private String tp;//카테
}
