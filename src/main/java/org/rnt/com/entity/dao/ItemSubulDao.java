package org.rnt.com.entity.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.ItemSubulVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("itemSubulDao")
public class ItemSubulDao extends BaseDao {

	@Autowired
	private SqlSession sqlSession;

	public final String ENTITY_NAME = "itemMenu";
	
	public RtnVO searchItemSubulList(ItemSubulVO param) {
		RtnVO rtn = new RtnVO();
		try {
			List<ItemSubulVO> list = sqlSession.selectList(ENTITY_NAME+".searchItemSubulList", param);
			rtn.setObj(list);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	public RtnVO searchItemSubulListTotCnt(ItemSubulVO param) {
		RtnVO rtn = new RtnVO();
		try {
			Integer cnt = sqlSession.selectOne(ENTITY_NAME+".searchItemSubulListTotCnt", param);
			rtn.setObj(cnt);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
}
