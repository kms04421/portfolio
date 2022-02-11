package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.icia.domain.Criteria;
import kr.icia.domain.ReplyPageDTO;
import kr.icia.domain.ReplyVO;

import kr.icia.mapper.GoodsMapper;
import kr.icia.mapper.ReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImp implements ReplyService {

		
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private GoodsMapper goodsmapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		goodsmapper.updateReplyCnt(vo.getGdsNum(), 1);

		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		
		return mapper.read(rno);
	}
	
	@Transactional
	@Override
	public int remove(Long rno) {
		ReplyVO vo =mapper.read(rno);
		goodsmapper.updateReplyCnt(vo.getGdsNum(), -1);
		return mapper.delete(rno);
	}

	@Override
	public int modify(ReplyVO reply) {
	
		return mapper.update(reply);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long gdsNum) {
		
		return mapper.getListWithPaging(cri, gdsNum);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long gdsNum) {
		
		return new ReplyPageDTO(mapper.getCountByBno(gdsNum),
				mapper.getListWithPaging(cri, gdsNum));
	}

	

}
