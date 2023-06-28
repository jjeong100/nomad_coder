package org.rnt.report.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.PlcVO;
import org.rnt.com.vo.RtnVO;
import org.rnt.report.vo.ReportDtlVO;
import org.rnt.report.vo.ReportEduVO;
import org.rnt.report.vo.ReportVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("reportDao")
public class ReportDao extends BaseDao {

	@Autowired
	private SqlSession sqlSession;

	public final String MENU_NAME = "reportMenu";

	//-----------------------------------------------------------------------------------------------------------------
	// 리포트마스터
	//-----------------------------------------------------------------------------------------------------------------
	public RtnVO select(ReportVO param) {
		RtnVO rtn = new RtnVO();
		try {
			ReportVO vo = sqlSession.selectOne(MENU_NAME+".select", param);
			rtn.setObj(vo);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	
	public RtnVO selectDtlList(ReportVO param) {
		RtnVO rtn = new RtnVO();
		try {
			List<ReportDtlVO> list = sqlSession.selectList(MENU_NAME+".selectDtlList", param);
			rtn.setObj(list);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	
	//-----------------------------------------------------------------------------------------------------------------
	// 
	//-----------------------------------------------------------------------------------------------------------------
	public RtnVO insert(ReportVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.insert(MENU_NAME+".insert", param);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
		}
		 return rtn;
	}
	public RtnVO update(ReportVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(MENU_NAME+".update", param);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO delete(ReportVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(MENU_NAME+".delete", param);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	
	public RtnVO insertDtl(ReportDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.insert(MENU_NAME+".insertDtl", param);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO updateDtl(ReportDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(MENU_NAME+".updateDtl", param);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO deleteDtl(ReportVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.delete(MENU_NAME+".deleteDtl", param);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	
	//-----------------------------------------------------------------------------------------------------------------
	// 리포트 교육
	//-----------------------------------------------------------------------------------------------------------------
	public RtnVO selectEdu(ReportEduVO param) {
		RtnVO rtn = new RtnVO();
		try {
			ReportEduVO vo = sqlSession.selectOne(MENU_NAME+".selectEdu", param);
			rtn.setObj(vo);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO insertEdu(ReportEduVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.insert(MENU_NAME+".insertEdu", param);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO updateEdu(ReportEduVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(MENU_NAME+".updateEdu", param);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO deleteEdu(ReportEduVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.delete(MENU_NAME+".deleteEdu", param);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	
	//-----------------------------------------------------------------------------------------------------------------
	// plc data 조회
	//-----------------------------------------------------------------------------------------------------------------
	public RtnVO selectPlc(String param) {
		RtnVO rtn = new RtnVO();
		try {
			PlcVO vo = sqlSession.selectOne(MENU_NAME+".selectPlc", param);
			rtn.setObj(vo);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	
}