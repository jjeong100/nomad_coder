package org.rnt.com.entity.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.ProductionActVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("productionActDao")
public class ProductionActDao extends BaseDao {

	protected Log log = LogFactory.getLog(this.getClass());
	
    @Autowired
    private SqlSession sqlSession;

    public final String ENTITY_NAME = "mpo011";
    
    public RtnVO getSeq() {
        RtnVO rtn = new RtnVO();
        try {
            String seq = sqlSession.selectOne(ENTITY_NAME+".getSeq");
            rtn.setObj(seq);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }

    public RtnVO insert(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.insert(ENTITY_NAME+".insert", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    public RtnVO select(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            ProductionActVO vo = sqlSession.selectOne(ENTITY_NAME+".select", param);
            rtn.setObj(vo);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    
    public RtnVO isSelect(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            ProductionActVO vo = sqlSession.selectOne(ENTITY_NAME+".isSelect", param);
            rtn.setObj(vo);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    
    public RtnVO selectByProdAndOper(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            ProductionActVO vo = sqlSession.selectOne(ENTITY_NAME+".selectByProdAndOper", param);
            rtn.setObj(vo);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    public RtnVO selectByProd(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            ProductionActVO vo = sqlSession.selectOne(ENTITY_NAME+".selectByProd", param);
            rtn.setObj(vo);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    public RtnVO update(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".update", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    public RtnVO delete(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".delete", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    public RtnVO searchList(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<ProductionActVO> list = sqlSession.selectList(ENTITY_NAME+".searchList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    public RtnVO searchListTotCnt(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(ENTITY_NAME+".searchListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    
    public RtnVO updatePlcProdSeq(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".updatePlcProdSeq", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    public RtnVO selectIngProdSeq(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            ProductionActVO vo = sqlSession.selectOne(ENTITY_NAME+".selectIngProdSeq", param);
            rtn.setObj(vo);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    public RtnVO updateProdTypeCd(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".updateProdTypeCd", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    
    public RtnVO searchWorkEquiplist(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<ProductionActVO> list = sqlSession.selectList(ENTITY_NAME+".selectWorkEquiplist", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    
    public RtnVO deleteWat(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".deleteWat", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    
    public RtnVO updateRevertProdTypeCd(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".updateRevertProdTypeCd", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    
    public RtnVO updateEndProdTypeCd(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".updateEndProdTypeCd", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    public RtnVO selectPreSumQty(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            ProductionActVO vo = sqlSession.selectOne(ENTITY_NAME+".selectPreSumQty", param);
            rtn.setObj(vo);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
    
    public RtnVO updatePlcEquipByProdSeq(ProductionActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".updatePlcEquipByProdSeq", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        /** 쿼리 위치 **/
        log.debug("■ Query : sqlmap_production_act.xml");
        return rtn;
    }
}
