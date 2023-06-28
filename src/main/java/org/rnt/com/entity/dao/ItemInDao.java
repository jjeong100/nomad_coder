package org.rnt.com.entity.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.ItemInVO;
import org.rnt.com.vo.RtnVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("itemInDao")
public class ItemInDao extends BaseDao {

    @Autowired
    private SqlSession sqlSession;

    public final String ENTITY_NAME = "mwp012";
    
    public RtnVO insert(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.insert(ENTITY_NAME+".insert", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
        }
         return rtn;
    }
    
    public RtnVO select(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            ItemInVO vo = sqlSession.selectOne(ENTITY_NAME+".select", param);
            rtn.setObj(vo);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        return rtn;
    }
    
    public RtnVO selectProdOrderInfo(ItemInVO param) {
    	RtnVO rtn = new RtnVO();
    	try {
    		ItemInVO vo = sqlSession.selectOne(ENTITY_NAME+".selectProdOrderInfo", param);
    		rtn.setObj(vo);
    	} catch (Exception e) {
    		return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
    	}
    	return rtn;
    }
    
    public RtnVO selectByLotId(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            ItemInVO vo = sqlSession.selectOne(ENTITY_NAME+".selectByLotId", param);
            rtn.setObj(vo);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        return rtn;
    }
    
    public RtnVO update(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".update", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        return rtn;
    }
    
    public RtnVO delete(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(ENTITY_NAME+".delete", param);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        return rtn;
    }
    
    public RtnVO searchList(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<ItemInVO> list = sqlSession.selectList(ENTITY_NAME+".searchList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        return rtn;
    }
    
    public RtnVO searchListTotCnt(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            Integer cnt = sqlSession.selectOne(ENTITY_NAME+".searchListTotCnt", param);
            rtn.setObj(cnt);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        return rtn;
    }
    
    
    public RtnVO selectPopItemInList(ItemInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            List<ItemInVO> list = sqlSession.selectList(ENTITY_NAME+".selectPopItemInList", param);
            rtn.setObj(list);
        } catch (Exception e) {
            return setRtnVO(rtn, ENTITY_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
        }
        return rtn;
    }
}
