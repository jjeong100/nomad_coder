package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ProductionActVO;
import org.rnt.com.vo.RtnVO;

public interface ProductionActService {
    public RtnVO getSeq();
    public RtnVO insert(ProductionActVO param);
    public RtnVO select(ProductionActVO param);
    public RtnVO selectByProd(ProductionActVO param);
    public RtnVO selectByProdAndOper(ProductionActVO param);
    public RtnVO update(ProductionActVO param);
    public RtnVO delete(ProductionActVO param);
    public RtnVO searchList(ProductionActVO param);
    public RtnVO searchListTotCnt(ProductionActVO param);
    public RtnVO updatePlcProdSeq(ProductionActVO param);
    public RtnVO selectIngProdSeq(ProductionActVO param);
    public RtnVO updateProdTypeCd(ProductionActVO param);
    public RtnVO searchWorkEquiplist(ProductionActVO param);
    public RtnVO deleteWat(ProductionActVO param);
    public RtnVO updateRevertProdTypeCd(ProductionActVO param);
    public RtnVO updateEndProdTypeCd(ProductionActVO param);
    public RtnVO selectPreSumQty(ProductionActVO param);
    public RtnVO updatePlcEquipByProdSeq(ProductionActVO param);
}
