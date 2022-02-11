package kr.icia.domain;

import lombok.Data;

@Data
public class GoodsAttachVO {
	private String FileName;
	private String UploadPath;
	private String uuId;
	private String pdId;
	private boolean image;
}
