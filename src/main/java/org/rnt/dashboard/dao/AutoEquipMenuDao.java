package org.rnt.dashboard.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.vo.RtnVO;
import org.rnt.dashboard.vo.AutoEquipVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("autoEquipMenuDao")
public class AutoEquipMenuDao extends BaseDao {

    protected Log log = LogFactory.getLog(this.getClass());
    
    @Autowired
    private SqlSession sqlSession;

    public final String MENU_NAME = "auto_equip_menu";

    public RtnVO searchFrontAutoEquipList(AutoEquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<AutoEquipVO> list = sqlSession.selectList(MENU_NAME+".searchFrontAutoEquipList",param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_auto_equip_menu.xml");
        return rtn;
    }
    
    public RtnVO searchFrontAutoEquipListTotCnt(AutoEquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchFrontAutoEquipListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
        	return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_auto_equip_menu.xml");
        return rtn;
    }
    
    public RtnVO searchRearAutoEquipList(AutoEquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<AutoEquipVO> list = sqlSession.selectList(MENU_NAME+".searchRearAutoEquipList",param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_auto_equip_menu.xml");
        return rtn;
    }
    
    public RtnVO searchRearAutoEquipListTotCnt(AutoEquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(MENU_NAME+".searchRearAutoEquipListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
        	return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_auto_equip_menu.xml");
        return rtn;
    }
    
    public RtnVO searchFrontAutoEquipSummary(AutoEquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
        	AutoEquipVO obj = sqlSession.selectOne(MENU_NAME+".searchFrontAutoEquipSummary",param);
            rtn.setObj(obj);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_auto_equip_menu.xml");
        return rtn;
    }
	 
	public RtnVO searchFrontAutoEquipChart(AutoEquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<AutoEquipVO> list = sqlSession.selectList(MENU_NAME+".searchFrontAutoEquipChart",param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_auto_equip_menu.xml");
        return rtn;
    }
	
	public RtnVO searchRearAutoEquipSummary(AutoEquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
        	AutoEquipVO obj = sqlSession.selectOne(MENU_NAME+".searchRearAutoEquipSummary",param);
            rtn.setObj(obj);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_auto_equip_menu.xml");
        return rtn;
    }
	 
	public RtnVO searchRearAutoEquipChart(AutoEquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<AutoEquipVO> list = sqlSession.selectList(MENU_NAME+".searchRearAutoEquipChart",param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_auto_equip_menu.xml");
        return rtn;
    }
	
	
	public RtnVO selectItemImage(AutoEquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
        	AutoEquipVO obj = sqlSession.selectOne(MENU_NAME+".selectItemImage",param);
            rtn.setObj(obj);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_auto_equip_menu.xml");
        return rtn;
    }
}
