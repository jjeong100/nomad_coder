package org.rnt.com.entity.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.MaterialOutVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("materialOutDao")
public class MaterialOutDao extends BaseDao {

	@Autowired
	private SqlSession sqlSession;

	public final String ENTITY_NAME = "mma024";

	public RtnVO insert(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.insert(ENTITY_NAME+".insert", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
		}
		 return rtn;
	}
	public RtnVO select(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			MaterialOutVO vo = sqlSession.selectOne(ENTITY_NAME+".select", param);
			rtn.setObj(vo);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO update(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(ENTITY_NAME+".update", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO delete(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(ENTITY_NAME+".delete", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO searchList(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			List<MaterialOutVO> list = sqlSession.selectList(ENTITY_NAME+".searchList", param);
			rtn.setObj(list);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO searchListTotCnt(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			Integer cnt = sqlSession.selectOne(ENTITY_NAME+".searchListTotCnt", param);
			rtn.setObj(cnt);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO checkMaterialOut(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			Integer cnt = sqlSession.selectOne(ENTITY_NAME+".checkMaterialOut", param);
			rtn.setObj(cnt);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO checkMatOutEndYn(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			String endYn = sqlSession.selectOne(ENTITY_NAME+".checkMatOutEndYn", param);
			rtn.setObj(endYn);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
}
