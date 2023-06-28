package org.rnt.production.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.ProductionMstActVO;
import org.rnt.com.entity.vo.ProductionOrderVO;
import org.rnt.com.vo.RtnVO;
import org.rnt.material.vo.MonthCloseInVO;
import org.rnt.material.vo.MonthCloseOutVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("productionMenuDao")
public class ProductionMenuDao extends BaseDao {

	@Autowired
	private SqlSession sqlSession;

	public final String MENU_NAME = "productionMenu";

	//-----------------------------------------------------------------------------------------------------------------
	// 재고 현황 : Stock
	//-----------------------------------------------------------------------------------------------------------------
    public RtnVO createMatRequire(ProductionOrderVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.insert(MENU_NAME+".createMatRequire", param);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
        }
         return rtn;
    }
    
    public RtnVO deleteMatRequire(ProductionOrderVO param) {
    	RtnVO rtn = new RtnVO();
    	try {
    		sqlSession.update(MENU_NAME+".deleteMatRequire", param);
    	} catch (Exception e) {
    		return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
    	}
    	return rtn;
    }
    
    public RtnVO createMstAct(ProductionOrderVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.insert(MENU_NAME+".createMstAct", param);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
        }
         return rtn;
    }
    
    public RtnVO deleteMstAct(ProductionOrderVO param) {
    	RtnVO rtn = new RtnVO();
    	try {
    		sqlSession.update(MENU_NAME+".deleteMstAct", param);
    	} catch (Exception e) {
    		return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
    	}
    	return rtn;
    }
    
    public RtnVO productionOperList(ProductionMstActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<ProductionMstActVO> list = sqlSession.selectList(MENU_NAME+".productionOperList", param);
            rtn.setObj(list);
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
}
