package kr.icia.mapper;

import java.util.List;

import kr.icia.domain.AttachVO;


public interface AttachMapper {

	public void uploadImg(AttachVO image);		
	
	public void attachmodify(AttachVO attach);

	public List<AttachVO> getImgList(String pdId);
}
