package kr.icia.service;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.icia.domain.GoodsVO;
import kr.icia.domain.AttachVO;
import kr.icia.domain.Criteria;
import kr.icia.mapper.AttachMapper;
import kr.icia.mapper.GoodsMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service("GoodsService")
@Log4j
public class GoodsServiceImp implements GoodsService{
	
	@Setter(onMethod_ = @Autowired)
	private GoodsMapper goodsmapper;
	
	@Setter(onMethod_ = @Autowired)
	private AttachMapper attachmapper;
	
	@Transactional
	@Override
	public void register(GoodsVO vo) throws Exception {
		log.info("register goods.........");
		
		
		
		goodsmapper.register(vo);	
		
		
		  if(vo.getImgList() == null || vo.getImgList().size()<=0){ 
			  return; 
			  }

			
			vo.getImgList().forEach(attach -> {
				attach.setPdId(vo.getPdId());
				
				attachmapper.uploadImg(attach);
			});
		  
		
	}

	@Override
	public List<GoodsVO> goodslist(Criteria cri) throws Exception {
		
		List<GoodsVO> list = goodsmapper.goodslist(cri);
		list.forEach(goods ->{
			String pdId = goods.getPdId();
			
			List<AttachVO> ImgList = attachmapper.getImgList(pdId);
			
			goods.setImgList(ImgList);
					
		});
		return list;
	}

	@Override
	public GoodsVO goodsView(int gdsNum) throws Exception {
		
		return goodsmapper.goodsView(gdsNum);
	}

	@Override
	public void goodsModify(GoodsVO vo) throws Exception {
		goodsmapper.goodsModify(vo);
		 if(vo.getImgList() == null || vo.getImgList().size()<=0){ 
				log.info("register attch"+vo);
			  return; 
			  }
		 
			vo.getImgList().forEach(attach -> {
								
				attachmapper.attachmodify(attach);
			});
		  
		
	}

	@Override
	public void goodsDelete(int gdsNum) throws Exception {
		goodsmapper.goodsDelete(gdsNum);
		
	}


	@Override
	public List<AttachVO> getImgList(String pdId) throws Exception {
		log.info("getImgList.........");
		return attachmapper.getImgList(pdId);
		
	}

	@Override
	public int getTotal(Criteria cri) {
		
		return goodsmapper.getTotalCount(cri);
	}

	@Override
	public List<GoodsVO> mandresslist(GoodsVO vo) throws Exception {
		
		List<GoodsVO> list = goodsmapper.mandresslist(vo);
		list.forEach(goods ->{
			String pdId = goods.getPdId();
			
			List<AttachVO> ImgList = attachmapper.getImgList(pdId);
			
			goods.setImgList(ImgList);
					
		});
		return list;
	}
	@Override
	public List<GoodsVO> seasonlist(GoodsVO vo) throws Exception {
		
		List<GoodsVO> list = goodsmapper.seasonlist(vo);
		list.forEach(goods ->{
			String pdId = goods.getPdId();
			
			List<AttachVO> ImgList = attachmapper.getImgList(pdId);
			
			goods.setImgList(ImgList);
					
		});
		return list;
	}
	@Override
	public List<GoodsVO> garmentslist(GoodsVO vo) throws Exception {
		
		List<GoodsVO> list = goodsmapper.garmentslist(vo);
		list.forEach(goods ->{
			String pdId = goods.getPdId();
			
			List<AttachVO> ImgList = attachmapper.getImgList(pdId);
			
			goods.setImgList(ImgList);
					
		});
		return list;
	}

	@Override
	public List<GoodsVO> goodsbue(int gdsNum) throws Exception {
		List<GoodsVO> list =goodsmapper.goodsbue(gdsNum);
		list.forEach(goods ->{
			String pdId = goods.getPdId();
			
			List<AttachVO> ImgList = attachmapper.getImgList(pdId);
			
			goods.setImgList(ImgList);
					
		});
		return list;
	}

	@Override
	public void bue(GoodsVO vo) throws Exception {
		goodsmapper.bue(vo);	
		
		
	}


}
