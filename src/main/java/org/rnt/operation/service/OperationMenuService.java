package org.rnt.operation.service;

import org.rnt.com.entity.vo.BomVO;
import org.rnt.com.vo.RtnVO;
import org.rnt.operation.vo.BomTreeInVO;

public interface OperationMenuService {
    //-------------------------------------------------------------------------
    // BOM : BomTree
    //-------------------------------------------------------------------------
	public RtnVO searchBomTreeList(BomTreeInVO param);
	public RtnVO deleteBomTree(BomVO param);
	public RtnVO confirmBom(BomVO param);
}
