package org.rnt.com.entity.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.EquipVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("equipDao")
public class EquipDao extends BaseDao {

    protected Log log = LogFactory.getLog(this.getClass());
    
    @Autowired
    private SqlSession sqlSession;

    public final String ENTITY_NAME = "mcc026";

    public RtnVO insert(EquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.insert(ENTITY_NAME+".insert", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage());
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_equip.xml");
        return rtn;
    }
    public RtnVO select(EquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            EquipVO vo = sqlSession.selectOne(ENTITY_NAME+".select", param);
            rtn.setObj(vo);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_equip.xml");
        return rtn;
    }
    public RtnVO update(EquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".update", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage());
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_equip.xml");
        return rtn;
    }
    public RtnVO delete(EquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".delete", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage());
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_equip.xml");
        return rtn;
    }
    public RtnVO searchList(EquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<EquipVO> list = sqlSession.selectList(ENTITY_NAME+".searchList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_equip.xml");
        return rtn;
    }
    
    public RtnVO searchListAutoLine(EquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<EquipVO> list = sqlSession.selectList(ENTITY_NAME+".searchListAutoLine", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_equip.xml");
        return rtn;
    }
    
    public RtnVO searchListNotAutoLine(EquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<EquipVO> list = sqlSession.selectList(ENTITY_NAME+".searchListNotAutoLine", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_equip.xml");
        return rtn;
    }
    
    public RtnVO searchListTotCnt(EquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(ENTITY_NAME+".searchListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_equip.xml");
        return rtn;
    }
}
