package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.Criteria;
import kr.icia.domain.GoodsVO;

public interface GoodsMapper {

	public void register(GoodsVO vo);
	
	public int getTotalCount(Criteria cri);
	
	public List<GoodsVO>goodslist(Criteria cri);
	
	public List<GoodsVO>goodsbue(int gdsNum);
	
	public GoodsVO goodsView(int gdsNum);
	
	public void goodsModify(GoodsVO vo);
	
	public void goodsDelete(int gdsNum);
	
	public void uploadImg(GoodsVO vo);
	
	public void updateReplyCnt(@Param("gdsNum") Long gdsNum
			, @Param("amount") int amount);

	public String[] getAuthorIdList(String keyword);
	
	public List<GoodsVO>mandresslist(GoodsVO vo);
	
	public List<GoodsVO>seasonlist(GoodsVO vo);
	
	public List<GoodsVO>garmentslist(GoodsVO vo);
	
	public List<GoodsVO>cartlist(int gdsNum);
	
	public void bue(GoodsVO vo);

}
