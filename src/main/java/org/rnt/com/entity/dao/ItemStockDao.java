package org.rnt.com.entity.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.ItemStockVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("itemStockDao")
public class ItemStockDao extends BaseDao {

	@Autowired
	private SqlSession sqlSession;

	public final String ENTITY_NAME = "itemMenu";

	public RtnVO searchItemStockList(ItemStockVO param) {
		RtnVO rtn = new RtnVO();
		try {
			List<ItemStockVO> list = sqlSession.selectList(ENTITY_NAME+".searchItemStockList", param);
			rtn.setObj(list);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO searchItemStockListTotCnt(ItemStockVO param) {
		RtnVO rtn = new RtnVO();
		try {
			Integer cnt = sqlSession.selectOne(ENTITY_NAME+".searchItemStockListTotCnt", param);
			rtn.setObj(cnt);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO searchBaseQty(ItemStockVO param) {
		RtnVO rtn = new RtnVO();
		try {
			String cnt = sqlSession.selectOne(ENTITY_NAME+".searchBaseQty", param);
			rtn.setObj(cnt);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
}
