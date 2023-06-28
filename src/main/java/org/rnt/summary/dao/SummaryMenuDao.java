package org.rnt.summary.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.vo.RtnVO;
import org.rnt.summary.vo.AssignSumVO;
import org.rnt.summary.vo.EquipSumInVO;
import org.rnt.summary.vo.EquipSumOutVO;
import org.rnt.summary.vo.FailureSumVO;
import org.rnt.summary.vo.ItemSumVO;
import org.rnt.summary.vo.LotTrackingItemVO;
import org.rnt.summary.vo.LotTrackingMatVO;
import org.rnt.summary.vo.LotTrackingVO;
import org.rnt.summary.vo.OperSumVO;
import org.rnt.summary.vo.ProductionSumVO;
import org.rnt.summary.vo.SafetyStockVO;
import org.rnt.summary.vo.WorkOrderBySumVO;
import org.rnt.summary.vo.WorkerMonthSumVO;
import org.rnt.summary.vo.WorkerSumInVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("summaryMenuDao")
public class SummaryMenuDao extends BaseDao {
    
    protected Log log = LogFactory.getLog(this.getClass());

    @Autowired
    private SqlSession sqlSession;

    public final String MENU_NAME = "summaryMenu";

    //-----------------------------------------------------------------------------------------------------------------
    // 설비실적 : equipSumList
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchEquipSumList(EquipSumInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<EquipSumOutVO> list = sqlSession.selectList(MENU_NAME+".searchEquipSumList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchEquipSumListTotCnt(EquipSumInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchEquipSumListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    //-----------------------------------------------------------------------------------------------------------------
    // 월별설비실적 : equipMonthSumList
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchEquipMonthSumList(EquipSumInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<EquipSumOutVO> list = sqlSession.selectList(MENU_NAME+".searchEquipMonthSumList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchEquipMonthSumListTotCnt(EquipSumInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchEquipMonthSumListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    //-----------------------------------------------------------------------------------------------------------------
    //  작업자실적 : workerSumList
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchWorkerSumList(WorkerSumInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<WorkerSumInVO> list = sqlSession.selectList(MENU_NAME+".searchWorkerSumList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchWorkerSumListTotCnt(WorkerSumInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchWorkerSumListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    //-----------------------------------------------------------------------------------------------------------------
    // 작업지시현황 : equipSumList
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchProductionSumList(ProductionSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<ProductionSumVO> list = sqlSession.selectList(MENU_NAME+".searchProductionSumList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchProductionSumListTotCnt(ProductionSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchProductionSumListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    //-----------------------------------------------------------------------------------------------------------------
    // 월별작업자실적 : searchMonthSumList
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchMonthSumList(WorkerMonthSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<WorkerMonthSumVO> list = sqlSession.selectList(MENU_NAME+".searchMonthSumList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchMonthSumListTotCnt(WorkerMonthSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchMonthSumListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    //-----------------------------------------------------------------------------------------------------------------
    // Lot Tracking : searchLotTrackingItemList
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchLotTrackingItemList(LotTrackingVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<LotTrackingItemVO> list = sqlSession.selectList(MENU_NAME+".searchLotTrackingItemList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchLotTrackingMatList(LotTrackingVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<LotTrackingMatVO> list = sqlSession.selectList(MENU_NAME+".searchLotTrackingMatList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchLotTrackingWorkSumList(LotTrackingVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<LotTrackingMatVO> list = sqlSession.selectList(MENU_NAME+".searchLotTrackingWorkSumList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchLotTrackingItemOutList(LotTrackingVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<LotTrackingMatVO> list = sqlSession.selectList(MENU_NAME+".searchLotTrackingItemOutList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    //-----------------------------------------------------------------------------------------------------------------
    // 안전재고 : searchSafetyStockList
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchSafetyStockList(SafetyStockVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<SafetyStockVO> list = sqlSession.selectList(MENU_NAME+".searchSafetyStockList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchSafetyStockListTotCnt(SafetyStockVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchSafetyStockListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    //-----------------------------------------------------------------------------------------------------------------
    // 작지별 생산현황
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchWorkOrderBySumList(WorkOrderBySumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<WorkOrderBySumVO> list = sqlSession.selectList(MENU_NAME+".searchWorkOrderBySumList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchWorkOrderBySumListTotCnt(WorkOrderBySumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchWorkOrderBySumListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    //-----------------------------------------------------------------------------------------------------------------
    // 공정 현황
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchOperSumList(OperSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<OperSumVO> list = sqlSession.selectList(MENU_NAME+".searchOperSumList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchOperSumListTotCnt(OperSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchOperSumListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    //-----------------------------------------------------------------------------------------------------------------
    // 제품 현황
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchItemSumList(ItemSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<ItemSumVO> list = sqlSession.selectList(MENU_NAME+".searchItemSumList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchItemSumListTotCnt(ItemSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchItemSumListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    //-----------------------------------------------------------------------------------------------------------------
    // 품질 현황
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchFailureSumList(FailureSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<FailureSumVO> list = sqlSession.selectList(MENU_NAME+".searchFailureSumList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchFailureSumListTotCnt(FailureSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchFailureSumListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    //-----------------------------------------------------------------------------------------------------------------
    // 배정 현황
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchAssignSumList(AssignSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<AssignSumVO> list = sqlSession.selectList(MENU_NAME+".searchAssignSumList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
    
    public RtnVO searchAssignSumListTotCnt(AssignSumVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchAssignSumListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_summary_menu.xml");
        return rtn;
    }
}