package kr.icia.service;

import java.util.List;

import kr.icia.domain.AttachVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.GoodsVO;

public interface GoodsService {

	public void register(GoodsVO vo) throws Exception;
	
	public List<GoodsVO> goodslist(Criteria cri)throws Exception;
	
	public List<GoodsVO> goodsbue(int gdsNum)throws Exception;

	public GoodsVO goodsView(int gdsNum) throws Exception;
	
	public void goodsModify(GoodsVO vo) throws Exception;
	
	public void goodsDelete(int gdsNum) throws Exception;
	
	public int getTotal(Criteria cri);
	
	public void bue(GoodsVO vo) throws Exception;

	public List<AttachVO> getImgList(String pdId) throws Exception;
	
	public List<GoodsVO> mandresslist(GoodsVO vo)throws Exception;
	
	public List<GoodsVO> seasonlist(GoodsVO vo)throws Exception;
	
	public List<GoodsVO> garmentslist(GoodsVO vo)throws Exception;
}
