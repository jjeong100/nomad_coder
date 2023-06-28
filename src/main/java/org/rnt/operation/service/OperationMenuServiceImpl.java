package org.rnt.operation.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.rnt.com.GlvConst;
import org.rnt.com.entity.dao.BomHistoryDao;
import org.rnt.com.entity.dao.ProductDao;
import org.rnt.com.entity.vo.BomHistoryVO;
import org.rnt.com.entity.vo.BomVO;
import org.rnt.com.entity.vo.ProductVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.rnt.com.vo.TreeMenuVO;
import org.rnt.com.vo.TreeStateVO;
import org.rnt.operation.dao.OperationMenuDao;
import org.rnt.operation.vo.BomTreeInVO;
import org.rnt.operation.vo.BomTreeOutVO;
import org.springframework.stereotype.Service;

@Service("operationMenuService")
public class OperationMenuServiceImpl extends BaseService implements OperationMenuService {

	@Resource(name="operationMenuDao")
	private OperationMenuDao operationMenuDao;
	
	@Resource(name="bomHistoryDao")
	private BomHistoryDao bomHistoryDao;
	
	@Resource(name="productDao")
	private ProductDao productDao;
	

	@Override
	public RtnVO searchBomTreeList(BomTreeInVO param) {
		RtnVO rtn = new RtnVO();
		Map<String, List<TreeMenuVO>> map = new HashMap<String, List<TreeMenuVO>>();
        Map<String, TreeMenuVO> myMap = new HashMap<String, TreeMenuVO>();
		try {
			rtn = operationMenuDao.searchBomTreeList(param);
			if (rtn.getRc() != GlvConst.RC_SUCC) {
			    setRtnVO(rtn, "BOM 트리 정보 조회 실패", null);
			    return rtn;
			}
            List<BomTreeOutVO> list = (List<BomTreeOutVO>) rtn.getObj();
            
            TreeMenuVO root = new TreeMenuVO();
            root.setId("0");
            root.setText("Top");
            root.setState(new TreeStateVO());
            myMap.put("0", root);
            for (int i=0; i<list.size(); i++) {
                BomTreeOutVO vo = (BomTreeOutVO)list.get(i);
                if (vo.getBomLevel() == 0) {
                    vo.setOperUpcdSeq("0");
                }
                if (!myMap.containsKey(vo.getOperSeq())) {
                    TreeMenuVO tree = new TreeMenuVO();
                    tree.setId(vo.getOperSeq());
                    tree.setText(vo.getOperNm()+"("+vo.getOperCd()+")");
                    tree.setState(new TreeStateVO());
                    tree.setItemCd(vo.getItemCd());
                    myMap.put(vo.getOperSeq(), tree);
                }
                if (map.containsKey(vo.getOperUpcdSeq())) {
                    List<TreeMenuVO> c = map.get(vo.getOperUpcdSeq());
                    TreeMenuVO thisConcept = myMap.get(vo.getOperSeq());
                    c.add(thisConcept);
                } else {
                    List<TreeMenuVO> childs = new ArrayList<TreeMenuVO>();
                    TreeMenuVO thisConcept = myMap.get(vo.getOperSeq());
                    childs.add(thisConcept);
                    map.put(vo.getOperUpcdSeq(), childs);
                    TreeMenuVO upConcept = myMap.get(vo.getOperUpcdSeq());
                    upConcept.setChildren(childs);
                }
            }
            rtn.setObj(root);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
        
		return rtn;
	}
	
	@Override
    public RtnVO deleteBomTree(BomVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = operationMenuDao.deleteBomTree(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
	
	@Override
    public RtnVO confirmBom(BomVO param) {
        RtnVO rtn = new RtnVO();
        try {
        	RtnVO bomVerRtn = operationMenuDao.getBomVer(param.getItemCd());
        	param.setBomVer((String)bomVerRtn.getObj());
        	
            rtn = operationMenuDao.updateBomVer(param);
            if (rtn.getRc() == GlvConst.RC_ERROR) {
            	setRtnVO(rtn, null, "bom version update fail !!");
            	return rtn;
            }
            RtnVO seqRtn = operationMenuDao.getBomHisSeq();
            param.setBomHisSeq((String)seqRtn.getObj());
            
            BomHistoryVO bomHistory = new BomHistoryVO();
            bomHistory.setFactoryCd(param.getFactoryCd());
            bomHistory.setItemCd(param.getItemCd());
            bomHistory.setBomHisSeq(param.getBomHisSeq());
            bomHistory.setBomVer(param.getBomVer());
            bomHistory.setBomStdt(param.getBomStdt());
            bomHistory.setBomBigo(param.getBomBigo());
            bomHistory.setWriteId(param.getWriteId());
            bomHistory.setUpdateId(param.getUpdateId());
            bomHistoryDao.insert(bomHistory);

            rtn = operationMenuDao.insertBomBackUp(param);
            if (rtn.getRc() == GlvConst.RC_ERROR) {
            	setRtnVO(rtn, null, "bom version update fail !!");
            	return rtn;
            }
            
            ProductVO product = new ProductVO();
            product.setFactoryCd(param.getFactoryCd());
            product.setItemCd(param.getItemCd());
            product.setWriteId(param.getWriteId());
            product.setUpdateId(param.getUpdateId());
            product.setBomVer(param.getBomVer());
            rtn = productDao.update(product);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

}
