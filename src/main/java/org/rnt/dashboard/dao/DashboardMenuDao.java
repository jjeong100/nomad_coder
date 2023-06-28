package org.rnt.dashboard.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.ProductionActVO;
import org.rnt.com.entity.vo.ProductionOrderVO;
import org.rnt.com.vo.RtnVO;
import org.rnt.dashboard.vo.DashboardEquipSumVO;
import org.rnt.dashboard.vo.DashboardProductionChartVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dashboardMenuDao")
public class DashboardMenuDao extends BaseDao {

    protected Log log = LogFactory.getLog(this.getClass());
    
    @Autowired
    private SqlSession sqlSession;

    public final String MENU_NAME = "dashboardMenu";

    public RtnVO dashboardEquipSummary() {
        RtnVO rtn = new RtnVO();
        try {
            DashboardEquipSumVO obj = sqlSession.selectOne(MENU_NAME+".dashboardEquipSummary");
            rtn.setObj(obj);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_dashboard_menu.xml");
        return rtn;
    }
    
    public RtnVO dashboardAutoEquipSummary() {
        RtnVO rtn = new RtnVO();
        try {
            DashboardEquipSumVO obj = sqlSession.selectOne(MENU_NAME+".dashboardAutoEquipSummary");
            rtn.setObj(obj);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_dashboard_menu.xml");
        return rtn;
    }
    
    public RtnVO dashboardProductionChart(DashboardProductionChartVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<DashboardProductionChartVO> list = sqlSession.selectList(MENU_NAME+".dashboardProductionChart",param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_dashboard_menu.xml");
        return rtn;
    }
    
    public RtnVO dashboardProductionChartTotCnt(ProductionOrderVO param) {
    	RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".dashboardProductionChartTotCnt",param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_dashboard_menu.xml");
        return rtn;
    }
    
    public RtnVO dashboardAutoEquipChart(DashboardProductionChartVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<DashboardProductionChartVO> list = sqlSession.selectList(MENU_NAME+".dashboardAutoEquipChart",param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_dashboard_menu.xml");
        return rtn;
    }
    
    public RtnVO getDashboardProductionActWaitList() {
        RtnVO rtn = new RtnVO();
        try {
            List<ProductionActVO> list = sqlSession.selectList(MENU_NAME+".getDashboardProductionActWaitList");
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_dashboard_menu.xml");
        return rtn;
    }
    
    public RtnVO getDashboardProductionActIngList() {
        RtnVO rtn = new RtnVO();
        try {
            List<ProductionActVO> list = sqlSession.selectList(MENU_NAME+".getDashboardProductionActIngList");
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_dashboard_menu.xml");
        return rtn;
    }
}
