package org.rnt.com.entity.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.OperAuthVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

@Repository("operAuthDao")
public class OperAuthDao extends BaseDao {

    protected Log log = LogFactory.getLog(this.getClass());



    @Autowired
    private SqlSession sqlSession;

    public final String ENTITY_NAME = "mcc035";

    public RtnVO insert(OperAuthVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.insert(ENTITY_NAME+".insert", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("Query >>> sqlmap_oper_auth.xml["+new Object(){}.getClass().getEnclosingMethod().getName()+"]");
         return rtn;
    }
    public RtnVO select(OperAuthVO param) {
        RtnVO rtn = new RtnVO();
        try {
            OperAuthVO vo = sqlSession.selectOne(ENTITY_NAME+".select", param);
            rtn.setObj(vo);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("Query >>> sqlmap_oper_auth.xml["+new Object(){}.getClass().getEnclosingMethod().getName()+"]");
        return rtn;
    }
    public RtnVO update(OperAuthVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".update", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("Query >>> sqlmap_oper_auth.xml["+new Object(){}.getClass().getEnclosingMethod().getName()+"]");
        return rtn;
    }
    public RtnVO delete(OperAuthVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".delete", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("Query >>> sqlmap_oper_auth.xml["+new Object(){}.getClass().getEnclosingMethod().getName()+"]");
        return rtn;
    }
    public RtnVO searchList(OperAuthVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<OperAuthVO> list = sqlSession.selectList(ENTITY_NAME+".searchList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("Query >>> sqlmap_oper_auth.xml["+new Object(){}.getClass().getEnclosingMethod().getName()+"]");
        return rtn;
    }
    public RtnVO searchListTotCnt(OperAuthVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(ENTITY_NAME+".searchListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("Query >>> sqlmap_oper_auth.xml["+new Object(){}.getClass().getEnclosingMethod().getName()+"]");
        return rtn;
    }
    public RtnVO selectWorkerCnt(OperAuthVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(ENTITY_NAME+".selectWorkerCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("Query >>> sqlmap_oper_auth.xml["+new Object(){}.getClass().getEnclosingMethod().getName()+"]");
        return rtn;
    }
}
