package org.rnt.doc.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.BoxVO;
import org.rnt.com.entity.vo.MaterialVO;
import org.rnt.com.vo.RtnVO;
import org.rnt.doc.vo.DocVO;
import org.rnt.summary.vo.EquipSumInVO;
import org.rnt.summary.vo.EquipSumOutVO;
import org.rnt.summary.vo.LotTrackingItemVO;
import org.rnt.summary.vo.LotTrackingMatVO;
import org.rnt.summary.vo.LotTrackingVO;
import org.rnt.summary.vo.ProductionSumVO;
import org.rnt.summary.vo.WorkerMonthSumVO;
import org.rnt.summary.vo.WorkerSumInVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("docDao")
public class DocDao extends BaseDao {

	@Autowired
	private SqlSession sqlSession;

	public final String MENU_NAME = "docMenu";

	//-----------------------------------------------------------------------------------------------------------------
	// 성적서 : searchDocList
	//-----------------------------------------------------------------------------------------------------------------
	public RtnVO searchDocList(DocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			List<EquipSumOutVO> list = sqlSession.selectList(MENU_NAME+".searchDocList", param);
			rtn.setObj(list);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO searchDocListTotCnt(DocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			Integer cnt = sqlSession.selectOne(MENU_NAME+".searchDocListTotCnt", param);
			rtn.setObj(cnt);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	
	public RtnVO select(DocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			DocVO vo = sqlSession.selectOne(MENU_NAME+".select", param);
			rtn.setObj(vo);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	
	public RtnVO insert(DocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.insert(MENU_NAME+".insert", param);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
		}
		 return rtn;
	}
	
	public RtnVO delete(DocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(MENU_NAME+".delete", param);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
		}
		 return rtn;
	}
}