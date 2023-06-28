package org.rnt.com.entity.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.MatRequireVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("matRequireDao")
public class MatRequireDao extends BaseDao {

    protected Log log = LogFactory.getLog(this.getClass());
    
    @Autowired
    private SqlSession sqlSession;

    public final String ENTITY_NAME = "mpo007";

    public RtnVO insert(MatRequireVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.insert(ENTITY_NAME+".insert", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_mat_require.xml");
        return rtn;
    }
    public RtnVO select(MatRequireVO param) {
        RtnVO rtn = new RtnVO();
        try {
            MatRequireVO vo = sqlSession.selectOne(ENTITY_NAME+".select", param);
            rtn.setObj(vo);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_mat_require.xml");
        return rtn;
    }
    public RtnVO update(MatRequireVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".update", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_mat_require.xml");
        return rtn;
    }
    public RtnVO delete(MatRequireVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".delete", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_mat_require.xml");
        return rtn;
    }
    public RtnVO searchList(MatRequireVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<MatRequireVO> list = sqlSession.selectList(ENTITY_NAME+".searchList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_mat_require.xml");
        return rtn;
    }
    public RtnVO searchListTotCnt(MatRequireVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(ENTITY_NAME+".searchListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_mat_require.xml");
        return rtn;
    }
    public RtnVO searchRequireMatList(MatRequireVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<MatRequireVO> list = sqlSession.selectList(ENTITY_NAME+".searchRequireMatList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_mat_require.xml");
        return rtn;
    }
    
    public RtnVO searchMatRequireList(MatRequireVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<MatRequireVO> list = sqlSession.selectList(ENTITY_NAME+".searchMatRequireList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_mat_require.xml");
        return rtn;
    }
    
    public RtnVO searchRequireMatListByChildProdSeq(MatRequireVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<MatRequireVO> list = sqlSession.selectList(ENTITY_NAME+".searchRequireMatListByChildProdSeq", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_mat_require.xml");
        return rtn;
    }
}
