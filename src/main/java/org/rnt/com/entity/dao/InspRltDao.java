package org.rnt.com.entity.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.InspRltVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("inspRltDao")
public class InspRltDao extends BaseDao {

	@Autowired
	private SqlSession sqlSession;

	public final String ENTITY_NAME = "mpo012";

	public RtnVO insert(InspRltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.insert(ENTITY_NAME+".insert", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
		}
		 return rtn;
	}
	public RtnVO select(InspRltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			InspRltVO vo = sqlSession.selectOne(ENTITY_NAME+".select", param);
			rtn.setObj(vo);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO update(InspRltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(ENTITY_NAME+".update", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO delete(InspRltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(ENTITY_NAME+".delete", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO deleteAll(InspRltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(ENTITY_NAME+".deleteAll", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO searchList(InspRltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			List<InspRltVO> list = sqlSession.selectList(ENTITY_NAME+".searchList", param);
			rtn.setObj(list);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO searchListTotCnt(InspRltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			Integer cnt = sqlSession.selectOne(ENTITY_NAME+".searchListTotCnt", param);
			rtn.setObj(cnt);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO searchInspRsltList(InspRltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			List<InspRltVO> list = sqlSession.selectList(ENTITY_NAME+".searchInspRsltList", param);
			rtn.setObj(list);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO getInspDaySeq(InspRltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			InspRltVO vo = sqlSession.selectOne(ENTITY_NAME+".getInspDaySeq", param);
			rtn.setObj(vo);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	
}
