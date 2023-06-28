package org.rnt.com.entity.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.EquipMtnVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("equipMtnDao")
public class EquipMtnDao extends BaseDao {

	@Autowired
	private SqlSession sqlSession;

	public final String ENTITY_NAME = "mcc027";

	public RtnVO insert(EquipMtnVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.insert(ENTITY_NAME+".insert", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage());
		}
		 return rtn;
	}
	public RtnVO select(EquipMtnVO param) {
		RtnVO rtn = new RtnVO();
		try {
			EquipMtnVO vo = sqlSession.selectOne(ENTITY_NAME+".select", param);
			rtn.setObj(vo);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO update(EquipMtnVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(ENTITY_NAME+".update", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO delete(EquipMtnVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(ENTITY_NAME+".delete", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO searchList(EquipMtnVO param) {
		RtnVO rtn = new RtnVO();
		try {
			List<EquipMtnVO> list = sqlSession.selectList(ENTITY_NAME+".searchList", param);
			rtn.setObj(list);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO searchListTotCnt(EquipMtnVO param) {
		RtnVO rtn = new RtnVO();
		try {
			Integer cnt = sqlSession.selectOne(ENTITY_NAME+".searchListTotCnt", param);
			rtn.setObj(cnt);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
}
