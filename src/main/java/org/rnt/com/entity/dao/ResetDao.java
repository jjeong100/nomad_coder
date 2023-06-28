package org.rnt.com.entity.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.entity.vo.ResetVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("resetDao")
public class ResetDao extends BaseDao {

	protected Log log = LogFactory.getLog(this.getClass());
	
    @Autowired
    private SqlSession sqlSession;

    public final String ENTITY_NAME = "resetMenu";

    public RtnVO updateTable(ResetVO param,String queryId) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+"."+queryId, param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_reset_menu.xml");
        return rtn;
    }
    
    public RtnVO deleteTable(ResetVO param,String queryId) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.delete(ENTITY_NAME+"."+queryId, param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_reset_menu.xml");
        return rtn;
    }
   
    public RtnVO selectTable(ResetVO param) {
        RtnVO rtn = new RtnVO();
        try {
        	Integer cnt = sqlSession.selectOne(ENTITY_NAME+".selectTable", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_reset_menu.xml");
        return rtn;
    }
    
    

    public RtnVO insert(ResetVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.insert(ENTITY_NAME+".insert", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage());
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_reset_menu.xml");
        return rtn;
    }
    
    public RtnVO searchList(ResetVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<CompanyVO> list = sqlSession.selectList(ENTITY_NAME+".searchList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage());
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_reset_menu.xml");
        return rtn;
    }
}
