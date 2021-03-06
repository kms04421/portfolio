package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.Criteria;
import kr.icia.domain.ReplyVO;

public interface ReplyMapper {

		public int insert(ReplyVO vo);
		
		public ReplyVO read(Long rno);
		
		public int delete(Long rno);
		
		public int update(ReplyVO reply);
		
		public int getCountByBno(Long gdsNum);
		
		public List<ReplyVO> getListWithPaging(
				@Param("cri") Criteria cri,
				@Param("gdsNum") Long gdsNum);
}
