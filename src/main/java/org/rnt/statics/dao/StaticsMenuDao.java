package org.rnt.statics.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.vo.RtnVO;
import org.rnt.statics.vo.DeliveryStaticsInVO;
import org.rnt.statics.vo.DeliveryStaticsOutVO;
import org.rnt.statics.vo.EquipStaticsInVO;
import org.rnt.statics.vo.EquipStaticsOutVO;
import org.rnt.statics.vo.EquipStaticsOutVO2;
import org.rnt.statics.vo.QualityStaticsInVO;
import org.rnt.statics.vo.QualityStaticsOutVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("staticsMenuDao")
public class StaticsMenuDao extends BaseDao {

    protected Log log = LogFactory.getLog(this.getClass());
    
    @Autowired
    private SqlSession sqlSession;

    public final String MENU_NAME = "staticsMenu";

    //-----------------------------------------------------------------------------------------------------------------
    // 설비실적 : equipSumList
    //-----------------------------------------------------------------------------------------------------------------
    public RtnVO searchEquipStaticsList(EquipStaticsInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<EquipStaticsOutVO> list = sqlSession.selectList(MENU_NAME+".searchEquipStaticsList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_statics_menu.xml");
        return rtn;
    }
    
    
     public RtnVO searchEquipStaticsListTotCnt(EquipStaticsInVO param)  {
            RtnVO rtn = new RtnVO();
            try {
                Integer cnt = sqlSession.selectOne(MENU_NAME+".searchEquipStaticsListTotCnt", param);
                rtn.setObj(cnt);
            } catch (Exception e) {
                return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
            }
            /** 쿼리 위치 **/
            log.debug("■ Query : sqlmap_statics_menu.xml");
            return rtn;
        }
    
    public RtnVO selectEquipTotStatics(EquipStaticsInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            EquipStaticsOutVO2 obj = sqlSession.selectOne(MENU_NAME+".selectEquipTotStatics", param);
            rtn.setObj(obj);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_statics_menu.xml");
        return rtn;
    }
    
    public RtnVO searchQualityStaticsList(QualityStaticsInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<QualityStaticsOutVO> list = sqlSession.selectList(MENU_NAME+".searchQualityStaticsList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_statics_menu.xml");
        return rtn;
    }
    
    public RtnVO selectQualityTotStatics(QualityStaticsInVO param) {
        RtnVO rtn = new RtnVO();
        try {
        	QualityStaticsInVO obj = sqlSession.selectOne(MENU_NAME+".selectQualityTotStatics", param);
            rtn.setObj(obj);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_statics_menu.xml");
        return rtn;
    }
    
    public RtnVO searchDeliveryStaticsList(DeliveryStaticsInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<DeliveryStaticsOutVO> list = sqlSession.selectList(MENU_NAME+".searchDeliveryStaticsList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_statics_menu.xml");
        return rtn;
    }
    
    public RtnVO selectDeliveryTotStatics(DeliveryStaticsInVO param) {
        RtnVO rtn = new RtnVO();
        try {
        	DeliveryStaticsOutVO obj = sqlSession.selectOne(MENU_NAME+".selectDeliveryTotStatics", param);
            rtn.setObj(obj);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_statics_menu.xml");
        return rtn;
    }
}