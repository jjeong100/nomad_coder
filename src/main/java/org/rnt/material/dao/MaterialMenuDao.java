package org.rnt.material.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.vo.RtnVO;
import org.rnt.material.vo.MonthCloseInVO;
import org.rnt.material.vo.MonthCloseOutVO;
import org.rnt.material.vo.StockInVO;
import org.rnt.material.vo.StockOutVO;
import org.rnt.material.vo.SubulInVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("materialMenuDao")
public class MaterialMenuDao extends BaseDao {

	@Autowired
	private SqlSession sqlSession;

	public final String MENU_NAME = "materialMenu";

	//-----------------------------------------------------------------------------------------------------------------
	// 재고 현황 : Stock
	//-----------------------------------------------------------------------------------------------------------------
	public RtnVO searchStockList(StockInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			List<StockOutVO> list = sqlSession.selectList(MENU_NAME+".searchStockList", param);
			rtn.setObj(list);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO searchStockListTotCnt(StockInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			Integer cnt = sqlSession.selectOne(MENU_NAME+".searchStockListTotCnt", param);
			rtn.setObj(cnt);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
	public RtnVO selectStockMatQtySum(StockInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            String qty = sqlSession.selectOne(MENU_NAME+".selectStockMatQtySum", param);
            rtn.setObj(qty);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        return rtn;
    }

	//-----------------------------------------------------------------------------------------------------------------
    // 수불 현황 : Subul
    //-----------------------------------------------------------------------------------------------------------------
	public RtnVO searchSubulList(SubulInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<StockOutVO> list = sqlSession.selectList(MENU_NAME+".searchSubulList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        return rtn;
    }
    public RtnVO searchSubulListTotCnt(SubulInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchSubulListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        return rtn;
    }


	//-----------------------------------------------------------------------------------------------------------------
    // 월 마감 관리 : MonthClose
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchMonthCloseList(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<MonthCloseOutVO> list = sqlSession.selectList(MENU_NAME+".searchMonthCloseList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        return rtn;
    }
    public RtnVO searchMonthCloseListTotCnt(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchMonthCloseListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        return rtn;
    }

    public RtnVO selectMinUnCloseMonth(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            String minMonth = sqlSession.selectOne(MENU_NAME+".selectMinUnCloseMonth", param);
            rtn.setObj(minMonth);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        return rtn;
    }

    public RtnVO selectMaxCloseMonth(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            String minMonth = sqlSession.selectOne(MENU_NAME+".selectMaxCloseMonth", param);
            rtn.setObj(minMonth);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        return rtn;
    }

    public RtnVO selectMaxCloseMonthAndDiffMonth(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer dffMonth = sqlSession.selectOne(MENU_NAME+".selectMaxCloseMonthAndDiffMonth", param);
            rtn.setObj(dffMonth);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        return rtn;
    }
	public RtnVO searchBaseQty(StockInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			String cnt = sqlSession.selectOne(MENU_NAME+".searchBaseQty", param);
			rtn.setObj(cnt);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
		}
		return rtn;
	}
}
