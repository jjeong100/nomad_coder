package org.rnt.com.entity.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.ItemOutMstVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("itemOutMstDao")
public class ItemOutMstDao extends BaseDao {

	@Autowired
	private SqlSession sqlSession;

	public final String ENTITY_NAME = "mwp015";

	public RtnVO getSeq() {
		RtnVO rtn = new RtnVO();
		try {
			String seq = sqlSession.selectOne(ENTITY_NAME+".getSeq");
			rtn.setObj(seq);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}

	public RtnVO getLotId() {
		RtnVO rtn = new RtnVO();
		try {
			String seq = sqlSession.selectOne(ENTITY_NAME+".getLotId");
			rtn.setObj(seq);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}

	public RtnVO insert(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.insert(ENTITY_NAME+".insert", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage());
		}
		 return rtn;
	}
	public RtnVO select(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			ItemOutMstVO vo = sqlSession.selectOne(ENTITY_NAME+".select", param);
			rtn.setObj(vo);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO update(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(ENTITY_NAME+".update", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO delete(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(ENTITY_NAME+".delete", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO searchList(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			List<ItemOutMstVO> list = sqlSession.selectList(ENTITY_NAME+".searchList", param);
			rtn.setObj(list);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO searchListTotCnt(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			Integer cnt = sqlSession.selectOne(ENTITY_NAME+".searchListTotCnt", param);
			rtn.setObj(cnt);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO searchItemInList(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			List<ItemOutMstVO> list = sqlSession.selectList(ENTITY_NAME+".searchItemInList", param);
			rtn.setObj(list);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO searchItemInListTotCnt(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			Integer cnt = sqlSession.selectOne(ENTITY_NAME+".searchItemInListTotCnt", param);
			rtn.setObj(cnt);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO searchMstList(ItemOutMstVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<ItemOutMstVO> list = sqlSession.selectList(ENTITY_NAME+".searchMstList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        return rtn;
    }
    public RtnVO searchMstListTotCnt(ItemOutMstVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(ENTITY_NAME+".searchMstListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        return rtn;
    }
    public RtnVO selectMstOut(ItemOutMstVO param) {
    	RtnVO rtn = new RtnVO();
    	try {
    		ItemOutMstVO vo = sqlSession.selectOne(ENTITY_NAME+".selectMstOut", param);
    		rtn.setObj(vo);
    	} catch (Exception e) {
    		return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
    	}
    	return rtn;
    }
    public RtnVO searchStorkQty(ItemOutMstVO param) {
    	RtnVO rtn = new RtnVO();
    	try {
    		List<ItemOutMstVO> list = sqlSession.selectList(ENTITY_NAME+".searchStorkQty", param);
    		rtn.setObj(list);
    	} catch (Exception e) {
    		return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
    	}
    	return rtn;
    }
    public RtnVO searchItemOutList(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			List<ItemOutMstVO> list = sqlSession.selectList(ENTITY_NAME+".searchItemOutList", param);
			rtn.setObj(list);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}

	public RtnVO updateOutSet(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.update(ENTITY_NAME+".updateOutSet", param);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage());
		}
		return rtn;
	}

	public RtnVO selectByLotId(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			ItemOutMstVO vo = sqlSession.selectOne(ENTITY_NAME+".selectByLotId", param);
			rtn.setObj(vo);
		} catch (Exception e) {
			return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}

}
