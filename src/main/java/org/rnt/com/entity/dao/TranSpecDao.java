package org.rnt.com.entity.dao;

import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.TranSpecVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("tranSpecDao")
public class TranSpecDao extends BaseDao {

	@Autowired
	private SqlSession sqlSession;

	public final String ENTITY_NAME = "mcp001";
	
	public RtnVO selectCompany(TranSpecVO param) {
		RtnVO rtn = new RtnVO();
		try {
			TranSpecVO vo = sqlSession.selectOne(ENTITY_NAME+".selectCompany", param);
			rtn.setObj(vo);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
}
