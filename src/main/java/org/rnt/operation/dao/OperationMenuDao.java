package org.rnt.operation.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.rnt.com.GlvConst;
import org.rnt.com.dao.BaseDao;
import org.rnt.com.entity.vo.BomVO;
import org.rnt.com.vo.RtnVO;
import org.rnt.material.vo.StockOutVO;
import org.rnt.operation.vo.BomTreeInVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("operationMenuDao")
public class OperationMenuDao extends BaseDao {

	@Autowired
	private SqlSession sqlSession;

	public final String MENU_NAME = "operationMenu";

	//-----------------------------------------------------------------------------------------------------------------
	// BOM 관리 : Bom
	//-----------------------------------------------------------------------------------------------------------------
	public RtnVO searchBomTreeList(BomTreeInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			List<StockOutVO> list = sqlSession.selectList(MENU_NAME+".searchBomTreeList", param);
			rtn.setObj(list);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	
	public RtnVO deleteBomTree(BomVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(MENU_NAME+".deleteBomTree", param);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        return rtn;
    }
	
	
	public RtnVO getBomVer(String param) {
		RtnVO rtn = new RtnVO();
		try {
			String seq = sqlSession.selectOne(MENU_NAME+".getBomVer", param);
			rtn.setObj(seq);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	
	
	public RtnVO updateBomVer(BomVO param) {
        RtnVO rtn = new RtnVO();
        try {
            sqlSession.update(MENU_NAME+".updateBomVer", param);
        } catch (Exception e) {
            return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_UPD_ERR_MSG, e.getMessage()); 
        }
        return rtn;
    }
	
	public RtnVO getBomHisSeq() {
		RtnVO rtn = new RtnVO();
		try {
			String seq = sqlSession.selectOne(MENU_NAME+".getBomHisSeq");
			rtn.setObj(seq);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_SEL_ERR_MSG, e.getMessage()); 
		}
		return rtn;
	}
	
	public RtnVO insertBomBackUp(BomVO param) {
		RtnVO rtn = new RtnVO();
		try {
			sqlSession.insert(MENU_NAME+".insertBomBackUp", param);
		} catch (Exception e) {
			return setRtnVO(rtn, MENU_NAME+GlvConst.STR_SPACE+GlvConst.RC_DB_CRE_ERR_MSG, e.getMessage()); 
		}
		 return rtn;
	}
	
	
}